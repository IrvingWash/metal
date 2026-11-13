#scope_module

// A quirk! We put BLEND-CULL.NONE and BLEND-CULL.BACK into one bucket for sorting. This is handled in the shader (enforced by specialization info).

Model_Pass :: struct {
    pipeline_info: Pbr_Pipeline_Info;

    model_draw_requests:  [..]Model_Draw_Request;
    ordered_draw_buckets: [5]Model_Draw_Bucket;

    instance_buffer_infos:    [FRAMES_IN_FLIGHT_COUNT]Buffer_Info;
    instance_buffer_pointers: [FRAMES_IN_FLIGHT_COUNT]*Instance;

    indirect_draw_buffer_infos:    [FRAMES_IN_FLIGHT_COUNT]Buffer_Info;
    indirect_draw_buffer_pointers: [FRAMES_IN_FLIGHT_COUNT]*VK.Draw_Indexed_Indirect_Command;
}

create_model_pass :: (
    device:                        VK.Device,
    allocator:                     VMA.Allocator,
    get_compiled_shader:           Get_Compiled_Shader,
    color_target_image_format:     VK.Format,
    depth_image_format:            VK.Format,
    texture_descriptor_layout:     VK.Descriptor_Set_Layout,
    scene_info_descriptor_layout:  VK.Descriptor_Set_Layout,
    shadow_pass_descriptor_layout: VK.Descriptor_Set_Layout,
) -> error: string, Model_Pass {
    model_pass: Model_Pass;

    error:, model_pass.pipeline_info = create_pbr_pipeline(
        device,
        get_compiled_shader,
        .[color_target_image_format],
        depth_image_format,
        .[
            texture_descriptor_layout,
            scene_info_descriptor_layout,
            shadow_pass_descriptor_layout,
        ],
    );
    if error {
        return
            error,
            model_pass;
    }

    model_pass.ordered_draw_buckets = init_ordered_draw_buckets(model_pass.pipeline_info);

    // Indirect draw buffer
    for *indirect_draw_buffer_info: model_pass.indirect_draw_buffer_infos {
        error:, indirect_draw_buffer_info.* = create_buffer(
            device,
            allocator,
            usage = .INDIRECT_BUFFER,
            MAX_INDIRECT_BUFFER_BYTE_SIZE,
            memory_usage = .AUTO,
            mappable = true,
        );
        if error {
            return
                tprint("Failed to create indirect draw buffer for model pass: %", error),
                model_pass;
        }
        result:, model_pass.indirect_draw_buffer_pointers[it_index] = VMA.map_memory(
            allocator,
            indirect_draw_buffer_info.allocation,
        );
        if result != .SUCCESS {
            return
                tprint("Failed to map indirect draw buffer memory: %", result),
                model_pass;
        }
    }

    // Instance buffer
    for *instance_buffer_info: model_pass.instance_buffer_infos {
        error:, instance_buffer_info.* = create_buffer(
            device,
            allocator,
            usage = .STORAGE_BUFFER | .SHADER_DEVICE_ADDRESS,
            MAX_INSTANCE_BUFFER_BYTE_SIZE,
            memory_usage = .AUTO,
            mappable = true,
        );
        if error {
            return
                tprint("Failed to create instance buffer for model pass: %", error),
                model_pass;
        }

        result:, model_pass.instance_buffer_pointers[it_index] = VMA.map_memory(
            allocator,
            instance_buffer_info.allocation,
        );
        if result != .SUCCESS {
            return
                tprint("Fialed to map instance buffer memory: %", result),
                model_pass;
        }
    }

    return "", model_pass;
}

