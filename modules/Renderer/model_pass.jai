#scope_module

Model_Pass :: struct {
    pbr_pipeline_info: Pbr_Pipeline_Info;
    model_draw_buckets: Model_Draw_Buckets;

    instance_buffer_infos:    [FRAMES_IN_FLIGHT_COUNT]Buffer_Info;
    instance_buffer_pointers: [FRAMES_IN_FLIGHT_COUNT]*Instance;

    indirect_draw_buffer_infos:    [FRAMES_IN_FLIGHT_COUNT]Buffer_Info;
    indirect_draw_buffer_pointers: [FRAMES_IN_FLIGHT_COUNT]*VK.Draw_Indexed_Indirect_Command;
}

create_model_pass :: (
    device:                       VK.Device,
    allocator:                    VMA.Allocator,
    get_compiled_shader:          Get_Compiled_Shader,
    color_target_image_format:    VK.Format,
    depth_image_format:           VK.Format,
    texture_descriptor_layout:    VK.Descriptor_Set_Layout,
    scene_info_descriptor_layout: VK.Descriptor_Set_Layout,
) -> error: string, Model_Pass {
    model_pass: Model_Pass;

    error:, model_pass.pbr_pipeline_info = create_pbr_pipeline(
        device,
        get_compiled_shader,
        .[color_target_image_format],
        depth_image_format,
        .[
            texture_descriptor_layout,
            scene_info_descriptor_layout,
        ],
    );
    if error {
        return
            error,
            model_pass;
    }

    model_pass.model_draw_buckets = init_model_draw_buckets();

    // Indirect draw buffer
    for *indirect_draw_buffer_info: model_pass.indirect_draw_buffer_infos {
        error:, indirect_draw_buffer_info.* = create_buffer(
            device,
            allocator,
            usage = .INDIRECT_BUFFER,
            MAX_INDIRECT_BUFFER_SIZE,
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
            MAX_INSTANCE_BUFFER_SIZE,
            memory_usage = .AUTO,
            mappable = true,
        );
        if error {
            return
                tprint("Failed to create instance buffer for frame resources: %", error),
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

    destroy_model_draw_buckets(*model_pass.model_draw_buckets);

    destroy_pbr_pipeline(device, *model_pass.pbr_pipeline_info);

    model_pass.* = {};
}

reset_model_pass :: (model_pass: *Model_Pass) {
    reset_model_draw_buckets(*model_pass.model_draw_buckets);
}

add_model_to_model_pass :: (
    model_pass:     *Model_Pass,
    model:          Model,
    materials_info: Materials_Info,
    transforms:     Transforms,
) {
    for node: model.nodes {
        if node.parent_index.kind != .NONE {
            continue;
        }

        add_model_node_to_draw_bucket(
            materials_info,
            transforms,
            *model_pass.model_draw_buckets,
            node,
            model.nodes,
            model.transform,
        );
    }
}

do_model_pass :: (
    model_pass:     *Model_Pass,
    geometry_info:  Geometry_Info,
    materials_info: Materials_Info,
    frame_index:    u64,
    command_buffer: VK.Command_Buffer,
    scene_info:     Scene_Info,
    transforms:     Transforms,
    allocator:      VMA.Allocator,
) {
    push_constants: Push_Constants = {
        vertex_buffer_address   = geometry_info.vertex_buffer_info.device_address,
        material_buffer_address = materials_info.material_buffer_info.device_address,
        instance_buffer_address = model_pass.instance_buffer_infos[frame_index].device_address,

        view_projection_transform = transforms.view_projection,
    };

    VK.cmd_push_constants(
        command_buffer,
        model_pass.pbr_pipeline_info.layout,
        stage_flags = .VERTEX | .FRAGMENT,
        offset = 0,
        size_of(Push_Constants),
        *push_constants,
    );

    VK.cmd_bind_index_buffer(
        command_buffer,
        geometry_info.index_buffer_info.buffer,
        offset = 0,
        index_type = .UINT32,
    );

    VK.cmd_bind_descriptor_sets(
        command_buffer,
        pipeline_bind_point = .GRAPHICS,
        model_pass.pbr_pipeline_info.layout,
        first_set = 0,
        .[
            materials_info.texture_descriptor_info.set,
            scene_info.descriptor_sets[frame_index],
        ],
        .[],
    );


    draw_passes := into_draw_passes(*model_pass.model_draw_buckets, model_pass.pbr_pipeline_info);
    { // Check
        count: int;
        for draw_pass: draw_passes {
            count += draw_pass.bucket.count;
        }
        assert(count <= MAX_DRAW_COUNT, "MAX_DRAW_COUNT overflow");
    }

    { // Copy to buffers
        cursor: u32;
        for pass: draw_passes {
            for entry: pass.bucket {
                command := entry.command;
                command.first_instance = cursor;

                model_pass.indirect_draw_buffer_pointers[frame_index][cursor] = command;
                model_pass.instance_buffer_pointers[frame_index][cursor]      = entry.instance;

                cursor += 1;
            }
        }
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

    { // Draw
        offset: int;
        bound_pipeline:  VK.Pipeline;
        for draw_pass: draw_passes {
            if draw_pass.bucket.count == 0 {
                continue;
            }

            if draw_pass.pipeline != bound_pipeline {
                VK.cmd_bind_pipeline(command_buffer, .GRAPHICS, draw_pass.pipeline);
                bound_pipeline = draw_pass.pipeline;
            }

            VK.cmd_set_cull_mode(command_buffer, draw_pass.cull_mode);

            VK.cmd_draw_indexed_indirect(
                command_buffer,
                model_pass.indirect_draw_buffer_infos[frame_index].buffer,
                offset     = cast(u64, offset * size_of(VK.Draw_Indexed_Indirect_Command)),
                draw_count = cast(u32, draw_pass.bucket.count),
                stride     = size_of(VK.Draw_Indexed_Indirect_Command),
            );

            offset += draw_pass.bucket.count;
        }
    }
}



#scope_file

MAX_DRAW_COUNT           :: 4096;
MAX_INDIRECT_BUFFER_SIZE :: MAX_DRAW_COUNT * size_of(VK.Draw_Indexed_Indirect_Command);
MAX_INSTANCE_BUFFER_SIZE :: MAX_DRAW_COUNT * size_of(Instance);

Instance :: struct @Gpu {
    world_transform:                   Matrix4;
    inverse_transpose_world_transform: Matrix3;
    material_index:                    u32;
}

Push_Constants :: struct @Gpu {
    vertex_buffer_address:   VK.Device_Address;
    material_buffer_address: VK.Device_Address;
    instance_buffer_address: VK.Device_Address;

    view_projection_transform: Matrix4;
}

Pbr_Pipeline_Info :: struct {
    layout:          VK.Pipeline_Layout;
    opaque_pipeline: VK.Pipeline;
    blend_pipeline:  VK.Pipeline;
    mask_pipeline:   VK.Pipeline;
}

Model_Draw_Buckets :: struct {
    double_opaque: [..]Model_Draw_Bucket_Entry;
    double_mask:   [..]Model_Draw_Bucket_Entry;
    double_blend:  [..]Model_Draw_Bucket_Entry;

    single_opaque: [..]Model_Draw_Bucket_Entry;
    single_mask:   [..]Model_Draw_Bucket_Entry;
    single_blend:  [..]Model_Draw_Bucket_Entry;
}

Model_Draw_Bucket_Entry :: struct {
    command:  VK.Draw_Indexed_Indirect_Command;
    instance: Instance;
}

Draw_Pass :: struct {
    bucket:    []Model_Draw_Bucket_Entry;
    pipeline:  VK.Pipeline;
    cull_mode: VK.Cull_Mode_Flags;
}

init_model_draw_buckets :: () -> Model_Draw_Buckets {
    draw_buckets: Model_Draw_Buckets;
    for bucket: into_array(*draw_buckets) {
        array_reserve(bucket, MAX_DRAW_COUNT);
    }

    return draw_buckets;
}

add_model_node_to_draw_bucket :: (
    materials_info: Materials_Info,
    global_transforms: Transforms,
    draw_buckets: *Model_Draw_Buckets,
    node: Node,
    nodes: []Node,
    parent_transform: Matrix4,
) {
    world_transform := parent_transform * node.local_transform;

    if node.meshes.count > 0 {
        inversed_ok, inversed_world_matrix := inverse(world_transform);
        assert(inversed_ok, "Got a false on inverse, interesting");
        inverse_transpose_world_transform := transpose(inversed_world_matrix);

        for mesh: node.meshes {
            material := materials_info.materials[mesh.material_index];

            bucket := get_model_draw_bucket_by_material(draw_buckets, material);

            array_add(
                bucket,
                {
                    command = {
                        index_count    = mesh.index_count,
                        instance_count = 1, // @Todo
                        first_index    = mesh.index_start,
                        vertex_offset  = cast(s32, mesh.vertex_start),
                    },
                    instance = {
                        world_transform                   = world_transform,
                        inverse_transpose_world_transform = make_matrix3(inverse_transpose_world_transform),
                        material_index                    = mesh.material_index,
                    },
                },
            );
        }
    }

    for child_node_index: node.children_ids {
        child_node := nodes[child_node_index];

        add_model_node_to_draw_bucket(
            materials_info,
            global_transforms,
            draw_buckets,
            child_node,
            nodes,
            world_transform,
        );
    }
}

into_draw_passes :: (draw_buckets: *Model_Draw_Buckets, pbr_pipeline_info: Pbr_Pipeline_Info) -> [6]Draw_Pass {
    #assert cast(*Type_Info_Struct, type_info(Model_Draw_Buckets)).members.count == 6 "Update this procedure";

    return .[
        {
            bucket    = draw_buckets.single_opaque,
            pipeline  = pbr_pipeline_info.opaque_pipeline,
            cull_mode = .BACK,
        },
        {
            bucket    = draw_buckets.double_opaque,
            pipeline  = pbr_pipeline_info.opaque_pipeline,
            cull_mode = .NONE,
        },
        {
            bucket    = draw_buckets.single_mask,
            pipeline  = pbr_pipeline_info.mask_pipeline,
            cull_mode = .BACK,
        },
        {
            bucket    = draw_buckets.double_mask,
            pipeline  = pbr_pipeline_info.mask_pipeline,
            cull_mode = .NONE,
        },
        {
            bucket    = draw_buckets.single_blend,
            pipeline  = pbr_pipeline_info.blend_pipeline,
            cull_mode = .BACK,
        },
        {
            bucket    = draw_buckets.double_blend,
            pipeline  = pbr_pipeline_info.blend_pipeline,
            cull_mode = .NONE,
        },
    ];
}

get_model_draw_bucket_by_material :: (draw_buckets: *Model_Draw_Buckets, material: Material) -> *[..]Model_Draw_Bucket_Entry {
    if material.double_sided {
        if #complete material.alpha_mode == {
            case .OPAQUE;
                return *draw_buckets.double_opaque;
            case .MASK;
                return *draw_buckets.double_mask;
            case .BLEND;
                return *draw_buckets.double_blend;
        }
    } else {
        if #complete material.alpha_mode == {
            case .OPAQUE;
                return *draw_buckets.single_opaque;
            case .MASK;
                return *draw_buckets.single_mask;
            case .BLEND;
                return *draw_buckets.single_blend;
        }
    }

    assert(false, "Unknown material: %", material);
}

reset_model_draw_buckets :: (draw_buckets: *Model_Draw_Buckets) {
    for bucket: into_array(draw_buckets) {
        array_reset_keeping_memory(bucket);
    }
}

destroy_model_draw_buckets :: (draw_buckets: *Model_Draw_Buckets) {
    for bucket: into_array(draw_buckets) {
        array_free(bucket.*);
    }

    draw_buckets.* = {};
}



#scope_file

into_array :: (draw_buckets: *Model_Draw_Buckets) -> [6]*[..]Model_Draw_Bucket_Entry {
    #assert cast(*Type_Info_Struct, type_info(Model_Draw_Buckets)).members.count == 6 "Update this procedure";

    return .[
        *draw_buckets.double_opaque,
        *draw_buckets.double_mask,
        *draw_buckets.double_blend,

        *draw_buckets.single_opaque,
        *draw_buckets.single_mask,
        *draw_buckets.single_blend,
    ];
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

    specialization_map_entry := VK.Specialization_Map_Entry.{
        constant_id = 0, // As in the shader
        offset      = 0,
        size        = size_of(Alpha_Mode),
    };

    alpha_mode := Alpha_Mode.OPAQUE;

    specialization_info := VK.Specialization_Info.{
        map_entry_count = 1,
        p_map_entries   = *specialization_map_entry,
        data_size       = size_of(Alpha_Mode),
        p_data          = *alpha_mode,
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
        alpha_mode = .OPAQUE;
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
        alpha_mode = .MASK;
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
        alpha_mode = .BLEND;
        color_blend_attachment_state.blend_enable = VK.TRUE;
        depth_stencil_state_create_info.depth_write_enable = VK.FALSE;
        result:, pipeline_info.blend_pipeline = VK.create_graphics_pipeline(
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
    VK.destroy_pipeline(device, pipeline_info.blend_pipeline);
    VK.destroy_pipeline_layout(device, pipeline_info.layout);

    pipeline_info.* = {};
}