destroy_model_pass :: (model_pass: *Model_Pass, device: VK.Device, allocator: VMA.Allocator) {
    array_free(model_pass.model_draw_requests);

    for instance_buffer_info: model_pass.instance_buffer_infos {
        VMA.unmap_memory(
            allocator,
            instance_buffer_info.allocation,
        );
        VMA.destroy_buffer(
            allocator,
            instance_buffer_info.buffer,
            instance_buffer_info.allocation,
        );
    }

    for indirect_draw_buffer_info: model_pass.indirect_draw_buffer_infos {
        VMA.unmap_memory(
            allocator,
            indirect_draw_buffer_info.allocation,
        );
        VMA.destroy_buffer(
            allocator,
            indirect_draw_buffer_info.buffer,
            indirect_draw_buffer_info.allocation,
        );
    }

    destroy_draw_buckets(model_pass.ordered_draw_buckets);

    destroy_pbr_pipeline(device, *model_pass.pipeline_info);

    model_pass.* = {};
}

reset_model_pass :: (model_pass: *Model_Pass) {
    array_reset_keeping_memory(*model_pass.model_draw_requests);
    reset_draw_buckets_entries_keeping_order(model_pass.ordered_draw_buckets);
}

add_model_to_model_pass :: (
    model_pass:      *Model_Pass,
    model_accessor:  Model_Accessor,
    world_transform: Matrix4,
    tint:            Vector4,
    pose:            []Node_Transform,
) {
    array_add(
        *model_pass.model_draw_requests,
        {
            model_accessor,
            world_transform,
            tint,
            pose,
        },
    );
}

prepare_model_pass :: (
    model_pass:  *Model_Pass,
    materials_info: Materials_Info,
    frame_index: u64,
    allocator:   VMA.Allocator,
    view_point_for_sorting: Vector3,
    frustums_for_culling: []Frustum,
) {
    // Adding to buckets
    for model_draw_request: model_pass.model_draw_requests {
        { // Frustum culling
            // @Todo: use the pose values
            transformed_aabb := transform_aabb(model_draw_request.accessor.aabb, model_draw_request.transform);
            is_inside_one_of_the_frustums: bool;
            for frustum: frustums_for_culling {
                if aabb_vs_frustum(transformed_aabb, frustum) {
                    is_inside_one_of_the_frustums = true;
                    break;
                }
            }
            if !is_inside_one_of_the_frustums {
                continue;
            }
        }

        for node: model_draw_request.accessor.nodes {
            if node.parent_index.kind != .NONE {
                continue;
            }

            add_model_node_to_draw_bucket(
                node,
                it_index,
                model_draw_request,
                model_pass.ordered_draw_buckets,
                materials_info,
                model_draw_request.transform,
                view_point_for_sorting,
            );
        }
    }

    { // Check
        count: int;
        for draw_bucket: model_pass.ordered_draw_buckets {
            count += draw_bucket.entries.count;
        }
        assert(count <= MAX_INSTANCE_COUNT, "MAX_INSTANCE_COUNT overflow");
    }

    { // Sort entries in the blend bucket for correct blending
        blend_bucket := get_draw_bucket_by_material(
            model_pass.ordered_draw_buckets,
            { alpha_mode = .BLEND },
        );
        quick_sort(
            blend_bucket.entries,
            (a: Model_Draw_Bucket_Entry, b: Model_Draw_Bucket_Entry) -> int {
                if b.sorting_key_within_bucket > a.sorting_key_within_bucket
                    return 1;
                if a.sorting_key_within_bucket > b.sorting_key_within_bucket
                    return -1;
                return 0;
            }
        );
    }

    // Batch instances by mesh and write instance and indirect draw command buffers
    command_cursor:  int;
    instance_cursor: int;
    for *draw_bucket: model_pass.ordered_draw_buckets {
        draw_bucket.first_command_index = command_cursor;
        defer draw_bucket.command_count = command_cursor - draw_bucket.first_command_index;

        if draw_bucket.entries.count == 0 {
            continue;
        }

        allow_grouping := draw_bucket.alpha_mode != .BLEND;

        if allow_grouping {
            // Sort for instancing, except blend (sorted above)
            quick_sort(
                draw_bucket.entries,
                (a: Model_Draw_Bucket_Entry, b: Model_Draw_Bucket_Entry) -> int {
                    if a.geometry_accessor.index_start  < b.geometry_accessor.index_start
                        return -1;
                    if a.geometry_accessor.index_start  > b.geometry_accessor.index_start
                        return 1;
                    if a.geometry_accessor.vertex_start < b.geometry_accessor.vertex_start
                        return -1;
                    if a.geometry_accessor.vertex_start > b.geometry_accessor.vertex_start
                        return 1;
                    return 0;
                },
            );
        }

        current_command: VK.Draw_Indexed_Indirect_Command;
        for entry: draw_bucket.entries {
            is_first_iteration := it_index == 0;

            is_same_geometry := !is_first_iteration
                && allow_grouping
                && entry.geometry_accessor.index_start == current_command.first_index
                && cast(s32, entry.geometry_accessor.vertex_start) == current_command.vertex_offset;

            if !is_same_geometry {
                if !is_first_iteration {
                    model_pass.indirect_draw_buffer_pointers[frame_index][command_cursor] = current_command;
                    command_cursor += 1;
                }

                current_command = {
                    index_count    = entry.geometry_accessor.index_count,
                    first_index    = entry.geometry_accessor.index_start,
                    vertex_offset  = cast(s32, entry.geometry_accessor.vertex_start),
                    first_instance = cast(u32, instance_cursor),
                };
            }

            current_command.instance_count += 1;

            model_pass.instance_buffer_pointers[frame_index][instance_cursor] = entry.instance;
            instance_cursor += 1;
        }

        // Last
        model_pass.indirect_draw_buffer_pointers[frame_index][command_cursor] = current_command;
        command_cursor += 1;
    }

    VMA.flush_allocation(
        allocator,
        model_pass.indirect_draw_buffer_infos[frame_index].allocation,
        offset = 0,
        VK.WHOLE_SIZE,
    );
    VMA.flush_allocation(
        allocator,
        model_pass.instance_buffer_infos[frame_index].allocation,
        offset = 0,
        VK.WHOLE_SIZE,
    );
}

do_model_pass :: (
    model_pass:                 *Model_Pass,
    mesh_geometry_info:         Mesh_Geometry_Info,
    materials_info:             Materials_Info,
    frame_index:                u64,
    command_buffer:             VK.Command_Buffer,
    scene_info_descriptor_set:  VK.Descriptor_Set,
    shadow_pass_descriptor_set: VK.Descriptor_Set,
    transforms:                 Transforms,
) {
    { // Push constants
        push_constants: Push_Constants = {
            vertex_buffer_address   = mesh_geometry_info.vertex_buffer_info.device_address,
            material_buffer_address = materials_info.material_buffer_info.device_address,
            instance_buffer_address = model_pass.instance_buffer_infos[frame_index].device_address,

            view_projection_transform = transforms.view_projection,
        };

        VK.cmd_push_constants(
            command_buffer,
            model_pass.pipeline_info.layout,
            stage_flags = .VERTEX | .FRAGMENT,
            offset = 0,
            size_of(Push_Constants),
            *push_constants,
        );
    }

    VK.cmd_bind_index_buffer(
        command_buffer,
        mesh_geometry_info.index_buffer_info.buffer,
        offset = 0,
        index_type = .UINT32,
    );

    VK.cmd_bind_descriptor_sets(
        command_buffer,
        pipeline_bind_point = .GRAPHICS,
        model_pass.pipeline_info.layout,
        first_set = 0,
        .[
            materials_info.texture_descriptor_set,
            scene_info_descriptor_set,
            shadow_pass_descriptor_set,
        ],
        .[],
    );

    { // Draw
        bound_pipeline: VK.Pipeline;
        for draw_bucket: model_pass.ordered_draw_buckets {
            if draw_bucket.command_count == 0 {
                continue;
            }

            if draw_bucket.pipeline != bound_pipeline {
                VK.cmd_bind_pipeline(command_buffer, .GRAPHICS, draw_bucket.pipeline);
                bound_pipeline = draw_bucket.pipeline;
            }

            VK.cmd_set_cull_mode(command_buffer, draw_bucket.cull_mode);

            VK.cmd_draw_indexed_indirect(
                command_buffer,
                model_pass.indirect_draw_buffer_infos[frame_index].buffer,
                offset     = cast(u64, draw_bucket.first_command_index * size_of(VK.Draw_Indexed_Indirect_Command)),
                draw_count = cast(u32, draw_bucket.command_count),
                stride     = size_of(VK.Draw_Indexed_Indirect_Command),
            );
        }
    }
}



#scope_file

MAX_INSTANCE_COUNT                :: 4096;
MAX_INDIRECT_BUFFER_BYTE_SIZE :: MAX_INSTANCE_COUNT * size_of(VK.Draw_Indexed_Indirect_Command);
MAX_INSTANCE_BUFFER_BYTE_SIZE :: MAX_INSTANCE_COUNT * size_of(Instance);

Model_Pass_Specialization_Info :: struct @Gpu {
    alpha_mode:                            Alpha_Mode;
    discard_blend_single_sided_back_faces: u32;
}

Instance :: struct @Gpu {
    world_transform:                   Matrix4;
    inverse_transpose_world_transform: Matrix3;
    material_index:                    u32;
    tint:                              Vector4 = { 1, 1, 1, 1 };
}

Push_Constants :: struct @Gpu {
    vertex_buffer_address:   VK.Device_Address;
    material_buffer_address: VK.Device_Address;
    instance_buffer_address: VK.Device_Address;

    view_projection_transform: Matrix4;
}

Pbr_Pipeline_Info :: struct {
    layout:                       VK.Pipeline_Layout;
    opaque_pipeline:              VK.Pipeline;
    mask_pipeline:                VK.Pipeline;
    cull_agnostic_blend_pipeline: VK.Pipeline;
}

Model_Draw_Bucket :: struct {
    entries:    [..]Model_Draw_Bucket_Entry;
    pipeline:   VK.Pipeline;
    cull_mode:  VK.Cull_Mode_Flags;
    alpha_mode: Alpha_Mode;

    first_command_index: int;
    command_count:       int;
}

Model_Draw_Bucket_Entry :: struct {
    geometry_accessor:         Geometry_Accessor;
    instance:                  Instance;
    sorting_key_within_bucket: float;
}

Geometry_Accessor :: struct {
    index_count:  u32;
    index_start:  u32;
    vertex_start: u32;
}

Model_Draw_Request :: struct {
    accessor: Model_Accessor;
    transform: Matrix4;
    tint: Vector4;
    pose: []Node_Transform;
}

init_ordered_draw_buckets :: (pipeline_info: Pbr_Pipeline_Info) -> [5]Model_Draw_Bucket {
    draw_buckets: [5]Model_Draw_Bucket;
    for *bucket: draw_buckets {
        array_reserve(*bucket.entries, MAX_INSTANCE_COUNT);
    }

    draw_buckets[0].cull_mode  = .BACK;
    draw_buckets[0].alpha_mode = .OPAQUE;
    draw_buckets[0].pipeline = pipeline_info.opaque_pipeline;

    draw_buckets[1].cull_mode  = .NONE;
    draw_buckets[1].alpha_mode = .OPAQUE;
    draw_buckets[1].pipeline = pipeline_info.opaque_pipeline;

    draw_buckets[2].cull_mode  = .BACK;
    draw_buckets[2].alpha_mode = .MASK;
    draw_buckets[2].pipeline = pipeline_info.mask_pipeline;

    draw_buckets[3].cull_mode  = .NONE;
    draw_buckets[3].alpha_mode = .MASK;
    draw_buckets[3].pipeline = pipeline_info.mask_pipeline;

    // Contains both double sided and one sided
    draw_buckets[4].cull_mode  = .NONE;
    draw_buckets[4].alpha_mode = .BLEND;
    draw_buckets[4].pipeline = pipeline_info.cull_agnostic_blend_pipeline;

    return draw_buckets;
}

add_model_node_to_draw_bucket :: (
    node:                   Node,
    node_index:             int,
    model_draw_request:     Model_Draw_Request,
    draw_buckets:           []Model_Draw_Bucket,
    materials_info:         Materials_Info,
    parent_transform:       Matrix4,
    view_point_for_sorting: Vector3,
) {
    local_transform := ifx model_draw_request.pose.count > 0
        then model_draw_request.pose[node_index]
        else node.local_transform;

    world_transform := parent_transform * make_transformation_matrix(
        local_transform.translation,
        local_transform.rotation,
        local_transform.scale,
    );

    if node.mesh_count > 0 {
        inversed_ok, inversed_world_matrix := inverse(world_transform);
        if inversed_ok {
            inverse_transpose_world_transform := transpose(inversed_world_matrix);

            for mesh_index: node.first_mesh_index .. (node.first_mesh_index + node.mesh_count - 1) {
                mesh := model_draw_request.accessor.meshes[mesh_index];
                material := materials_info.materials[mesh.material_index];

                bucket := get_draw_bucket_by_material(draw_buckets, material);

                entry := Model_Draw_Bucket_Entry.{
                    geometry_accessor = {
                        index_start = mesh.index_start,
                        index_count = mesh.index_count,
                        vertex_start = mesh.vertex_start,
                    },
                    instance = {
                        world_transform                   = world_transform,
                        inverse_transpose_world_transform = make_matrix3(inverse_transpose_world_transform),
                        material_index                    = mesh.material_index,
                        tint                              = model_draw_request.tint,
                    },
                };
                if bucket.alpha_mode == .BLEND {
                    center_in_world_space := (world_transform * make_vector4(mesh.aabb.center, 1)).xyz;

                    entry.sorting_key_within_bucket = length_squared(center_in_world_space - view_point_for_sorting);
                }

                array_add(*bucket.entries, entry);
            }
        }
    }

    for child_node_index: node.children_ids {
        child_node := model_draw_request.accessor.nodes[child_node_index];

        add_model_node_to_draw_bucket(
            child_node,
            child_node_index,
            model_draw_request,
            draw_buckets,
            materials_info,
            world_transform,
            view_point_for_sorting,
        );
    }
}

get_draw_bucket_by_material :: (draw_buckets: []Model_Draw_Bucket, material: Material) -> *Model_Draw_Bucket {
    material_cull_mode: VK.Cull_Mode_Flags = ifx material.double_sided
        then .NONE
        else .BACK;

    for *draw_bucket: draw_buckets {
        if draw_bucket.alpha_mode == .BLEND && material.alpha_mode == .BLEND {
            return draw_bucket;
        }

        if (
            draw_bucket.alpha_mode == material.alpha_mode
            && draw_bucket.cull_mode == material_cull_mode
        ) {
            return draw_bucket;
        }
    }

    assert(false, "Unknown material: %", material);
    return null;
}

reset_draw_buckets_entries_keeping_order :: (draw_buckets: []Model_Draw_Bucket) {
    for *bucket: draw_buckets {
        array_reset_keeping_memory(*bucket.entries);
    }
}

destroy_draw_buckets :: (draw_buckets: []Model_Draw_Bucket) {
    for *bucket: draw_buckets {
        array_free(bucket.entries);
    }
}

create_pbr_pipeline :: (
    device:                   VK.Device,
    get_compiled_shader:      Get_Compiled_Shader,
    color_attachment_formats: []VK.Format,
    depth_attachment_format:  VK.Format,
    descriptor_set_layouts:   []VK.Descriptor_Set_Layout,
) -> error: string, Pbr_Pipeline_Info {
    pipeline_info: Pbr_Pipeline_Info;

    { // Layout
        push_constant_range := VK.Push_Constant_Range.{
            stage_flags = .VERTEX | .FRAGMENT,
            offset      = 0,
            size        = size_of(Push_Constants),
        };

        layout_create_info := VK.Pipeline_Layout_Create_Info.{
            set_layout_count          = cast(u32, descriptor_set_layouts.count),
            p_set_layouts             = descriptor_set_layouts.data,
            push_constant_range_count = 1,
            p_push_constant_ranges    = *push_constant_range,
        };

        result:, pipeline_info.layout = VK.create_pipeline_layout(device, *layout_create_info);
        if result != .SUCCESS {
            return
                tprint("Failed to create layout for pbr pipeline: %", result),
                pipeline_info;
        }
    }

    error, vertex_shader := create_shader_module(device, "pbr.vertex.spv", get_compiled_shader);
    if error {
        return
            error,
            pipeline_info;
    }
    defer VK.destroy_shader_module(device, vertex_shader);

    error =, fragment_shader := create_shader_module(device, "pbr.fragment.spv", get_compiled_shader);
    if error {
        return
            error,
            pipeline_info;
    }
    defer VK.destroy_shader_module(device, fragment_shader);

    model_pass_specialization_info: Model_Pass_Specialization_Info;

    specialization_map_entries := VK.Specialization_Map_Entry.[
        {
            constant_id = 0, // As in the shader
            offset      = 0,
            size        = size_of(type_of(Model_Pass_Specialization_Info.alpha_mode)),
        },
        {
            constant_id = 1, // As in the shader
            offset      = cast(u32, offset_of(Model_Pass_Specialization_Info, "discard_blend_single_sided_back_faces")),
            size        = size_of(type_of(Model_Pass_Specialization_Info.discard_blend_single_sided_back_faces)),
        },
    ];

    specialization_info := VK.Specialization_Info.{
        map_entry_count = specialization_map_entries.count,
        p_map_entries   = specialization_map_entries.data,
        data_size       = size_of(Model_Pass_Specialization_Info),
        p_data          = *model_pass_specialization_info,
    };

    shader_stage_create_infos := VK.Pipeline_Shader_Stage_Create_Info.[
        {
            stage  = .VERTEX,
            module = vertex_shader,
            p_name = "main",
        },
        {
            stage  = .FRAGMENT,
            module = fragment_shader,
            p_name = "main",
            p_specialization_info = *specialization_info,
        },
    ];

    vertex_input_state_create_info := VK.Pipeline_Vertex_Input_State_Create_Info.{};

    input_assembly_state_create_info := VK.Pipeline_Input_Assembly_State_Create_Info.{
        topology = .TRIANGLE_LIST,
    };

    depth_stencil_state_create_info := VK.Pipeline_Depth_Stencil_State_Create_Info.{
        depth_test_enable   = VK.TRUE,
        depth_write_enable  = VK.TRUE,
        depth_compare_op    = .LESS,
        stencil_test_enable = VK.FALSE,
    };

    viewport_state_create_info := VK.Pipeline_Viewport_State_Create_Info.{
        viewport_count = 1,
        p_viewports    = null,
        scissor_count  = 1,
        p_scissors     = null,
    };

    rasterization_state_create_info := VK.Pipeline_Rasterization_State_Create_Info.{
        polygon_mode = .FILL,
        cull_mode    = .BACK,
        front_face   = .COUNTER_CLOCKWISE,
        line_width   = 1,
    };

    multisample_state_create_info := VK.Pipeline_Multisample_State_Create_Info.{
        rasterization_samples = ._1,
    };

    color_blend_attachment_state := VK.Pipeline_Color_Blend_Attachment_State.{
        blend_enable = VK.FALSE,
        src_color_blend_factor = .SRC_ALPHA,
        dst_color_blend_factor = .ONE_MINUS_SRC_ALPHA,
        color_blend_op         = .ADD,
        src_alpha_blend_factor = .ONE,
        dst_alpha_blend_factor = .ONE_MINUS_SRC_ALPHA,
        alpha_blend_op         = .ADD,
        color_write_mask = .R | .G | .B | .A,
    };

    color_blend_state_create_info := VK.Pipeline_Color_Blend_State_Create_Info.{
        attachment_count = 1,
        p_attachments    = *color_blend_attachment_state,
    };

    dynamic_states := VK.Dynamic_State.[
        .VIEWPORT,
        .SCISSOR,
        .CULL_MODE,
    ];

    dynamic_state_create_info := VK.Pipeline_Dynamic_State_Create_Info.{
        dynamic_state_count = dynamic_states.count,
        p_dynamic_states    = dynamic_states.data,
    };

    rendering_create_info := VK.Pipeline_Rendering_Create_Info.{
        color_attachment_count     = cast(u32, color_attachment_formats.count),
        p_color_attachment_formats = color_attachment_formats.data,
        depth_attachment_format    = depth_attachment_format,
    };

    pipeline_create_info := VK.Graphics_Pipeline_Create_Info.{
        p_next                 = *rendering_create_info,
        stage_count            = shader_stage_create_infos.count,
        p_stages               = shader_stage_create_infos.data,
        p_vertex_input_state   = *vertex_input_state_create_info,
        p_input_assembly_state = *input_assembly_state_create_info,
        p_viewport_state       = *viewport_state_create_info,
        p_rasterization_state  = *rasterization_state_create_info,
        p_multisample_state    = *multisample_state_create_info,
        p_depth_stencil_state  = *depth_stencil_state_create_info,
        p_color_blend_state    = *color_blend_state_create_info,
        p_dynamic_state        = *dynamic_state_create_info,
        layout                 = pipeline_info.layout,
        render_pass            = null,
    };

    { // Opaque
        model_pass_specialization_info.alpha_mode = .OPAQUE;
        result:, pipeline_info.opaque_pipeline = VK.create_graphics_pipeline(
            device,
            null,
            *pipeline_create_info,
        );
        if result != .SUCCESS {
            return
                tprint("Failed to create opaque pbr pipeline: %", result),
                pipeline_info;
        }
    }
    { // Mask
        model_pass_specialization_info.alpha_mode = .MASK;
        result:, pipeline_info.mask_pipeline = VK.create_graphics_pipeline(
            device,
            null,
            *pipeline_create_info,
        );
        if result != .SUCCESS {
            return
                tprint("Failed to create mask pbr pipeline: %", result),
                pipeline_info;
        }
    }
    { // Blend
        model_pass_specialization_info.alpha_mode                            = .BLEND;
        model_pass_specialization_info.discard_blend_single_sided_back_faces = xx true;
        color_blend_attachment_state.blend_enable = VK.TRUE;
        depth_stencil_state_create_info.depth_write_enable = VK.FALSE;
        result:, pipeline_info.cull_agnostic_blend_pipeline = VK.create_graphics_pipeline(
            device,
            null,
            *pipeline_create_info,
        );
        if result != .SUCCESS {
            return
                tprint("Failed to create blend pbr pipeline: %", result),
                pipeline_info;
        }
    }

    return "", pipeline_info;
}

destroy_pbr_pipeline :: (device: VK.Device, pipeline_info: *Pbr_Pipeline_Info) {
    VK.destroy_pipeline(device, pipeline_info.opaque_pipeline);
    VK.destroy_pipeline(device, pipeline_info.mask_pipeline);
    VK.destroy_pipeline(device, pipeline_info.cull_agnostic_blend_pipeline);
    VK.destroy_pipeline_layout(device, pipeline_info.layout);

    pipeline_info.* = {};
}

#import "Sort";
#import "Type_Utils";
