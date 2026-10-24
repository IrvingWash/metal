Instance              :: #type *Instance_T;
Surface_Khr           :: #type *Surface_Khr_T;
Physical_Device       :: #type *Physical_Device_T;
Device                :: #type *Device_T;
Queue                 :: #type *Queue_T;
Device_Memory         :: #type *Device_Memory_T;
Swapchain_Khr         :: #type *Swapchain_Khr_T;
Image                 :: #type *Image_T;
Image_View            :: #type *Image_View_T;
Semaphore             :: #type *Semaphore_T;
Shader_Module         :: #type *Shader_Module_T;
Descriptor_Set_Layout :: #type *Descriptor_Set_Layout_T;
Pipeline              :: #type *Pipeline_T;
Pipeline_Layout       :: #type *Pipeline_Layout_T;
Sample_Mask           :: #type *Sample_Mask_T;
Render_Pass           :: #type *Render_Pass_T;
Pipeline_Cache        :: #type *Pipeline_Cache_T;
Command_Pool          :: #type *Command_Pool_T;
Command_Buffer        :: #type *Command_Buffer_T;
Fence                 :: #type *Fence_T;
Framebuffer           :: #type *Framebuffer_T;
Buffer                :: #type *Buffer_T;
Sampler               :: #type *Sampler_T;
Descriptor_Set        :: #type *Descriptor_Set_T;
Buffer_View           :: #type *Buffer_View_T;
Descriptor_Pool       :: #type *Descriptor_Pool_T;

Device_Address :: #type u64;

Bool :: #type,isa u32;
TRUE:  Bool : 1;
FALSE: Bool : 0;

LOD_CLAMP_NONE: float : 1000;

Pfn_Debug_Utils_Messenger_Callback_Ext :: #type (
    message_severity: Debug_Utils_Message_Severity_Flags_Ext,
    message_types:    Debug_Utils_Message_Type_Flags_Ext,
    p_callback_data:  *Debug_Utils_Messenger_Callback_Data_Ext,
    p_user_data:      *void,
) -> Bool #c_call;

Pfn_Reallocation_Function :: #type (
    p_user_data:      *void,
    p_original:       *void,
    size:             u64,
    alignment:        u64,
    allocation_scope: System_Allocation_Scope,
) -> *void #c_call;

Extension_Names :: struct {
    DEBUG_UTILS   :: "VK_EXT_debug_utils";
    KHR_SWAPCHAIN :: "VK_KHR_swapchain";
}

Layer_Names :: struct {
    VALIDATION :: "VK_LAYER_KHRONOS_validation";
}

Device_Size :: #type u64;

Allocation_Callbacks :: struct {
    p_user_data:             *void;
    pfn_allocation:          Pfn_Allocation_Function;
    pfn_reallocation:        Pfn_Reallocation_Function;
    pfn_free:                Pfn_Free_Function;
    pfn_internal_allocation: Pfn_Internal_Allocation_Notification;
    pfn_internal_free:       Pfn_Internal_Free_Notification;
}

Pfn_Internal_Free_Notification :: #type (
    p_user_data:      *void,
    size:             u64,
    allocation_type:  Internal_Allocation_Type,
    allocation_scope: System_Allocation_Scope,
) -> void #c_call;

Pfn_Internal_Allocation_Notification :: #type (
    p_user_data:      *void,
    size:             u64,
    allocation_type:  Internal_Allocation_Type,
    allocation_scope: System_Allocation_Scope,
) -> void #c_call;

Pfn_Free_Function :: #type (
    p_user_data: *void,
    p_memory:    *void,
) -> void #c_call;

Pfn_Allocation_Function :: #type (
    p_user_data:      *void,
    size:             u64,
    alignment:        u64,
    allocation_scope: System_Allocation_Scope,
) -> *void #c_call;

Application_Info :: struct {
    s_type :=            Structure_Type.APPLICATION_INFO;
    p_next:              *void;
    p_application_name:  *u8;
    application_version: u32;
    p_engine_name:       *u8;
    engine_version:      u32;
    api_version:         u32;
}

Debug_Utils_Messenger_Create_Info_Ext :: struct {
    s_type             := Structure_Type.DEBUG_UTILS_MESSENGER_CREATE_INFO_EXT;
    p_next:            *void;
    flags:             Debug_Utils_Messenger_Create_Flags_Ext;
    message_severity:  Debug_Utils_Message_Severity_Flags_Ext;
    message_type:      Debug_Utils_Message_Type_Flags_Ext;
    pfn_user_callback: Pfn_Debug_Utils_Messenger_Callback_Ext;
    p_user_data:       *void;
}

Debug_Utils_Messenger_Callback_Data_Ext :: struct {
    s_type := Structure_Type.DEBUG_UTILS_MESSENGER_CALLBACK_DATA_EXT;
    p_next: *void;
    flags: Debug_Utils_Messenger_Callback_Data_Flags_Ext;
    p_message_id_name: *u8;
    message_id_number: s32;
    p_message: *u8;
    queue_label_count: u32;
    p_queue_labels: *Debug_Utils_Label_Ext;
    cmd_buf_label_count: u32;
    p_cmd_buf_labels: *Debug_Utils_Label_Ext;
    object_count: u32;
    p_objects: *Debug_Utils_Object_Name_Info_Ext;
}

Debug_Utils_Object_Name_Info_Ext :: struct {
    s_type := Structure_Type.DEBUG_UTILS_OBJECT_NAME_INFO_EXT;
    p_next: *void;
    object_type: Object_Type;
    object_handle: u64;
    p_object_name: *u8;
}

Debug_Utils_Label_Ext :: struct {
    s_type        := Structure_Type.DEBUG_UTILS_LABEL_EXT;
    p_next:       *void;
    p_label_name: *u8;
    color:        [4]float;
}

Instance_Create_Info :: struct {
    s_type :=                   Structure_Type.INSTANCE_CREATE_INFO;
    p_next:                     *void;
    flags:                      Instance_Create_Flags;
    p_application_info:         *Application_Info;
    enabled_layer_count:        u32;
    pp_enabled_layer_names:     **u8;
    enabled_extension_count:    u32;
    pp_enabled_extension_names: **u8;
}

Physical_Device_Properties :: struct {
    api_version:         u32;
    driver_version:      u32;
    vendor_id:           u32;
    device_id:           u32;
    device_type:         Physical_Device_Type;
    device_name:         [256]u8;
    pipeline_cache_uuid: [16]u8;
    limits:              Physical_Device_Limits;
    sparse_properties:   Physical_Device_Sparse_Properties;
}

Physical_Device_Sparse_Properties :: struct {
    residency_standard_2d_block_shape:             Bool;
    residency_standard_2d_multisample_block_shape: Bool;
    residency_standard_3d_block_shape:             Bool;
    residency_aligned_mip_size:                    Bool;
    residency_non_resident_strict:                 Bool;
}

Physical_Device_Limits :: struct {
    max_image_dimension_1d:                                u32;
    max_image_dimension_2d:                                u32;
    max_image_dimension_3d:                                u32;
    max_image_dimension_cube:                              u32;
    max_image_array_layers:                                u32;
    max_texel_buffer_elements:                             u32;
    max_uniform_buffer_range:                              u32;
    max_storage_buffer_range:                              u32;
    max_push_constants_size:                               u32;
    max_memory_allocation_count:                           u32;
    max_sampler_allocation_count:                          u32;
    buffer_image_granularity:                              Device_Size;
    sparse_address_space_size:                             Device_Size;
    max_bound_descriptor_sets:                             u32;
    max_per_stage_descriptor_samplers:                     u32;
    max_per_stage_descriptor_uniform_buffers:              u32;
    max_per_stage_descriptor_storage_buffers:              u32;
    max_per_stage_descriptor_sampled_images:               u32;
    max_per_stage_descriptor_storage_images:               u32;
    max_per_stage_descriptor_input_attachments:            u32;
    max_per_stage_resources:                               u32;
    max_descriptor_set_samplers:                           u32;
    max_descriptor_set_uniform_buffers:                    u32;
    max_descriptor_set_uniform_buffers_dynamic:            u32;
    max_descriptor_set_storage_buffers:                    u32;
    max_descriptor_set_storage_buffers_dynamic:            u32;
    max_descriptor_set_sampled_images:                     u32;
    max_descriptor_set_storage_images:                     u32;
    max_descriptor_set_input_attachments:                  u32;
    max_vertex_input_attributes:                           u32;
    max_vertex_input_bindings:                             u32;
    max_vertex_input_attribute_offset:                     u32;
    max_vertex_input_binding_stride:                       u32;
    max_vertex_output_components:                          u32;
    max_tessellation_generation_level:                     u32;
    max_tessellation_patch_size:                           u32;
    max_tessellation_control_per_vertex_input_components:  u32;
    max_tessellation_control_per_vertex_output_components: u32;
    max_tessellation_control_per_patch_output_components:  u32;
    max_tessellation_control_total_output_components:      u32;
    max_tessellation_evaluation_input_components:          u32;
    max_tessellation_evaluation_output_components:         u32;
    max_geometry_shader_invocations:                       u32;
    max_geometry_input_components:                         u32;
    max_geometry_output_components:                        u32;
    max_geometry_output_vertices:                          u32;
    max_geometry_total_output_components:                  u32;
    max_fragment_input_components:                         u32;
    max_fragment_output_attachments:                       u32;
    max_fragment_dual_src_attachments:                     u32;
    max_fragment_combined_output_resources:                u32;
    max_compute_shared_memory_size:                        u32;
    max_compute_work_group_count:                          [3] u32;
    max_compute_work_group_invocations:                    u32;
    max_compute_work_group_size:                           [3] u32;
    sub_pixel_precision_bits:                              u32;
    sub_texel_precision_bits:                              u32;
    mipmap_precision_bits:                                 u32;
    max_draw_indexed_index_value:                          u32;
    max_draw_indirect_count:                               u32;
    max_sampler_lod_bias:                                  float;
    max_sampler_anisotropy:                                float;
    max_viewports:                                         u32;
    max_viewport_dimensions:                               [2] u32;
    viewport_bounds_range:                                 [2] float;
    viewport_sub_pixel_bits:                               u32;
    min_memory_map_alignment:                              u64;
    min_texel_buffer_offset_alignment:                     Device_Size;
    min_uniform_buffer_offset_alignment:                   Device_Size;
    min_storage_buffer_offset_alignment:                   Device_Size;
    min_texel_offset:                                      s32;
    max_texel_offset:                                      u32;
    min_texel_gather_offset:                               s32;
    max_texel_gather_offset:                               u32;
    min_interpolation_offset:                              float;
    max_interpolation_offset:                              float;
    sub_pixel_interpolation_offset_bits:                   u32;
    max_framebuffer_width:                                 u32;
    max_framebuffer_height:                                u32;
    max_framebuffer_layers:                                u32;
    framebuffer_color_sample_counts:                       Sample_Count_Flags;
    framebuffer_depth_sample_counts:                       Sample_Count_Flags;
    framebuffer_stencil_sample_counts:                     Sample_Count_Flags;
    framebuffer_no_attachments_sample_counts:              Sample_Count_Flags;
    max_color_attachments:                                 u32;
    sampled_image_color_sample_counts:                     Sample_Count_Flags;
    sampled_image_integer_sample_counts:                   Sample_Count_Flags;
    sampled_image_depth_sample_counts:                     Sample_Count_Flags;
    sampled_image_stencil_sample_counts:                   Sample_Count_Flags;
    storage_image_sample_counts:                           Sample_Count_Flags;
    max_sample_mask_words:                                 u32;
    timestamp_compute_and_graphics:                        Bool;
    timestamp_period:                                      float;
    max_clip_distances:                                    u32;
    max_cull_distances:                                    u32;
    max_combined_clip_and_cull_distances:                  u32;
    discrete_queue_priorities:                             u32;
    point_size_range:                                      [2] float;
    line_width_range:                                      [2] float;
    point_size_granularity:                                float;
    line_width_granularity:                                float;
    strict_lines:                                          Bool;
    standard_sample_locations:                             Bool;
    optimal_buffer_copy_offset_alignment:                  Device_Size;
    optimal_buffer_copy_row_pitch_alignment:               Device_Size;
    non_coherent_atom_size:                                Device_Size;
}

Queue_Family_Properties_2 :: struct {
    s_type                   := Structure_Type.QUEUE_FAMILY_PROPERTIES_2;
    p_next:                  *void;
    queue_family_properties: Queue_Family_Properties;
}

Queue_Family_Properties :: struct {
    queue_flags:                    Queue_Flags;
    queue_count:                    u32;
    timestamp_valid_bits:           u32;
    min_image_transfer_granularity: Extent_3D;
}

Extent_3D :: struct {
    width:  u32;
    height: u32;
    depth:  u32;

    #overlay(width) _2D: Extent_2D;
}

Extent_2D :: struct {
    width:  u32;
    height: u32;
}

Physical_Device_Vulkan_1_4_Features :: struct {
    s_type                                       := Structure_Type.PHYSICAL_DEVICE_VULKAN_1_4_FEATURES;
    p_next:                                      *void;
    global_priority_query:                       Bool;
    shader_subgroup_rotate:                      Bool;
    shader_subgroup_rotate_clustered:            Bool;
    shader_float_controls_2:                     Bool;
    shader_expect_assume:                        Bool;
    rectangular_lines:                           Bool;
    bresenham_lines:                             Bool;
    smooth_lines:                                Bool;
    stippled_rectangular_lines:                  Bool;
    stippled_bresenham_lines:                    Bool;
    stippled_smooth_lines:                       Bool;
    vertex_attribute_instance_rate_divisor:      Bool;
    vertex_attribute_instance_rate_zero_divisor: Bool;
    index_type_uint8:                            Bool;
    dynamic_rendering_local_read:                Bool;
    maintenance_5:                               Bool;
    maintenance_6:                               Bool;
    pipeline_protected_access:                   Bool;
    pipeline_robustness:                         Bool;
    host_image_copy:                             Bool;
    push_descriptor:                             Bool;
}

Physical_Device_Vulkan_1_3_Features :: struct {
    s_type                                                     := Structure_Type.PHYSICAL_DEVICE_VULKAN_1_3_FEATURES;
    p_next:                                                    *void;
    robust_image_access:                                       Bool;
    inline_uniform_block:                                      Bool;
    descriptor_binding_inline_uniform_block_update_after_bind: Bool;
    pipeline_creation_cache_control:                           Bool;
    private_data:                                              Bool;
    shader_demote_to_helper_invocation:                        Bool;
    shader_terminate_invocation:                               Bool;
    subgroup_size_control:                                     Bool;
    compute_full_subgroups:                                    Bool;
    synchronization_2:                                         Bool;
    texture_compression_astc_hdr:                              Bool;
    shader_zero_initialize_workgroup_memory:                   Bool;
    dynamic_rendering:                                         Bool;
    shader_integer_dot_product:                                Bool;
    maintenance_4:                                             Bool;
}

Physical_Device_Vulkan_1_2_Features :: struct {
    s_type                                                     := Structure_Type.PHYSICAL_DEVICE_VULKAN_1_2_FEATURES;
    p_next:                                                    *void;
    sampler_mirror_clamp_to_edge:                              Bool;
    draw_indirect_count:                                       Bool;
    storage_buffer_8_bit_access:                               Bool;
    uniform_and_storage_buffer_8_bit_access:                   Bool;
    storage_push_constant_8:                                   Bool;
    shader_buffer_int64_atomics:                               Bool;
    shader_shared_int64_atomics:                               Bool;
    shader_float16:                                            Bool;
    shader_int8:                                               Bool;
    descriptor_indexing:                                       Bool;
    shader_input_attachment_array_dynamic_indexing:            Bool;
    shader_uniform_texel_buffer_array_dynamic_indexing:        Bool;
    shader_storage_texel_buffer_array_dynamic_indexing:        Bool;
    shader_uniform_buffer_array_non_uniform_indexing:          Bool;
    shader_sampled_image_array_non_uniform_indexing:           Bool;
    shader_storage_buffer_array_non_uniform_indexing:          Bool;
    shader_storage_image_array_non_uniform_indexing:           Bool;
    shaderInputAttachmentArrayNonUniformIndexing:              Bool;
    shader_uniform_texel_buffer_array_non_uniform_indexing:    Bool;
    shader_storage_texel_buffer_array_non_uniform_indexing:    Bool;
    descriptor_binding_uniform_buffer_update_after_bind:       Bool;
    descriptor_binding_sampled_image_update_after_bind:        Bool;
    descriptor_binding_storage_image_update_after_bind:        Bool;
    descriptor_binding_storage_buffer_update_after_bind:       Bool;
    descriptor_binding_uniform_texel_buffer_update_after_bind: Bool;
    descriptor_binding_storage_texel_buffer_update_after_bind: Bool;
    descriptor_binding_update_unused_while_pending:            Bool;
    descriptor_binding_partially_bound:                        Bool;
    descriptor_binding_variable_descriptor_count:              Bool;
    runtime_descriptor_array:                                  Bool;
    sampler_filter_minmax:                                     Bool;
    scalar_block_layout:                                       Bool;
    imageless_framebuffer:                                     Bool;
    uniform_buffer_standard_layout:                            Bool;
    shader_subgroup_extended_types:                            Bool;
    separate_depth_stencil_layouts:                            Bool;
    host_query_reset:                                          Bool;
    timeline_semaphore:                                        Bool;
    buffer_device_address:                                     Bool;
    buffer_device_address_capture_replay:                      Bool;
    buffer_device_address_multi_device:                        Bool;
    vulkan_memory_model:                                       Bool;
    vulkan_memory_model_device_scope:                          Bool;
    vulkan_memory_model_availability_visibility_chains:        Bool;
    shader_output_viewport_index:                              Bool;
    shader_output_layer:                                       Bool;
    subgroup_broadcast_dynamic_id:                             Bool;
}

Physical_Device_Features_2 :: struct {
    s_type := Structure_Type.PHYSICAL_DEVICE_FEATURES_2;
    p_next:   *void;
    features: Physical_Device_Features;
}

Physical_Device_Features :: struct {
    robust_buffer_access:                          Bool;
    full_draw_index_uint32:                        Bool;
    image_cube_array:                              Bool;
    independent_blend:                             Bool;
    geometry_shader:                               Bool;
    tessellation_shader:                           Bool;
    sample_rate_shading:                           Bool;
    dual_src_blend:                                Bool;
    logic_op:                                      Bool;
    multi_draw_indirect:                           Bool;
    draw_indirect_first_instance:                  Bool;
    depth_clamp:                                   Bool;
    depth_bias_clamp:                              Bool;
    fill_mode_non_solid:                           Bool;
    depth_bounds:                                  Bool;
    wide_lines:                                    Bool;
    large_points:                                  Bool;
    alpha_to_one:                                  Bool;
    multi_viewport:                                Bool;
    sampler_anisotropy:                            Bool;
    texture_compression_etc2:                      Bool;
    texture_compression_astc_ldr:                  Bool;
    texture_compression_bc:                        Bool;
    occlusion_query_precise:                       Bool;
    pipeline_statistics_query:                     Bool;
    vertex_pipeline_stores_and_atomics:            Bool;
    fragment_stores_and_atomics:                   Bool;
    shader_tessellation_and_geometry_point_size:   Bool;
    shader_image_gather_extended:                  Bool;
    shader_storage_image_extended_formats:         Bool;
    shader_storage_image_multisample:              Bool;
    shader_storage_image_read_without_format:      Bool;
    shader_storage_image_write_without_format:     Bool;
    shader_uniform_buffer_array_dynamic_indexing:  Bool;
    shader_sampled_image_array_dynamic_indexing:   Bool;
    shader_storage_buffer_array_dynamic_indexing:  Bool;
    shader_storage_image_array_dynamic_indexing:   Bool;
    shader_clip_distance:                          Bool;
    shader_cull_distance:                          Bool;
    shader_float64:                                Bool;
    shader_int64:                                  Bool;
    shader_int16:                                  Bool;
    shader_resource_residency:                     Bool;
    shader_resource_min_lod:                       Bool;
    sparse_binding:                                Bool;
    sparse_residency_buffer:                       Bool;
    sparse_residency_image2d:                      Bool;
    sparse_residency_image3d:                      Bool;
    sparse_residency2_samples:                     Bool;
    sparse_residency4_samples:                     Bool;
    sparse_residency8_samples:                     Bool;
    sparse_residency16_samples:                    Bool;
    sparse_residency_aliased:                      Bool;
    variable_multisample_rate:                     Bool;
    inherited_queries:                             Bool;
}

Device_Queue_Create_Info :: struct {
    s_type              := Structure_Type.DEVICE_QUEUE_CREATE_INFO;
    p_next:             *void;
    flags:              Device_Queue_Create_Flags;
    queue_family_index: u32;
    queue_count:        u32;
    p_queue_priorities: *float;
}

Device_Create_Info :: struct {
    s_type                      := Structure_Type.DEVICE_CREATE_INFO;
    p_next:                     *void;
    flags:                      Device_Create_Flags;
    queue_create_info_count:    u32;
    p_queue_create_infos:       *Device_Queue_Create_Info;
    // enabledLayerCount is legacy and not used
    _enabled_layer_count:       u32;
    // ppEnabledLayerNames is legacy and not used
    _pp_enabled_layer_names:    **u8;
    enabled_extension_count:    u32;
    pp_enabled_extension_names: **u8;
    p_enabled_features:         *Physical_Device_Features;
}

Surface_Capabilities_Khr :: struct {
    min_image_count:           u32;
    max_image_count:           u32;
    current_extent:            Extent_2D;
    min_image_extent:          Extent_2D;
    max_image_extent:          Extent_2D;
    max_image_array_layers:    u32;
    supported_transforms:      Surface_Transform_Flags_Khr;
    current_transform:         Surface_Transform_Flags_Khr;
    supported_composite_alpha: Composite_Alpha_Flags_Khr;
    supported_usage_flags:     Image_Usage_Flags;
}

Swapchain_Create_Info_Khr :: struct {
    s_type :=                 Structure_Type.SWAPCHAIN_CREATE_INFO_KHR;
    p_next:                   *void;
    flags:                    Swapchain_Create_Flags_Khr;
    surface:                  Surface_Khr;
    min_image_count:          u32;
    image_format:             Format;
    image_color_space:        Color_Space_Khr;
    image_extent:             Extent_2D;
    image_array_layers:       u32;
    image_usage:              Image_Usage_Flags;
    image_sharing_mode:       Sharing_Mode;
    queue_family_index_count: u32;
    p_queue_family_indices:   *u32;
    pre_transform:            Surface_Transform_Flags_Khr;
    composite_alpha:          Composite_Alpha_Flags_Khr;
    present_mode:             Present_Mode_Khr;
    clipped:                  Bool;
    old_swapchain:            Swapchain_Khr;
}

Surface_Format_Khr :: struct {
    format:      Format;
    color_space: Color_Space_Khr;
}

Image_View_Create_Info :: struct {
    s_type :=          Structure_Type.IMAGE_VIEW_CREATE_INFO;
    p_next:            *void;
    flags:             Image_View_Create_Flags;
    image:             Image;
    view_type:         Image_View_Type;
    format:            Format;
    components:        Component_Mapping;
    subresource_range: Image_Subresource_Range;
}

Image_Subresource_Range :: struct {
    aspect_mask:      Image_Aspect_Flags;
    base_mip_level:   u32;
    level_count:      u32;
    base_array_layer: u32;
    layer_count:      u32;
}

Component_Mapping :: struct {
    r: Component_Swizzle;
    g: Component_Swizzle;
    b: Component_Swizzle;
    a: Component_Swizzle;
}

Semaphore_Create_Info :: struct {
    s_type := Structure_Type.SEMAPHORE_CREATE_INFO;
    p_next:   *void;
    flags:    Semaphore_Create_Flags;
}

Image_Create_Info :: struct {
    s_type :=                 Structure_Type.IMAGE_CREATE_INFO;
    p_next:                   *void;
    flags:                    Image_Create_Flags;
    image_type:               Image_Type;
    format:                   Format;
    extent:                   Extent_3D;
    mip_levels:               u32;
    array_layers:             u32;
    samples:                  Sample_Count_Flags;
    tiling:                   Image_Tiling;
    usage:                    Image_Usage_Flags;
    sharing_mode:             Sharing_Mode;
    queue_family_index_count: u32;
    p_queue_family_indices:   *u32;
    initial_layout:           Image_Layout;
}

Shader_Module_Create_Info :: struct {
    s_type :=  Structure_Type.SHADER_MODULE_CREATE_INFO;
    p_next:    *void;
    flags:     Shader_Module_Create_Flags;
    code_size: u64;
    p_code:    *u32;
}

Pipeline_Layout_Create_Info :: struct {
    s_type :=                  Structure_Type.PIPELINE_LAYOUT_CREATE_INFO;
    p_next:                    *void;
    flags:                     Pipeline_Layout_Create_Flags;
    set_layout_count:          u32;
    p_set_layouts:             *Descriptor_Set_Layout;
    push_constant_range_count: u32;
    p_push_constant_ranges:    *Push_Constant_Range;
}

Push_Constant_Range :: struct {
    stage_flags: Shader_Stage_Flags;
    offset:     u32;
    size:       u32;
}

Pipeline_Shader_Stage_Create_Info :: struct {
    s_type                 := Structure_Type.PIPELINE_SHADER_STAGE_CREATE_INFO;
    p_next:                *void;
    flags:                 Pipeline_Shader_Stage_Create_Flags;
    stage:                 Shader_Stage_Flags;
    module:                Shader_Module;
    p_name:                *u8;
    p_specialization_info: *Specialization_Info;
}

Specialization_Info :: struct {
    map_entry_count: u32;
    p_map_entries:   *Specialization_Map_Entry;
    data_size:       u64;
    p_data:          *void;
}

Specialization_Map_Entry :: struct {
    constant_id: u32;
    offset:      u32;
    size:        u64;
}

Pipeline_Vertex_Input_State_Create_Info :: struct {
    s_type :=                           Structure_Type.PIPELINE_VERTEX_INPUT_STATE_CREATE_INFO;
    p_next:                             *void;
    flags:                              Pipeline_Vertex_Input_State_Create_Flags;
    vertex_binding_description_count:   u32;
    p_vertex_binding_descriptions:      *Vertex_Input_Binding_Description;
    vertex_attribute_description_count: u32;
    p_vertex_attribute_descriptions:    *Vertex_Input_Attribute_Description;
}

Vertex_Input_Binding_Description :: struct {
    binding:   u32;
    stride:    u32;
    input_rate: Vertex_Input_Rate;
}

Vertex_Input_Attribute_Description :: struct {
    location: u32;
    binding:  u32;
    format:   Format;
    offset:   u32;
}

Pipeline_Input_Assembly_State_Create_Info :: struct {
    s_type :=                 Structure_Type.PIPELINE_INPUT_ASSEMBLY_STATE_CREATE_INFO;
    p_next:                   *void;
    flags:                    Pipeline_Input_Assembly_State_Create_Flags;
    topology:                 Primitive_Topology;
    primitive_restart_enable: Bool;
}

Pipeline_Depth_Stencil_State_Create_Info :: struct {
    s_type :=                 Structure_Type.PIPELINE_DEPTH_STENCIL_STATE_CREATE_INFO;
    p_next:                   *void;
    flags:                    Pipeline_Depth_Stencil_State_Create_Flags;
    depth_test_enable:        Bool;
    depth_write_enable:       Bool;
    depth_compare_op:         Compare_Op;
    depth_bounds_test_enable: Bool;
    stencil_test_enable:      Bool;
    front:                    Stencil_Op_State;
    back:                     Stencil_Op_State;
    min_depth_bounds:         float;
    max_depth_bounds:         float;
}

Stencil_Op_State :: struct {
    fail_op:       Stencil_Op;
    pass_op:       Stencil_Op;
    depth_fail_op: Stencil_Op;
    compare_op:    Compare_Op;
    compare_mask:  u32;
    write_mask:    u32;
    reference:     u32;
}

Pipeline_Viewport_State_Create_Info :: struct {
    s_type :=       Structure_Type.PIPELINE_VIEWPORT_STATE_CREATE_INFO;
    p_next:         *void;
    flags:          Pipeline_Viewport_State_Create_Flags;
    viewport_count: u32;
    p_viewports:    *Viewport;
    scissor_count:  u32;
    p_scissors:     *Rect_2D;
}

Rect_2D :: struct {
    offset: Offset_2D;
    extent: Extent_2D;
}

Offset_2D :: struct {
    x: s32;
    y: s32;
}

Offset_3D :: struct {
    x: s32;
    y: s32;
    z: s32;
}

Viewport :: struct {
    x:         float;
    y:         float;
    width:     float;
    height:    float;
    min_depth: float;
    max_depth: float;
}

Pipeline_Rasterization_State_Create_Info :: struct {
    s_type :=                   Structure_Type.PIPELINE_RASTERIZATION_STATE_CREATE_INFO;
    p_next:                     *void;
    flags:                      Pipeline_Rasterization_State_Create_Flags;
    depth_clamp_enable:         Bool;
    rasterizer_discard_enable:  Bool;
    polygon_mode:               Polygon_Mode;
    cull_mode:                  Cull_Mode_Flags;
    front_face:                 Front_Face;
    depth_bias_enable:          Bool;
    depth_bias_constant_factor: float;
    depth_bias_clamp:           float;
    depth_bias_slope_factor:    float;
    line_width:                 float;
}

Pipeline_Multisample_State_Create_Info :: struct {
    s_type :=                 Structure_Type.PIPELINE_MULTISAMPLE_STATE_CREATE_INFO;
    p_next:                   *void;
    flags:                    Pipeline_Multisample_State_Create_Flags;
    rasterization_samples:    Sample_Count_Flags;
    sample_shading_enable:    Bool;
    min_sample_shading:       float;
    p_sample_mask:            *Sample_Mask;
    alpha_to_coverage_enable: Bool;
    alpha_to_one_enable:      Bool;
}

Pipeline_Color_Blend_Attachment_State :: struct {
    blend_enable:           Bool;
    src_color_blend_factor: Blend_Factor;
    dst_color_blend_factor: Blend_Factor;
    color_blend_op:         Blend_Op;
    src_alpha_blend_factor: Blend_Factor;
    dst_alpha_blend_factor: Blend_Factor;
    alpha_blend_op:         Blend_Op;
    color_write_mask:       Color_Component_Flags;
}

Pipeline_Color_Blend_State_Create_Info :: struct {
    s_type :=         Structure_Type.PIPELINE_COLOR_BLEND_STATE_CREATE_INFO;
    p_next:           *void;
    flags:            Pipeline_Color_Blend_State_Create_Flags;
    logic_op_enable:  Bool;
    logic_op:         Logic_Op;
    attachment_count: u32;
    p_attachments:    *Pipeline_Color_Blend_Attachment_State;
    blend_constants:  [4]float;
}

Pipeline_Dynamic_State_Create_Info :: struct {
    s_type :=            Structure_Type.PIPELINE_DYNAMIC_STATE_CREATE_INFO;
    p_next:              *void;
    flags:               Pipeline_Dynamic_State_Create_Flags;
    dynamic_state_count: u32;
    p_dynamic_states:    *Dynamic_State;
}

Pipeline_Rendering_Create_Info :: struct {
    s_type :=                   Structure_Type.PIPELINE_RENDERING_CREATE_INFO;
    p_next:                     *void;
    view_mask:                  u32;
    color_attachment_count:     u32;
    p_color_attachment_formats: *Format;
    depth_attachment_format:    Format;
    stencil_attachment_format:  Format;
}

Graphics_Pipeline_Create_Info :: struct {
    s_type                  := Structure_Type.GRAPHICS_PIPELINE_CREATE_INFO;
    p_next:                 *void;
    flags:                  Pipeline_Create_Flags;
    stage_count:            u32;
    p_stages:               *Pipeline_Shader_Stage_Create_Info;
    p_vertex_input_state:   *Pipeline_Vertex_Input_State_Create_Info;
    p_input_assembly_state: *Pipeline_Input_Assembly_State_Create_Info;
    p_tessellation_state:   *Pipeline_Tessellation_State_Create_Info;
    p_viewport_state:       *Pipeline_Viewport_State_Create_Info;
    p_rasterization_state:  *Pipeline_Rasterization_State_Create_Info;
    p_multisample_state:    *Pipeline_Multisample_State_Create_Info;
    p_depth_stencil_state:  *Pipeline_Depth_Stencil_State_Create_Info;
    p_color_blend_state:    *Pipeline_Color_Blend_State_Create_Info;
    p_dynamic_state:        *Pipeline_Dynamic_State_Create_Info;
    layout:                 Pipeline_Layout;
    render_pass:            Render_Pass;
    subpass:                u32;
    base_pipeline_handle:   Pipeline;
    base_pipeline_index:    s32;
}

Pipeline_Tessellation_State_Create_Info :: struct {
    s_type :=             Structure_Type.PIPELINE_TESSELLATION_STATE_CREATE_INFO;
    p_next:               *void;
    flags:                Pipeline_Tessellation_State_Create_Flags;
    patch_control_points: u32;
}

Semaphore_Type_Create_Info :: struct {
    s_type          := Structure_Type.SEMAPHORE_TYPE_CREATE_INFO;
    p_next:         *void;
    semaphore_type: Semaphore_Type;
    initial_value:  u64;
}

Command_Pool_Create_Info :: struct {
    s_type              := Structure_Type.COMMAND_POOL_CREATE_INFO;
    p_next:             *void;
    flags:              Command_Pool_Create_Flags;
    queue_family_index: u32;
}

Command_Buffer_Allocate_Info :: struct {
    s_type                := Structure_Type.COMMAND_BUFFER_ALLOCATE_INFO;
    p_next:               *void;
    command_pool:         Command_Pool;
    level:                Command_Buffer_Level;
    command_buffer_count: u32;
}

Semaphore_Wait_Info :: struct {
    s_type := Structure_Type.SEMAPHORE_WAIT_INFO;
    p_next: *void;
    flags: Semaphore_Wait_Flags;
    semaphore_count: u32;
    p_semaphores: *Semaphore;
    p_values: *u64;
}

Command_Buffer_Begin_Info :: struct {
    s_type              := Structure_Type.COMMAND_BUFFER_BEGIN_INFO;
    p_next:             *void;
    flags:              Command_Buffer_Usage_Flags;
    p_inheritance_info: *Command_Buffer_Inheritance_Info;
}

Command_Buffer_Inheritance_Info :: struct {
    s_type                  := Structure_Type.COMMAND_BUFFER_INHERITANCE_INFO;
    p_next:                 *void;
    render_pass:            Render_Pass;
    subpass:                u32;
    framebuffer:            Framebuffer;
    occlusion_query_enable: Bool;
    query_flags:            Query_Control_Flags;
    pipeline_statistics:    Query_Pipeline_Statistic_Flags;
}

Image_Memory_Barrier_2 :: struct {
    s_type                  := Structure_Type.IMAGE_MEMORY_BARRIER_2;
    p_next:                 *void;
    src_stage_mask:         Pipeline_Stage_Flags_2;
    src_access_mask:        Access_Flags_2;
    dst_stage_mask:         Pipeline_Stage_Flags_2;
    dst_access_mask:        Access_Flags_2;
    old_layout:             Image_Layout;
    new_layout:             Image_Layout;
    src_queue_family_index: u32;
    dst_queue_family_index: u32;
    image:                  Image;
    subresource_range:      Image_Subresource_Range;
}

Dependency_Info :: struct {
    s_type                       := Structure_Type.DEPENDENCY_INFO;
    p_next:                      *void;
    dependency_flags:            Dependency_Flags;
    memory_barrier_count:        u32;
    p_memory_barriers:           *Memory_Barrier_2;
    buffer_memory_barrier_count: u32;
    p_buffer_memory_barriers:    *Buffer_Memory_Barrier_2;
    image_memory_barrier_count:  u32;
    p_image_memory_barriers:     *Image_Memory_Barrier_2;
}

Memory_Barrier_2 :: struct {
    s_type           := Structure_Type.MEMORY_BARRIER_2;
    p_next:          *void;
    src_stage_mask:  Pipeline_Stage_Flags_2;
    src_access_mask: Access_Flags_2;
    dst_stage_mask:  Pipeline_Stage_Flags_2;
    dst_access_mask: Access_Flags_2;
}

Buffer_Memory_Barrier_2 :: struct {
    s_type :=               Structure_Type.BUFFER_MEMORY_BARRIER_2;
    p_next:                 *void;
    src_stage_mask:         Pipeline_Stage_Flags_2;
    src_access_mask:        Access_Flags_2;
    dst_stage_mask:         Pipeline_Stage_Flags_2;
    dst_access_mask:        Access_Flags_2;
    src_queue_family_index: u32;
    dst_queue_family_index: u32;
    buffer:                 Buffer;
    offset:                 Device_Size;
    size:                   Device_Size;
}

Rendering_Attachment_Info :: struct {
    s_type                := Structure_Type.RENDERING_ATTACHMENT_INFO;
    p_next:               *void;
    image_view:           Image_View;
    image_layout:         Image_Layout;
    resolve_mode:         Resolve_Mode_Flags;
    resolve_image_view:   Image_View;
    resolve_image_layout: Image_Layout;
    load_op:              Attachment_Load_Op;
    store_op:             Attachment_Store_Op;
    clear_value:          Clear_Value;
}

Clear_Value :: union {
    color:         Clear_Color_Value;
    depth_stencil: Clear_Depth_Stencil_Value;
}

Clear_Color_Value :: union {
    _float32: [4] float;
    int32:    [4] s32;
    uint32:   [4] u32;
}

Clear_Depth_Stencil_Value :: struct {
    depth:   float;
    stencil: u32;
}

Rendering_Info :: struct {
    s_type                  := Structure_Type.RENDERING_INFO;
    p_next:                 *void;
    flags:                  Rendering_Flags;
    render_area:            Rect_2D;
    layer_count:            u32;
    view_mask:              u32;
    color_attachment_count: u32;
    p_color_attachments:    *Rendering_Attachment_Info;
    p_depth_attachment:     *Rendering_Attachment_Info;
    p_stencil_attachment:   *Rendering_Attachment_Info;
}

Semaphore_Submit_Info :: struct {
    s_type        := Structure_Type.SEMAPHORE_SUBMIT_INFO;
    p_next:       *void;
    semaphore:    Semaphore;
    value:        u64;
    stage_mask:   Pipeline_Stage_Flags_2;
    device_index: u32;
}

Command_Buffer_Submit_Info :: struct  {
    s_type          := Structure_Type.COMMAND_BUFFER_SUBMIT_INFO;
    p_next:         *void;
    command_buffer: Command_Buffer;
    device_mask:    u32;
}

Submit_Info_2 :: struct {
    s_type                       := Structure_Type.SUBMIT_INFO_2;
    p_next:                      *void;
    flags:                       Submit_Flags;
    wait_semaphore_info_count:   u32;
    p_wait_semaphore_infos:      *Semaphore_Submit_Info;
    command_buffer_info_count:   u32;
    p_command_buffer_infos:      *Command_Buffer_Submit_Info;
    signal_semaphore_info_count: u32;
    p_signal_semaphore_infos:    *Semaphore_Submit_Info;
}

Present_Info_Khr :: struct {
    s_type                := Structure_Type.PRESENT_INFO_KHR;
    p_next:               *void;
    wait_semaphore_count: u32;
    p_wait_semaphores:    *Semaphore;
    swapchain_count:      u32;
    p_swapchains:         *Swapchain_Khr;
    p_image_indices:      *u32;
    p_results:            *Result;
}

Buffer_Create_Info :: struct {
    s_type                    := Structure_Type.BUFFER_CREATE_INFO;
    p_next:                   *void;
    flags:                    Buffer_Create_Flags;
    size:                     Device_Size;
    usage:                    Buffer_Usage_Flags;
    sharing_mode:             Sharing_Mode;
    queue_family_index_count: u32;
    p_queue_family_indices:   *u32;
}

Buffer_Image_Copy :: struct {
    buffer_offset: Device_Size;
    buffer_row_length: u32;
    buffer_image_height: u32;
    image_subresource: Image_Subresource_Layers;
    image_offset: Offset_3D;
    image_extent: Extent_3D;
}

Image_Subresource_Layers :: struct {
    aspect_mask:      Image_Aspect_Flags;
    mip_level:        u32;
    base_array_layer: u32;
    layer_count:      u32;
}

Submit_Info :: struct {
    s_type                  := Structure_Type.SUBMIT_INFO;
    p_next:                 *void;
    wait_semaphore_count:   u32;
    p_wait_semaphores:      *Semaphore;
    p_wait_dst_stage_mask:  *Pipeline_Stage_Flags;
    command_buffer_count:   u32;
    p_command_buffers:      *Command_Buffer;
    signal_semaphore_count: u32;
    p_signal_semaphoers:    *Semaphore;
}

Sampler_Create_Info :: struct {
    s_type                    := Structure_Type.SAMPLER_CREATE_INFO;
    p_next:                   *void;
    flags:                    Sampler_Create_Flags;
    mag_filter:               Filter;
    min_filter:               Filter;
    mipmap_mode:              Sampler_Mipmap_Mode;
    address_mode_u:           Sampler_Address_Mode;
    address_mode_v:           Sampler_Address_Mode;
    address_mode_w:           Sampler_Address_Mode;
    mip_lod_bias:             float;
    anisotropy_enable:        Bool;
    max_anisotropy:           float;
    compare_enable:           Bool;
    compare_op:               Compare_Op;
    min_lod:                  float;
    max_lod:                  float;
    border_color:             Border_Color;
    unnormalized_coordinates: Bool;
}

Buffer_Device_Address_Info :: struct {
    s_type  := Structure_Type.BUFFER_DEVICE_ADDRESS_INFO;
    p_next: *void;
    buffer: Buffer;
}

Buffer_Copy :: struct {
    src_offset: Device_Size;
    dst_offset: Device_Size;
    size:       Device_Size;
}

Descriptor_Image_Info :: struct {
    sampler:      Sampler;
    image_view:   Image_View;
    image_layout: Image_Layout;
}

Write_Descriptor_Set :: struct {
    s_type               := Structure_Type.WRITE_DESCRIPTOR_SET;
    p_next:              *void;
    dst_set:             Descriptor_Set;
    dst_binding:         u32;
    dst_array_element:   u32;
    descriptor_count:    u32;
    descriptor_type:     Descriptor_Type;
    p_image_info:        *Descriptor_Image_Info;
    p_buffer_info:       *Descriptor_Buffer_Info;
    p_texel_buffer_view: *Buffer_View;
}

Descriptor_Buffer_Info :: struct {
    buffer: Buffer;
    offset: Device_Size;
    range:  Device_Size;
}

Copy_Descriptor_Set :: struct {
    s_type             := Structure_Type.COPY_DESCRIPTOR_SET;
    p_next:            *void;
    src_set:           Descriptor_Set;
    src_binding:       u32;
    src_array_element: u32;
    dst_set:           Descriptor_Set;
    dst_binding:       u32;
    dst_array_element: u32;
    descriptor_count:  u32;
}

Descriptor_Pool_Size :: struct {
    type: Descriptor_Type;
    descriptor_count: u32;
}

Descriptor_Pool_Create_Info :: struct {
    s_type           := Structure_Type.DESCRIPTOR_POOL_CREATE_INFO;
    p_next:          *void;
    flags:           Descriptor_Pool_Create_Flags;
    max_sets:        u32;
    pool_size_count: u32;
    p_pool_sizes:    *Descriptor_Pool_Size;
}

Descriptor_Set_Layout_Binding :: struct {
    binding:              u32;
    descriptor_type:      Descriptor_Type;
    descriptor_count:     u32;
    stage_flags:          Shader_Stage_Flags;
    p_immutable_samplers: *Sampler;
}

Descriptor_Set_Layout_Binding_Flags_Create_Info :: struct {
    s_type :=        Structure_Type.DESCRIPTOR_SET_LAYOUT_BINDING_FLAGS_CREATE_INFO;
    p_next:          *void;
    binding_count:   u32;
    p_binding_flags: *Descriptor_Binding_Flags;
}

Descriptor_Set_Layout_Create_Info :: struct {
    s_type         := Structure_Type.DESCRIPTOR_SET_LAYOUT_CREATE_INFO;
    p_next:        *void;
    flags:         Descriptor_Set_Layout_Create_Flags;
    binding_count: u32;
    p_bindings:    *Descriptor_Set_Layout_Binding;
}

Descriptor_Set_Allocate_Info :: struct {
    s_type                := Structure_Type.DESCRIPTOR_SET_ALLOCATE_INFO;
    p_next:               *void;
    descriptor_pool:      Descriptor_Pool;
    descriptor_set_count: u32;
    p_set_layouts:        *Descriptor_Set_Layout;
}

Draw_Indexed_Indirect_Command :: struct {
    index_count:    u32;
    instance_count: u32;
    first_index:    u32;
    vertex_offset:  s32;
    first_instance: u32;
}

Memory_Requirements :: struct {
    size: Device_Size;
    alignment: Device_Size;
    memory_type_bits: u32;
}

Memory_Dedicated_Requirements :: struct {
    s_type                       := Structure_Type.MEMORY_DEDICATED_REQUIREMENTS;
    p_next:                       *void;
    prefers_dedicated_allocation:  Bool;
    requires_dedicated_allocation: Bool;
}

Buffer_Memory_Requirements_Info_2 :: struct {
    s_type  := Structure_Type.BUFFER_MEMORY_REQUIREMENTS_INFO_2;
    p_next: *void;
    buffer: Buffer;
}

Memory_Requirements_2 :: struct {
    s_type               := Structure_Type.MEMORY_REQUIREMENTS_2;
    p_next:              *void;
    memory_requirements: Memory_Requirements;
}

Dependency_Flags :: enum_flags u32 {
    BY_REGION                                          :: 1;
    DEVICE_GROUP                                       :: 4;
    VIEW_LOCAL                                         :: 2;
    FEEDBACK_LOOP_EXT                                  :: 8;
    QUEUE_FAMILY_OWNERSHIP_TRANSFER_USE_ALL_STAGES_KHR :: 32;
    ASYMMETRIC_EVENT_KHR                               :: 64;
    VIEW_LOCAL_KHR                                     :: 2;
    DEVICE_GROUP_KHR                                   :: 4;
    FLAG_BITS_MAX_ENUM                                 :: 2147483647;
}

Stencil_Op :: enum u32 {
    KEEP                :: 0;
    ZERO                :: 1;
    REPLACE             :: 2;
    INCREMENT_AND_CLAMP :: 3;
    DECREMENT_AND_CLAMP :: 4;
    INVERT              :: 5;
    INCREMENT_AND_WRAP  :: 6;
    DECREMENT_AND_WRAP  :: 7;
    MAX_ENUM            :: 2147483647;
}

Component_Swizzle :: enum u32 {
    IDENTITY :: 0;
    ZERO     :: 1;
    ONE      :: 2;
    R        :: 3;
    G        :: 4;
    B        :: 5;
    A        :: 6;
    MAX_ENUM :: 2147483647;
}

Device_Queue_Create_Flags :: enum_flags u32 {
    PROTECTED                   :: 1;
    INTERNALLY_SYNCHRONIZED_KHR :: 4;
    FLAG_BITS_MAX_ENUM          :: 2147483647;
}

Debug_Utils_Messenger_Create_Flags_Ext :: enum_flags u32 {}

Debug_Utils_Message_Type_Flags_Ext :: enum_flags u32 {
    GENERAL_EXT                :: 0x00000001;
    VALIDATION_EXT             :: 0x00000002;
    PERFORMANCE_EXT            :: 0x00000004;
    DEVICE_ADDRESS_BINDING_EXT :: 0x00000008;
}

Debug_Utils_Message_Severity_Flags_Ext :: enum_flags u32 {
    VERBOSE_EXT :: 0x00000001;
    INFO_EXT    :: 0x00000010;
    WARNING_EXT :: 0x00000100;
    ERROR_EXT   :: 0x00001000;
}

Debug_Utils_Messenger_Callback_Data_Flags_Ext :: enum_flags u32 {}

Instance_Create_Flags :: enum_flags u32 {
    ENUMERATE_PORTABILITY_KHR     :: 1;
    FLAG_BITS_MAX_ENUM            :: 2147483647;
}

Sample_Count_Flags :: enum_flags u32 {
    _1                 :: 1;
    _2                 :: 2;
    _4                 :: 4;
    _8                 :: 8;
    _16                :: 16;
    _32                :: 32;
    _64                :: 64;
    FLAG_BITS_MAX_ENUM :: 2147483647;
}

Queue_Flags :: enum_flags u32 {
    GRAPHICS             :: 1;
    COMPUTE              :: 2;
    TRANSFER             :: 4;
    SPARSE_BINDING       :: 8;
    PROTECTED            :: 16;
    VIDEO_DECODE_KHR     :: 32;
    VIDEO_ENCODE_KHR     :: 64;
    OPTICAL_FLOW_NV      :: 256;
    DATA_GRAPH_ARM       :: 1024;
    FLAG_BITS_MAX_ENUM   :: 2147483647;
}

Device_Create_Flags :: enum_flags u32 {}

Surface_Transform_Flags_Khr :: enum_flags u32 {
    IDENTITY_KHR                     :: 1;
    ROTATE_90_KHR                    :: 2;
    ROTATE_180_KHR                   :: 4;
    ROTATE_270_KHR                   :: 8;
    HORIZONTAL_MIRROR_KHR            :: 16;
    HORIZONTAL_MIRROR_ROTATE_90_KHR  :: 32;
    HORIZONTAL_MIRROR_ROTATE_180_KHR :: 64;
    HORIZONTAL_MIRROR_ROTATE_270_KHR :: 128;
    INHERIT_KHR                      :: 256;
    FLAG_BITS_MAX_ENUM_KHR           :: 2147483647;
}

Image_Usage_Flags :: enum_flags u32 {
    TRANSFER_SRC                            :: 1;
    TRANSFER_DST                            :: 2;
    SAMPLED                                 :: 4;
    STORAGE                                 :: 8;
    COLOR_ATTACHMENT                        :: 16;
    DEPTH_STENCIL_ATTACHMENT                :: 32;
    TRANSIENT_ATTACHMENT                    :: 64;
    INPUT_ATTACHMENT                        :: 128;
    HOST_TRANSFER                           :: 4194304;
    VIDEO_DECODE_DST_KHR                    :: 1024;
    VIDEO_DECODE_SRC_KHR                    :: 2048;
    VIDEO_DECODE_DPB_KHR                    :: 4096;
    FRAGMENT_DENSITY_MAP_EXT                :: 512;
    FRAGMENT_SHADING_RATE_ATTACHMENT_KHR    :: 256;
    VIDEO_ENCODE_DST_KHR                    :: 8192;
    VIDEO_ENCODE_SRC_KHR                    :: 16384;
    VIDEO_ENCODE_DPB_KHR                    :: 32768;
    ATTACHMENT_FEEDBACK_LOOP_EXT            :: 524288;
    INVOCATION_MASK_HUAWEI                  :: 262144;
    SAMPLE_WEIGHT_QCOM                      :: 1048576;
    SAMPLE_BLOCK_MATCH_QCOM                 :: 2097152;
    TENSOR_ALIASING_ARM                     :: 8388608;
    TILE_MEMORY_QCOM                        :: 134217728;
    VIDEO_ENCODE_QUANTIZATION_DELTA_MAP_KHR :: 33554432;
    VIDEO_ENCODE_EMPHASIS_MAP_KHR           :: 67108864;
    SHADING_RATE_IMAGE_NV                   :: 256;
    HOST_TRANSFER_EXT                       :: 4194304;
    FLAG_BITS_MAX_ENUM                      :: 2147483647;
}

Composite_Alpha_Flags_Khr :: enum_flags u32 {
    OPAQUE_KHR          :: 1;
    PRE_MULTIPLIED_KHR  :: 2;
    POST_MULTIPLIED_KHR :: 4;
    INHERIT_KHR         :: 8;
    FLAG_BITS_MAX_ENUM_KHR  :: 2147483647;
}

Swapchain_Create_Flags_Khr :: enum_flags u32 {
    SPLIT_INSTANCE_BIND_REGIONS_KHR :: 1;
    PROTECTED_KHR                   :: 2;
    MUTABLE_FORMAT_KHR              :: 4;
    PRESENT_TIMING_EXT              :: 512;
    PRESENT_ID_2_KHR                :: 64;
    PRESENT_WAIT_2_KHR              :: 128;
    DEFERRED_MEMORY_ALLOCATION_KHR  :: 8;
    DEFERRED_MEMORY_ALLOCATION_EXT  :: 8;
    FLAG_BITS_MAX_ENUM_KHR          :: 2147483647;
}

Image_View_Create_Flags :: enum_flags u32 {
    FRAGMENT_DENSITY_MAP_DYNAMIC_EXT     :: 1;
    DESCRIPTOR_BUFFER_CAPTURE_REPLAY_EXT :: 4;
    FRAGMENT_DENSITY_MAP_DEFERRED_EXT    :: 2;
    FLAG_BITS_MAX_ENUM                   :: 2147483647;
}

Image_Aspect_Flags :: enum_flags u32 {
    COLOR              :: 1;
    DEPTH              :: 2;
    STENCIL            :: 4;
    METADATA           :: 8;
    PLANE_0            :: 16;
    PLANE_1            :: 32;
    PLANE_2            :: 64;
    NONE                   :: 0;
    MEMORY_PLANE_0_EXT :: 128;
    MEMORY_PLANE_1_EXT :: 256;
    MEMORY_PLANE_2_EXT :: 512;
    MEMORY_PLANE_3_EXT :: 1024;
    PLANE_0_KHR        :: 16;
    PLANE_1_KHR        :: 32;
    PLANE_2_KHR        :: 64;
    NONE_KHR               :: 0;
    FLAG_BITS_MAX_ENUM     :: 2147483647;
}

Semaphore_Create_Flags :: enum_flags u32 {}

Memory_Property_Flags :: enum_flags u32 {
    DEVICE_LOCAL        :: 1;
    HOST_VISIBLE        :: 2;
    HOST_COHERENT       :: 4;
    HOST_CACHED         :: 8;
    LAZILY_ALLOCATED    :: 16;
    PROTECTED           :: 32;
    DEVICE_COHERENT_AMD :: 64;
    DEVICE_UNCACHED_AMD :: 128;
    RDMA_CAPABLE_NV     :: 256;
    FLAG_BITS_MAX_ENUM  :: 2147483647;
}

Shader_Module_Create_Flags :: enum_flags u32 {}

Shader_Stage_Flags :: enum_flags u32 {
    VERTEX                  :: 1;
    TESSELLATION_CONTROL    :: 2;
    TESSELLATION_EVALUATION :: 4;
    GEOMETRY                :: 8;
    FRAGMENT                :: 16;
    COMPUTE                 :: 32;
    ALL_GRAPHICS            :: 31;
    ALL                     :: 2147483647;
    RAYGEN_KHR              :: 256;
    ANY_HIT_KHR             :: 512;
    CLOSEST_HIT_KHR         :: 1024;
    MISS_KHR                :: 2048;
    INTERSECTION_KHR        :: 4096;
    CALLABLE_KHR            :: 8192;
    TASK_EXT                :: 64;
    MESH_EXT                :: 128;
    SUBPASS_SHADING_HUAWEI  :: 16384;
    CLUSTER_CULLING_HUAWEI  :: 524288;
    RAYGEN_NV               :: 256;
    ANY_HIT_NV              :: 512;
    CLOSEST_HIT_NV          :: 1024;
    MISS_NV                 :: 2048;
    INTERSECTION_NV         :: 4096;
    CALLABLE_NV             :: 8192;
    TASK_NV                 :: 64;
    MESH_NV                 :: 128;
    FLAG_BITS_MAX_ENUM      :: 2147483647;
}

Pipeline_Layout_Create_Flags :: enum_flags u32 {
    INDEPENDENT_SETS_EXT :: 2;
    NO_TASK_SHADER_KHR   :: 4;
    FLAG_BITS_MAX_ENUM   :: 2147483647;
}

Pipeline_Shader_Stage_Create_Flags :: enum_flags u32 {
    ALLOW_VARYING_SUBGROUP_SIZE     :: 1;
    REQUIRE_FULL_SUBGROUPS          :: 2;
    ALLOW_VARYING_SUBGROUP_SIZE_EXT :: 1;
    REQUIRE_FULL_SUBGROUPS_EXT      :: 2;
    FLAG_BITS_MAX_ENUM              :: 2147483647;
}

Pipeline_Vertex_Input_State_Create_Flags :: enum_flags u32 {}

Pipeline_Input_Assembly_State_Create_Flags :: enum_flags u32 {}

Pipeline_Depth_Stencil_State_Create_Flags :: enum_flags u32 {
    RASTERIZATION_ORDER_ATTACHMENT_DEPTH_ACCESS_EXT   :: 1;
    RASTERIZATION_ORDER_ATTACHMENT_STENCIL_ACCESS_EXT :: 2;
    RASTERIZATION_ORDER_ATTACHMENT_DEPTH_ACCESS_ARM   :: 1;
    RASTERIZATION_ORDER_ATTACHMENT_STENCIL_ACCESS_ARM :: 2;
    FLAG_BITS_MAX_ENUM                                :: 2147483647;
}

Pipeline_Viewport_State_Create_Flags :: enum_flags u32 {}

Pipeline_Rasterization_State_Create_Flags :: enum_flags u32 {}

Cull_Mode_Flags :: enum_flags u32 {
    NONE               :: 0;
    FRONT              :: 1;
    BACK               :: 2;
    FRONT_AND_BACK     :: 3;
    FLAG_BITS_MAX_ENUM :: 2147483647;
}

Pipeline_Multisample_State_Create_Flags :: enum_flags u32 {}

Color_Component_Flags :: enum_flags u32 {
    R                  :: 1;
    G                  :: 2;
    B                  :: 4;
    A                  :: 8;
    FLAG_BITS_MAX_ENUM :: 2147483647;
}

Pipeline_Color_Blend_State_Create_Flags :: enum_flags u32 {
    RASTERIZATION_ORDER_ATTACHMENT_ACCESS_EXT :: 1;
    RASTERIZATION_ORDER_ATTACHMENT_ACCESS_ARM :: 1;
    FLAG_BITS_MAX_ENUM                        :: 2147483647;
}

Pipeline_Dynamic_State_Create_Flags :: enum_flags u32 {}

Pipeline_Tessellation_State_Create_Flags :: enum_flags u32 {}

Pipeline_Create_Flags :: enum_flags u32 {
    CREATE_DISABLE_OPTIMIZATION                                     :: 1;
    CREATE_ALLOW_DERIVATIVES                                        :: 2;
    CREATE_DERIVATIVE                                               :: 4;
    CREATE_DISPATCH_BASE                                            :: 16;
    CREATE_VIEW_INDEX_FROM_DEVICE_INDEX                             :: 8;
    CREATE_FAIL_ON_PIPELINE_COMPILE_REQUIRED                        :: 256;
    CREATE_EARLY_RETURN_ON_FAILURE                                  :: 512;
    CREATE_NO_PROTECTED_ACCESS                                      :: 134217728;
    CREATE_PROTECTED_ACCESS_ONLY                                    :: 1073741824;
    CREATE_RAY_TRACING_NO_NULL_ANY_HIT_SHADERS_KHR                  :: 16384;
    CREATE_RAY_TRACING_NO_NULL_CLOSEST_HIT_SHADERS_KHR              :: 32768;
    CREATE_RAY_TRACING_NO_NULL_MISS_SHADERS_KHR                     :: 65536;
    CREATE_RAY_TRACING_NO_NULL_INTERSECTION_SHADERS_KHR             :: 131072;
    CREATE_RAY_TRACING_SKIP_TRIANGLES_KHR                           :: 4096;
    CREATE_RAY_TRACING_SKIP_AABBS_KHR                               :: 8192;
    CREATE_RAY_TRACING_SHADER_GROUP_HANDLE_CAPTURE_REPLAY_KHR       :: 524288;
    CREATE_DEFER_COMPILE_NV                                         :: 32;
    CREATE_RENDERING_FRAGMENT_DENSITY_MAP_ATTACHMENT_EXT            :: 4194304;
    CREATE_RENDERING_FRAGMENT_SHADING_RATE_ATTACHMENT_KHR           :: 2097152;
    CREATE_CAPTURE_STATISTICS_KHR                                   :: 64;
    CREATE_CAPTURE_INTERNAL_REPRESENTATIONS_KHR                     :: 128;
    CREATE_INDIRECT_BINDABLE_NV                                     :: 262144;
    CREATE_LIBRARY_KHR                                              :: 2048;
    CREATE_DESCRIPTOR_BUFFER_EXT                                    :: 536870912;
    CREATE_RETAIN_LINK_TIME_OPTIMIZATION_INFO_EXT                   :: 8388608;
    CREATE_LINK_TIME_OPTIMIZATION_EXT                               :: 1024;
    CREATE_RAY_TRACING_ALLOW_MOTION_NV                              :: 1048576;
    CREATE_COLOR_ATTACHMENT_FEEDBACK_LOOP_EXT                       :: 33554432;
    CREATE_DEPTH_STENCIL_ATTACHMENT_FEEDBACK_LOOP_EXT               :: 67108864;
    CREATE_RAY_TRACING_OPACITY_MICROMAP_EXT                         :: 16777216;

    CREATE_VIEW_INDEX_FROM_DEVICE_INDEX_KHR                         :: 8;
    CREATE_DISPATCH_BASE_KHR                                        :: 16;

    RASTERIZATION_STATE_CREATE_FRAGMENT_DENSITY_MAP_ATTACHMENT_EXT  :: 4194304;

    RASTERIZATION_STATE_CREATE_FRAGMENT_SHADING_RATE_ATTACHMENT_KHR :: 2097152;
    CREATE_FAIL_ON_PIPELINE_COMPILE_REQUIRED_EXT                    :: 256;
    CREATE_EARLY_RETURN_ON_FAILURE_EXT                              :: 512;
    CREATE_NO_PROTECTED_ACCESS_EXT                                  :: 134217728;
    CREATE_PROTECTED_ACCESS_ONLY_EXT                                :: 1073741824;
    CREATE_FLAG_BITS_MAX_ENUM                                       :: 2147483647;
}

Semaphore_Wait_Flags :: enum_flags u32 {
    ANY     :: 0x00000001;
    ANY_KHR :: ANY;
}

Command_Pool_Reset_Flags :: enum_flags u32 {
    RELEASE_RESOURCES :: 0x00000001;
}

Command_Buffer_Usage_Flags :: enum_flags u32 {
    ONE_TIME_SUBMIT      :: 1;
    RENDER_PASS_CONTINUE :: 2;
    SIMULTANEOUS_USE     :: 4;
    FLAG_BITS_MAX_ENUM   :: 2147483647;
}

Query_Pipeline_Statistic_Flags :: enum_flags u32 {
    INPUT_ASSEMBLY_VERTICES                    :: 1;
    INPUT_ASSEMBLY_PRIMITIVES                  :: 2;
    VERTEX_SHADER_INVOCATIONS                  :: 4;
    GEOMETRY_SHADER_INVOCATIONS                :: 8;
    GEOMETRY_SHADER_PRIMITIVES                 :: 16;
    CLIPPING_INVOCATIONS                       :: 32;
    CLIPPING_PRIMITIVES                        :: 64;
    FRAGMENT_SHADER_INVOCATIONS                :: 128;
    TESSELLATION_CONTROL_SHADER_PATCHES        :: 256;
    TESSELLATION_EVALUATION_SHADER_INVOCATIONS :: 512;
    COMPUTE_SHADER_INVOCATIONS                 :: 1024;
    TASK_SHADER_INVOCATIONS_EXT                :: 2048;
    MESH_SHADER_INVOCATIONS_EXT                :: 4096;
    CLUSTER_CULLING_SHADER_INVOCATIONS_HUAWEI  :: 8192;
    FLAG_BITS_MAX_ENUM                         :: 2147483647;
}

Query_Control_Flags :: enum_flags u32 {
    PRECISE            :: 1;
    FLAG_BITS_MAX_ENUM :: 2147483647;
}

Pipeline_Stage_Flags_2 :: enum_flags u64 {
    NONE                                 :: 0;
    TOP_OF_PIPE                          :: 1;
    DRAW_INDIRECT                        :: 2;
    VERTEX_INPUT                         :: 4;
    VERTEX_SHADER                        :: 8;
    TESSELLATION_CONTROL_SHADER          :: 16;
    TESSELLATION_EVALUATION_SHADER       :: 32;
    GEOMETRY_SHADER                      :: 64;
    FRAGMENT_SHADER                      :: 128;
    EARLY_FRAGMENT_TESTS                 :: 256;
    LATE_FRAGMENT_TESTS                  :: 512;
    COLOR_ATTACHMENT_OUTPUT              :: 1024;
    COMPUTE_SHADER                       :: 2048;
    ALL_TRANSFER                         :: 4096;
    TRANSFER                             :: 4096;
    BOTTOM_OF_PIPE                       :: 8192;
    HOST                                 :: 16384;
    ALL_GRAPHICS                         :: 32768;
    ALL_COMMANDS                         :: 65536;
    COPY                                 :: 4294967296;
    RESOLVE                              :: 8589934592;
    BLIT                                 :: 17179869184;
    CLEAR                                :: 34359738368;
    INDEX_INPUT                          :: 68719476736;
    VERTEX_ATTRIBUTE_INPUT               :: 137438953472;
    PRE_RASTERIZATION_SHADERS            :: 274877906944;
    VIDEO_DECODE_KHR                     :: 67108864;
    VIDEO_ENCODE_KHR                     :: 134217728;
    NONE_KHR                             :: 0;
    TOP_OF_PIPE_KHR                      :: 1;
    DRAW_INDIRECT_KHR                    :: 2;
    VERTEX_INPUT_KHR                     :: 4;
    VERTEX_SHADER_KHR                    :: 8;
    TESSELLATION_CONTROL_SHADER_KHR      :: 16;
    TESSELLATION_EVALUATION_SHADER_KHR   :: 32;
    GEOMETRY_SHADER_KHR                  :: 64;
    FRAGMENT_SHADER_KHR                  :: 128;
    EARLY_FRAGMENT_TESTS_KHR             :: 256;
    LATE_FRAGMENT_TESTS_KHR              :: 512;
    COLOR_ATTACHMENT_OUTPUT_KHR          :: 1024;
    COMPUTE_SHADER_KHR                   :: 2048;
    ALL_TRANSFER_KHR                     :: 4096;
    TRANSFER_KHR                         :: 4096;
    BOTTOM_OF_PIPE_KHR                   :: 8192;
    HOST_KHR                             :: 16384;
    ALL_GRAPHICS_KHR                     :: 32768;
    ALL_COMMANDS_KHR                     :: 65536;
    COPY_KHR                             :: 4294967296;
    RESOLVE_KHR                          :: 8589934592;
    BLIT_KHR                             :: 17179869184;
    CLEAR_KHR                            :: 34359738368;
    INDEX_INPUT_KHR                      :: 68719476736;
    VERTEX_ATTRIBUTE_INPUT_KHR           :: 137438953472;
    PRE_RASTERIZATION_SHADERS_KHR        :: 274877906944;
    TRANSFORM_FEEDBACK_EXT               :: 16777216;
    CONDITIONAL_RENDERING_EXT            :: 262144;
    COMMAND_PREPROCESS_NV                :: 131072;
    COMMAND_PREPROCESS_EXT               :: 131072;
    FRAGMENT_SHADING_RATE_ATTACHMENT_KHR :: 4194304;
    SHADING_RATE_IMAGE_NV                :: 4194304;
    ACCELERATION_STRUCTURE_BUILD_KHR     :: 33554432;
    RAY_TRACING_SHADER_KHR               :: 2097152;
    RAY_TRACING_SHADER_NV                :: 2097152;
    ACCELERATION_STRUCTURE_BUILD_NV      :: 33554432;
    FRAGMENT_DENSITY_PROCESS_EXT         :: 8388608;
    TASK_SHADER_NV                       :: 524288;
    MESH_SHADER_NV                       :: 1048576;
    TASK_SHADER_EXT                      :: 524288;
    MESH_SHADER_EXT                      :: 1048576;
    SUBPASS_SHADER_HUAWEI                :: 549755813888;

    SUBPASS_SHADING_HUAWEI               :: 549755813888;
    INVOCATION_MASK_HUAWEI               :: 1099511627776;
    ACCELERATION_STRUCTURE_COPY_KHR      :: 268435456;
    MICROMAP_BUILD_EXT                   :: 1073741824;
    CLUSTER_CULLING_SHADER_HUAWEI        :: 2199023255552;
    OPTICAL_FLOW_NV                      :: 536870912;
    CONVERT_COOPERATIVE_VECTOR_MATRIX_NV :: 17592186044416;
    DATA_GRAPH_ARM                       :: 4398046511104;
    COPY_INDIRECT_KHR                    :: 70368744177664;
    MEMORY_DECOMPRESSION_EXT             :: 35184372088832;
}

Access_Flags_2 :: enum_flags u64 {
    NONE                                      :: 0;
    INDIRECT_COMMAND_READ                     :: 1;
    INDEX_READ                                :: 2;
    VERTEX_ATTRIBUTE_READ                     :: 4;
    UNIFORM_READ                              :: 8;
    INPUT_ATTACHMENT_READ                     :: 16;
    SHADER_READ                               :: 32;
    SHADER_WRITE                              :: 64;
    COLOR_ATTACHMENT_READ                     :: 128;
    COLOR_ATTACHMENT_WRITE                    :: 256;
    DEPTH_STENCIL_ATTACHMENT_READ             :: 512;
    DEPTH_STENCIL_ATTACHMENT_WRITE            :: 1024;
    TRANSFER_READ                             :: 2048;
    TRANSFER_WRITE                            :: 4096;
    HOST_READ                                 :: 8192;
    HOST_WRITE                                :: 16384;
    MEMORY_READ                               :: 32768;
    MEMORY_WRITE                              :: 65536;
    SHADER_SAMPLED_READ                       :: 4294967296;
    SHADER_STORAGE_READ                       :: 8589934592;
    SHADER_STORAGE_WRITE                      :: 17179869184;
    VIDEO_DECODE_READ_KHR                     :: 34359738368;
    VIDEO_DECODE_WRITE_KHR                    :: 68719476736;
    SAMPLER_HEAP_READ_EXT                     :: 144115188075855872;
    RESOURCE_HEAP_READ_EXT                    :: 288230376151711744;
    VIDEO_ENCODE_READ_KHR                     :: 137438953472;
    VIDEO_ENCODE_WRITE_KHR                    :: 274877906944;
    SHADER_TILE_ATTACHMENT_READ_QCOM          :: 2251799813685248;
    SHADER_TILE_ATTACHMENT_WRITE_QCOM         :: 4503599627370496;
    NONE_KHR                                  :: 0;
    INDIRECT_COMMAND_READ_KHR                 :: 1;
    INDEX_READ_KHR                            :: 2;
    VERTEX_ATTRIBUTE_READ_KHR                 :: 4;
    UNIFORM_READ_KHR                          :: 8;
    INPUT_ATTACHMENT_READ_KHR                 :: 16;
    SHADER_READ_KHR                           :: 32;
    SHADER_WRITE_KHR                          :: 64;
    COLOR_ATTACHMENT_READ_KHR                 :: 128;
    COLOR_ATTACHMENT_WRITE_KHR                :: 256;
    DEPTH_STENCIL_ATTACHMENT_READ_KHR         :: 512;
    DEPTH_STENCIL_ATTACHMENT_WRITE_KHR        :: 1024;
    TRANSFER_READ_KHR                         :: 2048;
    TRANSFER_WRITE_KHR                        :: 4096;
    HOST_READ_KHR                             :: 8192;
    HOST_WRITE_KHR                            :: 16384;
    MEMORY_READ_KHR                           :: 32768;
    MEMORY_WRITE_KHR                          :: 65536;
    SHADER_SAMPLED_READ_KHR                   :: 4294967296;
    SHADER_STORAGE_READ_KHR                   :: 8589934592;
    SHADER_STORAGE_WRITE_KHR                  :: 17179869184;
    TRANSFORM_FEEDBACK_WRITE_EXT              :: 33554432;
    TRANSFORM_FEEDBACK_COUNTER_READ_EXT       :: 67108864;
    TRANSFORM_FEEDBACK_COUNTER_WRITE_EXT      :: 134217728;
    CONDITIONAL_RENDERING_READ_EXT            :: 1048576;
    COMMAND_PREPROCESS_READ_NV                :: 131072;
    COMMAND_PREPROCESS_WRITE_NV               :: 262144;
    COMMAND_PREPROCESS_READ_EXT               :: 131072;
    COMMAND_PREPROCESS_WRITE_EXT              :: 262144;
    FRAGMENT_SHADING_RATE_ATTACHMENT_READ_KHR :: 8388608;
    SHADING_RATE_IMAGE_READ_NV                :: 8388608;
    ACCELERATION_STRUCTURE_READ_KHR           :: 2097152;
    ACCELERATION_STRUCTURE_WRITE_KHR          :: 4194304;
    ACCELERATION_STRUCTURE_READ_NV            :: 2097152;
    ACCELERATION_STRUCTURE_WRITE_NV           :: 4194304;
    FRAGMENT_DENSITY_MAP_READ_EXT             :: 16777216;
    COLOR_ATTACHMENT_READ_NONCOHERENT_EXT     :: 524288;
    DESCRIPTOR_BUFFER_READ_EXT                :: 2199023255552;
    INVOCATION_MASK_READ_HUAWEI               :: 549755813888;
    SHADER_BINDING_TABLE_READ_KHR             :: 1099511627776;
    MICROMAP_READ_EXT                         :: 17592186044416;
    MICROMAP_WRITE_EXT                        :: 35184372088832;
    OPTICAL_FLOW_READ_NV                      :: 4398046511104;
    OPTICAL_FLOW_WRITE_NV                     :: 8796093022208;
    DATA_GRAPH_READ_ARM                       :: 140737488355328;
    DATA_GRAPH_WRITE_ARM                      :: 281474976710656;
    MEMORY_DECOMPRESSION_READ_EXT             :: 36028797018963968;
    MEMORY_DECOMPRESSION_WRITE_EXT            :: 72057594037927936;
}

Image_Create_Flags :: enum_flags u32 {
    SPARSE_BINDING                            :: 1;
    SPARSE_RESIDENCY                          :: 2;
    SPARSE_ALIASED                            :: 4;
    MUTABLE_FORMAT                            :: 8;
    CUBE_COMPATIBLE                           :: 16;
    ALIAS                                     :: 1024;
    SPLIT_INSTANCE_BIND_REGIONS               :: 64;
    _2D_ARRAY_COMPATIBLE                      :: 32;
    BLOCK_TEXEL_VIEW_COMPATIBLE               :: 128;
    EXTENDED_USAGE                            :: 256;
    PROTECTED                                 :: 2048;
    DISJOINT                                  :: 512;
    CORNER_SAMPLED_NV                         :: 8192;
    DESCRIPTOR_HEAP_CAPTURE_REPLAY_EXT        :: 65536;
    SAMPLE_LOCATIONS_COMPATIBLE_DEPTH_EXT     :: 4096;
    SUBSAMPLED_EXT                            :: 16384;
    MULTISAMPLED_RENDER_TO_SINGLE_SAMPLED_EXT :: 262144;
    _2D_VIEW_COMPATIBLE_EXT                   :: 131072;
    VIDEO_PROFILE_INDEPENDENT_KHR             :: 1048576;
    FRAGMENT_DENSITY_MAP_OFFSET_EXT           :: 32768;
    ALIAS_SINGLE_LAYER_DESCRIPTOR_KHR         :: 4194304;
    SPLIT_INSTANCE_BIND_REGIONS_KHR           :: 64;
    _2D_ARRAY_COMPATIBLE_KHR                  :: 32;
    BLOCK_TEXEL_VIEW_COMPATIBLE_KHR           :: 128;
    EXTENDED_USAGE_KHR                        :: 256;
    DISJOINT_KHR                              :: 512;
    ALIAS_KHR                                 :: 1024;
    DESCRIPTOR_BUFFER_CAPTURE_REPLAY_EXT      :: 65536;
    FRAGMENT_DENSITY_MAP_OFFSET_QCOM          :: 32768;
    FLAG_BITS_MAX_ENUM                        :: 2147483647;
}

Resolve_Mode_Flags :: enum_flags u32 {
    NONE                               :: 0;
    SAMPLE_ZERO                        :: 0x00000001;
    AVERAGE                            :: 0x00000002;
    MIN                                :: 0x00000004;
    MAX                                :: 0x00000008;
    EXTERNAL_FORMAT_DOWNSAMPLEANDROID  :: 0x00000010;
    CUSTOMEXT                          :: 0x00000020;
    NONE_KHR                           :: NONE;
    SAMPLE_ZEROKHR                     :: SAMPLE_ZERO;
    AVERAGEKHR                         :: AVERAGE;
    MINKHR                             :: MIN;
    MAXKHR                             :: MAX;
    EXTERNAL_FORMAT_DOWNSAMPLE_ANDROID :: EXTERNAL_FORMAT_DOWNSAMPLEANDROID;
}

Rendering_Flags :: enum_flags u32 {
    CONTENTS_SECONDARY_COMMAND_BUFFERS       :: 1;
    SUSPENDING                               :: 2;
    RESUMING                                 :: 4;
    ENABLE_LEGACY_DITHERING_EXT              :: 8;
    CONTENTS_INLINE_KHR                      :: 16;
    PER_LAYER_FRAGMENT_DENSITY_VALVE         :: 32;
    FRAGMENT_REGION_EXT                      :: 64;
    CUSTOM_RESOLVE_EXT                       :: 128;
    LOCAL_READ_CONCURRENT_ACCESS_CONTROL_KHR :: 256;
    CONTENTS_SECONDARY_COMMAND_BUFFERS_KHR   :: 1;
    SUSPENDING_KHR                           :: 2;
    RESUMING_KHR                             :: 4;
    CONTENTS_INLINE_EXT                      :: 16;
    FLAG_BITS_MAX_ENUM                       :: 2147483647;
}

Pipeline_Stage_Flags :: enum_flags u32 {
    TOP_OF_PIPE                          :: 1;
    DRAW_INDIRECT                        :: 2;
    VERTEX_INPUT                         :: 4;
    VERTEX_SHADER                        :: 8;
    TESSELLATION_CONTROL_SHADER          :: 16;
    TESSELLATION_EVALUATION_SHADER       :: 32;
    GEOMETRY_SHADER                      :: 64;
    FRAGMENT_SHADER                      :: 128;
    EARLY_FRAGMENT_TESTS                 :: 256;
    LATE_FRAGMENT_TESTS                  :: 512;
    COLOR_ATTACHMENT_OUTPUT              :: 1024;
    COMPUTE_SHADER                       :: 2048;
    TRANSFER                             :: 4096;
    BOTTOM_OF_PIPE                       :: 8192;
    HOST                                 :: 16384;
    ALL_GRAPHICS                         :: 32768;
    ALL_COMMANDS                         :: 65536;
    NONE                                 :: 0;
    TRANSFORM_FEEDBACK_EXT               :: 16777216;
    CONDITIONAL_RENDERING_EXT            :: 262144;
    ACCELERATION_STRUCTURE_BUILD_KHR     :: 33554432;
    RAY_TRACING_SHADER_KHR               :: 2097152;
    FRAGMENT_DENSITY_PROCESS_EXT         :: 8388608;
    FRAGMENT_SHADING_RATE_ATTACHMENT_KHR :: 4194304;
    TASK_SHADER_EXT                      :: 524288;
    MESH_SHADER_EXT                      :: 1048576;
    COMMAND_PREPROCESS_EXT               :: 131072;
    SHADING_RATE_IMAGE_NV                :: 4194304;
    RAY_TRACING_SHADER_NV                :: 2097152;
    ACCELERATION_STRUCTURE_BUILD_NV      :: 33554432;
    TASK_SHADER_NV                       :: 524288;
    MESH_SHADER_NV                       :: 1048576;
    COMMAND_PREPROCESS_NV                :: 131072;
    NONE_KHR                             :: 0;
    FLAG_BITS_MAX_ENUM                   :: 2147483647;
}

Submit_Flags :: enum_flags u32 {
    PROTECTED     :: 0x00000001;
    PROTECTED_KHR :: PROTECTED;
}

Buffer_Usage_Flags :: enum_flags u32 {
    TRANSFER_SRC                                    :: 0x00000001;
    TRANSFER_DST                                    :: 0x00000002;
    UNIFORM_TEXEL_BUFFER                            :: 0x00000004;
    STORAGE_TEXEL_BUFFER                            :: 0x00000008;
    UNIFORM_BUFFER                                  :: 0x00000010;
    STORAGE_BUFFER                                  :: 0x00000020;
    INDEX_BUFFER                                    :: 0x00000040;
    VERTEX_BUFFER                                   :: 0x00000080;
    INDIRECT_BUFFER                                 :: 0x00000100;
    SHADER_DEVICE_ADDRESS                           :: 0x00020000;
    VIDEO_DECODE_SRCKHR                             :: 0x00002000;
    VIDEO_DECODE_DSTKHR                             :: 0x00004000;
    TRANSFORM_FEEDBACK_BUFFEREXT                    :: 0x00000800;
    TRANSFORM_FEEDBACK_COUNTER_BUFFEREXT            :: 0x00001000;
    CONDITIONAL_RENDERINGEXT                        :: 0x00000200;
    EXECUTION_GRAPH_SCRATCHAMDX                     :: 0x02000000;
    DESCRIPTOR_HEAPEXT                              :: 0x10000000;
    ACCELERATION_STRUCTURE_BUILD_INPUT_READ_ONLYKHR :: 0x00080000;
    ACCELERATION_STRUCTURE_STORAGEKHR               :: 0x00100000;
    SHADER_BINDING_TABLEKHR                         :: 0x00000400;
    VIDEO_ENCODE_DSTKHR                             :: 0x00008000;
    VIDEO_ENCODE_SRCKHR                             :: 0x00010000;
    SAMPLER_DESCRIPTOR_BUFFEREXT                    :: 0x00200000;
    RESOURCE_DESCRIPTOR_BUFFEREXT                   :: 0x00400000;
    PUSH_DESCRIPTORS_DESCRIPTOR_BUFFEREXT           :: 0x04000000;
    MICROMAP_BUILD_INPUT_READ_ONLYEXT               :: 0x00800000;
    MICROMAP_STORAGEEXT                             :: 0x01000000;
    TILE_MEMORYQCOM                                 :: 0x08000000;
    RAY_TRACINGNV                                   :: SHADER_BINDING_TABLEKHR;
    SHADER_DEVICE_ADDRESSEXT                        :: SHADER_DEVICE_ADDRESS;
    SHADER_DEVICE_ADDRESSKHR                        :: SHADER_DEVICE_ADDRESS;
}

Buffer_Create_Flags :: enum_flags u32 {
    SPARSE_BINDING_BIT                       :: 0x00000001;
    SPARSE_RESIDENCY_BIT                     :: 0x00000002;
    SPARSE_ALIASED_BIT                       :: 0x00000004;
    PROTECTED_BIT                            :: 0x00000008;
    DEVICE_ADDRESS_CAPTURE_REPLAY_BIT        :: 0x00000010;
    DESCRIPTOR_BUFFER_CAPTURE_REPLAY_BIT_EXT :: 0x00000020;
    VIDEO_PROFILE_INDEPENDENT_BIT_KHR        :: 0x00000040;
    DEVICE_ADDRESS_CAPTURE_REPLAY_BIT_EXT    :: DEVICE_ADDRESS_CAPTURE_REPLAY_BIT;
    DEVICE_ADDRESS_CAPTURE_REPLAY_BIT_KHR    :: DEVICE_ADDRESS_CAPTURE_REPLAY_BIT;
}

Sampler_Create_Flags :: enum_flags u32 {
    SUBSAMPLED_EXT                       :: 0x00000001;
    SUBSAMPLED_COARSE_RECONSTRUCTION_EXT :: 0x00000002;
    DESCRIPTOR_BUFFER_CAPTURE_REPLAY_EXT :: 0x00000008;
    NON_SEAMLESS_CUBE_MAP_EXT            :: 0x00000004;
    IMAGE_PROCESSING_QCOM                :: 0x00000010;
}

Descriptor_Pool_Create_Flags :: enum_flags u32 {
    FREE_DESCRIPTOR_SET           :: 0x00000001;
    UPDATE_AFTER_BIND             :: 0x00000002;
    HOST_ONLY_EXT                 :: 0x00000004;
    ALLOW_OVERALLOCATION_SETS_NV  :: 0x00000008;
    ALLOW_OVERALLOCATION_POOLS_NV :: 0x00000010;
    UPDATE_AFTER_BIND_EXT         :: UPDATE_AFTER_BIND;
    HOST_ONLY_VALVE               :: HOST_ONLY_EXT;
}

Descriptor_Binding_Flags :: enum_flags u32 {
    UPDATE_AFTER_BIND               :: 0x00000001;
    UPDATE_UNUSED_WHILE_PENDING     :: 0x00000002;
    PARTIALLY_BOUND                 :: 0x00000004;
    VARIABLE_DESCRIPTOR_COUNT       :: 0x00000008;
    UPDATE_AFTER_BIND_EXT           :: UPDATE_AFTER_BIND;
    UPDATE_UNUSED_WHILE_PENDING_EXT :: UPDATE_UNUSED_WHILE_PENDING;
    PARTIALLY_BOUND_EXT             :: PARTIALLY_BOUND;
    VARIABLE_DESCRIPTOR_COUNT_EXT   :: VARIABLE_DESCRIPTOR_COUNT;
}


Descriptor_Set_Layout_Create_Flags :: enum_flags u32 {
    UPDATE_AFTER_BIND_POOL          :: 0x00000002;
    PUSH_DESCRIPTOR                 :: 0x00000001;
    DESCRIPTOR_BUFFER_EXT           :: 0x00000010;
    EMBEDDED_IMMUTABLE_SAMPLERS_EXT :: 0x00000020;
    INDIRECT_BINDABLE_NV            :: 0x00000080;
    HOST_ONLY_POOL_EXT              :: 0x00000004;
    PER_STAGE_NV                    :: 0x00000040;
    PUSH_DESCRIPTOR_KHR             :: PUSH_DESCRIPTOR;
    UPDATE_AFTER_BIND_POOL_EXT      :: UPDATE_AFTER_BIND_POOL;
    HOST_ONLY_POOL_VALVE            :: HOST_ONLY_POOL_EXT;
}

Structure_Type :: enum u32 {
    APPLICATION_INFO                                                       :: 0;
    INSTANCE_CREATE_INFO                                                   :: 1;
    DEVICE_QUEUE_CREATE_INFO                                               :: 2;
    DEVICE_CREATE_INFO                                                     :: 3;
    SUBMIT_INFO                                                            :: 4;
    MEMORY_ALLOCATE_INFO                                                   :: 5;
    MAPPED_MEMORY_RANGE                                                    :: 6;
    BIND_SPARSE_INFO                                                       :: 7;
    FENCE_CREATE_INFO                                                      :: 8;
    SEMAPHORE_CREATE_INFO                                                  :: 9;
    EVENT_CREATE_INFO                                                      :: 10;
    QUERY_POOL_CREATE_INFO                                                 :: 11;
    BUFFER_CREATE_INFO                                                     :: 12;
    BUFFER_VIEW_CREATE_INFO                                                :: 13;
    IMAGE_CREATE_INFO                                                      :: 14;
    IMAGE_VIEW_CREATE_INFO                                                 :: 15;
    SHADER_MODULE_CREATE_INFO                                              :: 16;
    PIPELINE_CACHE_CREATE_INFO                                             :: 17;
    PIPELINE_SHADER_STAGE_CREATE_INFO                                      :: 18;
    PIPELINE_VERTEX_INPUT_STATE_CREATE_INFO                                :: 19;
    PIPELINE_INPUT_ASSEMBLY_STATE_CREATE_INFO                              :: 20;
    PIPELINE_TESSELLATION_STATE_CREATE_INFO                                :: 21;
    PIPELINE_VIEWPORT_STATE_CREATE_INFO                                    :: 22;
    PIPELINE_RASTERIZATION_STATE_CREATE_INFO                               :: 23;
    PIPELINE_MULTISAMPLE_STATE_CREATE_INFO                                 :: 24;
    PIPELINE_DEPTH_STENCIL_STATE_CREATE_INFO                               :: 25;
    PIPELINE_COLOR_BLEND_STATE_CREATE_INFO                                 :: 26;
    PIPELINE_DYNAMIC_STATE_CREATE_INFO                                     :: 27;
    GRAPHICS_PIPELINE_CREATE_INFO                                          :: 28;
    COMPUTE_PIPELINE_CREATE_INFO                                           :: 29;
    PIPELINE_LAYOUT_CREATE_INFO                                            :: 30;
    SAMPLER_CREATE_INFO                                                    :: 31;
    DESCRIPTOR_SET_LAYOUT_CREATE_INFO                                      :: 32;
    DESCRIPTOR_POOL_CREATE_INFO                                            :: 33;
    DESCRIPTOR_SET_ALLOCATE_INFO                                           :: 34;
    WRITE_DESCRIPTOR_SET                                                   :: 35;
    COPY_DESCRIPTOR_SET                                                    :: 36;
    FRAMEBUFFER_CREATE_INFO                                                :: 37;
    RENDER_PASS_CREATE_INFO                                                :: 38;
    COMMAND_POOL_CREATE_INFO                                               :: 39;
    COMMAND_BUFFER_ALLOCATE_INFO                                           :: 40;
    COMMAND_BUFFER_INHERITANCE_INFO                                        :: 41;
    COMMAND_BUFFER_BEGIN_INFO                                              :: 42;
    RENDER_PASS_BEGIN_INFO                                                 :: 43;
    BUFFER_MEMORY_BARRIER                                                  :: 44;
    IMAGE_MEMORY_BARRIER                                                   :: 45;
    MEMORY_BARRIER                                                         :: 46;
    LOADER_INSTANCE_CREATE_INFO                                            :: 47;
    LOADER_DEVICE_CREATE_INFO                                              :: 48;
    BIND_BUFFER_MEMORY_INFO                                                :: 1000157000;
    BIND_IMAGE_MEMORY_INFO                                                 :: 1000157001;
    MEMORY_DEDICATED_REQUIREMENTS                                          :: 1000127000;
    MEMORY_DEDICATED_ALLOCATE_INFO                                         :: 1000127001;
    MEMORY_ALLOCATE_FLAGS_INFO                                             :: 1000060000;
    DEVICE_GROUP_COMMAND_BUFFER_BEGIN_INFO                                 :: 1000060004;
    DEVICE_GROUP_SUBMIT_INFO                                               :: 1000060005;
    DEVICE_GROUP_BIND_SPARSE_INFO                                          :: 1000060006;
    BIND_BUFFER_MEMORY_DEVICE_GROUP_INFO                                   :: 1000060013;
    BIND_IMAGE_MEMORY_DEVICE_GROUP_INFO                                    :: 1000060014;
    PHYSICAL_DEVICE_GROUP_PROPERTIES                                       :: 1000070000;
    DEVICE_GROUP_DEVICE_CREATE_INFO                                        :: 1000070001;
    BUFFER_MEMORY_REQUIREMENTS_INFO_2                                      :: 1000146000;
    IMAGE_MEMORY_REQUIREMENTS_INFO_2                                       :: 1000146001;
    IMAGE_SPARSE_MEMORY_REQUIREMENTS_INFO_2                                :: 1000146002;
    MEMORY_REQUIREMENTS_2                                                  :: 1000146003;
    SPARSE_IMAGE_MEMORY_REQUIREMENTS_2                                     :: 1000146004;
    PHYSICAL_DEVICE_FEATURES_2                                             :: 1000059000;
    PHYSICAL_DEVICE_PROPERTIES_2                                           :: 1000059001;
    FORMAT_PROPERTIES_2                                                    :: 1000059002;
    IMAGE_FORMAT_PROPERTIES_2                                              :: 1000059003;
    PHYSICAL_DEVICE_IMAGE_FORMAT_INFO_2                                    :: 1000059004;
    QUEUE_FAMILY_PROPERTIES_2                                              :: 1000059005;
    PHYSICAL_DEVICE_MEMORY_PROPERTIES_2                                    :: 1000059006;
    SPARSE_IMAGE_FORMAT_PROPERTIES_2                                       :: 1000059007;
    PHYSICAL_DEVICE_SPARSE_IMAGE_FORMAT_INFO_2                             :: 1000059008;
    IMAGE_VIEW_USAGE_CREATE_INFO                                           :: 1000117002;
    PROTECTED_SUBMIT_INFO                                                  :: 1000145000;
    PHYSICAL_DEVICE_PROTECTED_MEMORY_FEATURES                              :: 1000145001;
    PHYSICAL_DEVICE_PROTECTED_MEMORY_PROPERTIES                            :: 1000145002;
    DEVICE_QUEUE_INFO_2                                                    :: 1000145003;
    PHYSICAL_DEVICE_EXTERNAL_IMAGE_FORMAT_INFO                             :: 1000071000;
    EXTERNAL_IMAGE_FORMAT_PROPERTIES                                       :: 1000071001;
    PHYSICAL_DEVICE_EXTERNAL_BUFFER_INFO                                   :: 1000071002;
    EXTERNAL_BUFFER_PROPERTIES                                             :: 1000071003;
    PHYSICAL_DEVICE_ID_PROPERTIES                                          :: 1000071004;
    EXTERNAL_MEMORY_BUFFER_CREATE_INFO                                     :: 1000072000;
    EXTERNAL_MEMORY_IMAGE_CREATE_INFO                                      :: 1000072001;
    EXPORT_MEMORY_ALLOCATE_INFO                                            :: 1000072002;
    PHYSICAL_DEVICE_EXTERNAL_FENCE_INFO                                    :: 1000112000;
    EXTERNAL_FENCE_PROPERTIES                                              :: 1000112001;
    EXPORT_FENCE_CREATE_INFO                                               :: 1000113000;
    EXPORT_SEMAPHORE_CREATE_INFO                                           :: 1000077000;
    PHYSICAL_DEVICE_EXTERNAL_SEMAPHORE_INFO                                :: 1000076000;
    EXTERNAL_SEMAPHORE_PROPERTIES                                          :: 1000076001;
    PHYSICAL_DEVICE_SUBGROUP_PROPERTIES                                    :: 1000094000;
    PHYSICAL_DEVICE_16BIT_STORAGE_FEATURES                                 :: 1000083000;
    PHYSICAL_DEVICE_VARIABLE_POINTERS_FEATURES                             :: 1000120000;
    DESCRIPTOR_UPDATE_TEMPLATE_CREATE_INFO                                 :: 1000085000;
    PHYSICAL_DEVICE_MAINTENANCE_3_PROPERTIES                               :: 1000168000;
    DESCRIPTOR_SET_LAYOUT_SUPPORT                                          :: 1000168001;
    SAMPLER_YCBCR_CONVERSION_CREATE_INFO                                   :: 1000156000;
    SAMPLER_YCBCR_CONVERSION_INFO                                          :: 1000156001;
    BIND_IMAGE_PLANE_MEMORY_INFO                                           :: 1000156002;
    IMAGE_PLANE_MEMORY_REQUIREMENTS_INFO                                   :: 1000156003;
    PHYSICAL_DEVICE_SAMPLER_YCBCR_CONVERSION_FEATURES                      :: 1000156004;
    SAMPLER_YCBCR_CONVERSION_IMAGE_FORMAT_PROPERTIES                       :: 1000156005;
    DEVICE_GROUP_RENDER_PASS_BEGIN_INFO                                    :: 1000060003;
    PHYSICAL_DEVICE_POINT_CLIPPING_PROPERTIES                              :: 1000117000;
    RENDER_PASS_INPUT_ATTACHMENT_ASPECT_CREATE_INFO                        :: 1000117001;
    PIPELINE_TESSELLATION_DOMAIN_ORIGIN_STATE_CREATE_INFO                  :: 1000117003;
    RENDER_PASS_MULTIVIEW_CREATE_INFO                                      :: 1000053000;
    PHYSICAL_DEVICE_MULTIVIEW_FEATURES                                     :: 1000053001;
    PHYSICAL_DEVICE_MULTIVIEW_PROPERTIES                                   :: 1000053002;
    PHYSICAL_DEVICE_SHADER_DRAW_PARAMETERS_FEATURES                        :: 1000063000;
    PHYSICAL_DEVICE_DRIVER_PROPERTIES                                      :: 1000196000;
    PHYSICAL_DEVICE_VULKAN_1_1_FEATURES                                    :: 49;
    PHYSICAL_DEVICE_VULKAN_1_1_PROPERTIES                                  :: 50;
    PHYSICAL_DEVICE_VULKAN_1_2_FEATURES                                    :: 51;
    PHYSICAL_DEVICE_VULKAN_1_2_PROPERTIES                                  :: 52;
    IMAGE_FORMAT_LIST_CREATE_INFO                                          :: 1000147000;
    PHYSICAL_DEVICE_VULKAN_MEMORY_MODEL_FEATURES                           :: 1000211000;
    PHYSICAL_DEVICE_HOST_QUERY_RESET_FEATURES                              :: 1000261000;
    PHYSICAL_DEVICE_TIMELINE_SEMAPHORE_FEATURES                            :: 1000207000;
    PHYSICAL_DEVICE_TIMELINE_SEMAPHORE_PROPERTIES                          :: 1000207001;
    SEMAPHORE_TYPE_CREATE_INFO                                             :: 1000207002;
    TIMELINE_SEMAPHORE_SUBMIT_INFO                                         :: 1000207003;
    SEMAPHORE_WAIT_INFO                                                    :: 1000207004;
    SEMAPHORE_SIGNAL_INFO                                                  :: 1000207005;
    PHYSICAL_DEVICE_BUFFER_DEVICE_ADDRESS_FEATURES                         :: 1000257000;
    BUFFER_DEVICE_ADDRESS_INFO                                             :: 1000244001;
    BUFFER_OPAQUE_CAPTURE_ADDRESS_CREATE_INFO                              :: 1000257002;
    MEMORY_OPAQUE_CAPTURE_ADDRESS_ALLOCATE_INFO                            :: 1000257003;
    DEVICE_MEMORY_OPAQUE_CAPTURE_ADDRESS_INFO                              :: 1000257004;
    PHYSICAL_DEVICE_8BIT_STORAGE_FEATURES                                  :: 1000177000;
    PHYSICAL_DEVICE_SHADER_ATOMIC_INT64_FEATURES                           :: 1000180000;
    PHYSICAL_DEVICE_SHADER_FLOAT16_INT8_FEATURES                           :: 1000082000;
    PHYSICAL_DEVICE_FLOAT_CONTROLS_PROPERTIES                              :: 1000197000;
    DESCRIPTOR_SET_LAYOUT_BINDING_FLAGS_CREATE_INFO                        :: 1000161000;
    PHYSICAL_DEVICE_DESCRIPTOR_INDEXING_FEATURES                           :: 1000161001;
    PHYSICAL_DEVICE_DESCRIPTOR_INDEXING_PROPERTIES                         :: 1000161002;
    DESCRIPTOR_SET_VARIABLE_DESCRIPTOR_COUNT_ALLOCATE_INFO                 :: 1000161003;
    DESCRIPTOR_SET_VARIABLE_DESCRIPTOR_COUNT_LAYOUT_SUPPORT                :: 1000161004;
    PHYSICAL_DEVICE_SCALAR_BLOCK_LAYOUT_FEATURES                           :: 1000221000;
    PHYSICAL_DEVICE_SAMPLER_FILTER_MINMAX_PROPERTIES                       :: 1000130000;
    SAMPLER_REDUCTION_MODE_CREATE_INFO                                     :: 1000130001;
    PHYSICAL_DEVICE_UNIFORM_BUFFER_STANDARD_LAYOUT_FEATURES                :: 1000253000;
    PHYSICAL_DEVICE_SHADER_SUBGROUP_EXTENDED_TYPES_FEATURES                :: 1000175000;
    ATTACHMENT_DESCRIPTION_2                                               :: 1000109000;
    ATTACHMENT_REFERENCE_2                                                 :: 1000109001;
    SUBPASS_DESCRIPTION_2                                                  :: 1000109002;
    SUBPASS_DEPENDENCY_2                                                   :: 1000109003;
    RENDER_PASS_CREATE_INFO_2                                              :: 1000109004;
    SUBPASS_BEGIN_INFO                                                     :: 1000109005;
    SUBPASS_END_INFO                                                       :: 1000109006;
    PHYSICAL_DEVICE_DEPTH_STENCIL_RESOLVE_PROPERTIES                       :: 1000199000;
    SUBPASS_DESCRIPTION_DEPTH_STENCIL_RESOLVE                              :: 1000199001;
    IMAGE_STENCIL_USAGE_CREATE_INFO                                        :: 1000246000;
    PHYSICAL_DEVICE_IMAGELESS_FRAMEBUFFER_FEATURES                         :: 1000108000;
    FRAMEBUFFER_ATTACHMENTS_CREATE_INFO                                    :: 1000108001;
    FRAMEBUFFER_ATTACHMENT_IMAGE_INFO                                      :: 1000108002;
    RENDER_PASS_ATTACHMENT_BEGIN_INFO                                      :: 1000108003;
    PHYSICAL_DEVICE_SEPARATE_DEPTH_STENCIL_LAYOUTS_FEATURES                :: 1000241000;
    ATTACHMENT_REFERENCE_STENCIL_LAYOUT                                    :: 1000241001;
    ATTACHMENT_DESCRIPTION_STENCIL_LAYOUT                                  :: 1000241002;
    PHYSICAL_DEVICE_VULKAN_1_3_FEATURES                                    :: 53;
    PHYSICAL_DEVICE_VULKAN_1_3_PROPERTIES                                  :: 54;
    PHYSICAL_DEVICE_TOOL_PROPERTIES                                        :: 1000245000;
    PHYSICAL_DEVICE_PRIVATE_DATA_FEATURES                                  :: 1000295000;
    DEVICE_PRIVATE_DATA_CREATE_INFO                                        :: 1000295001;
    PRIVATE_DATA_SLOT_CREATE_INFO                                          :: 1000295002;
    MEMORY_BARRIER_2                                                       :: 1000314000;
    BUFFER_MEMORY_BARRIER_2                                                :: 1000314001;
    IMAGE_MEMORY_BARRIER_2                                                 :: 1000314002;
    DEPENDENCY_INFO                                                        :: 1000314003;
    SUBMIT_INFO_2                                                          :: 1000314004;
    SEMAPHORE_SUBMIT_INFO                                                  :: 1000314005;
    COMMAND_BUFFER_SUBMIT_INFO                                             :: 1000314006;
    PHYSICAL_DEVICE_SYNCHRONIZATION_2_FEATURES                             :: 1000314007;
    COPY_BUFFER_INFO_2                                                     :: 1000337000;
    COPY_IMAGE_INFO_2                                                      :: 1000337001;
    COPY_BUFFER_TO_IMAGE_INFO_2                                            :: 1000337002;
    COPY_IMAGE_TO_BUFFER_INFO_2                                            :: 1000337003;
    BUFFER_COPY_2                                                          :: 1000337006;
    IMAGE_COPY_2                                                           :: 1000337007;
    BUFFER_IMAGE_COPY_2                                                    :: 1000337009;
    PHYSICAL_DEVICE_TEXTURE_COMPRESSION_ASTC_HDR_FEATURES                  :: 1000066000;
    FORMAT_PROPERTIES_3                                                    :: 1000360000;
    PHYSICAL_DEVICE_MAINTENANCE_4_FEATURES                                 :: 1000413000;
    PHYSICAL_DEVICE_MAINTENANCE_4_PROPERTIES                               :: 1000413001;
    DEVICE_BUFFER_MEMORY_REQUIREMENTS                                      :: 1000413002;
    DEVICE_IMAGE_MEMORY_REQUIREMENTS                                       :: 1000413003;
    PIPELINE_CREATION_FEEDBACK_CREATE_INFO                                 :: 1000192000;
    PHYSICAL_DEVICE_SHADER_TERMINATE_INVOCATION_FEATURES                   :: 1000215000;
    PHYSICAL_DEVICE_SHADER_DEMOTE_TO_HELPER_INVOCATION_FEATURES            :: 1000276000;
    PHYSICAL_DEVICE_PIPELINE_CREATION_CACHE_CONTROL_FEATURES               :: 1000297000;
    PHYSICAL_DEVICE_ZERO_INITIALIZE_WORKGROUP_MEMORY_FEATURES              :: 1000325000;
    PHYSICAL_DEVICE_IMAGE_ROBUSTNESS_FEATURES                              :: 1000335000;
    PHYSICAL_DEVICE_SUBGROUP_SIZE_CONTROL_PROPERTIES                       :: 1000225000;
    PIPELINE_SHADER_STAGE_REQUIRED_SUBGROUP_SIZE_CREATE_INFO               :: 1000225001;
    PHYSICAL_DEVICE_SUBGROUP_SIZE_CONTROL_FEATURES                         :: 1000225002;
    PHYSICAL_DEVICE_INLINE_UNIFORM_BLOCK_FEATURES                          :: 1000138000;
    PHYSICAL_DEVICE_INLINE_UNIFORM_BLOCK_PROPERTIES                        :: 1000138001;
    WRITE_DESCRIPTOR_SET_INLINE_UNIFORM_BLOCK                              :: 1000138002;
    DESCRIPTOR_POOL_INLINE_UNIFORM_BLOCK_CREATE_INFO                       :: 1000138003;
    PHYSICAL_DEVICE_SHADER_INTEGER_DOT_PRODUCT_FEATURES                    :: 1000280000;
    PHYSICAL_DEVICE_SHADER_INTEGER_DOT_PRODUCT_PROPERTIES                  :: 1000280001;
    PHYSICAL_DEVICE_TEXEL_BUFFER_ALIGNMENT_PROPERTIES                      :: 1000281001;
    BLIT_IMAGE_INFO_2                                                      :: 1000337004;
    RESOLVE_IMAGE_INFO_2                                                   :: 1000337005;
    IMAGE_BLIT_2                                                           :: 1000337008;
    IMAGE_RESOLVE_2                                                        :: 1000337010;
    RENDERING_INFO                                                         :: 1000044000;
    RENDERING_ATTACHMENT_INFO                                              :: 1000044001;
    PIPELINE_RENDERING_CREATE_INFO                                         :: 1000044002;
    PHYSICAL_DEVICE_DYNAMIC_RENDERING_FEATURES                             :: 1000044003;
    COMMAND_BUFFER_INHERITANCE_RENDERING_INFO                              :: 1000044004;
    PHYSICAL_DEVICE_VULKAN_1_4_FEATURES                                    :: 55;
    PHYSICAL_DEVICE_VULKAN_1_4_PROPERTIES                                  :: 56;
    DEVICE_QUEUE_GLOBAL_PRIORITY_CREATE_INFO                               :: 1000174000;
    PHYSICAL_DEVICE_GLOBAL_PRIORITY_QUERY_FEATURES                         :: 1000388000;
    QUEUE_FAMILY_GLOBAL_PRIORITY_PROPERTIES                                :: 1000388001;
    PHYSICAL_DEVICE_INDEX_TYPE_UINT8_FEATURES                              :: 1000265000;
    MEMORY_MAP_INFO                                                        :: 1000271000;
    MEMORY_UNMAP_INFO                                                      :: 1000271001;
    PHYSICAL_DEVICE_MAINTENANCE_5_FEATURES                                 :: 1000470000;
    PHYSICAL_DEVICE_MAINTENANCE_5_PROPERTIES                               :: 1000470001;
    DEVICE_IMAGE_SUBRESOURCE_INFO                                          :: 1000470004;
    SUBRESOURCE_LAYOUT_2                                                   :: 1000338002;
    IMAGE_SUBRESOURCE_2                                                    :: 1000338003;
    BUFFER_USAGE_FLAGS_2_CREATE_INFO                                       :: 1000470006;
    PHYSICAL_DEVICE_MAINTENANCE_6_FEATURES                                 :: 1000545000;
    PHYSICAL_DEVICE_MAINTENANCE_6_PROPERTIES                               :: 1000545001;
    BIND_MEMORY_STATUS                                                     :: 1000545002;
    PHYSICAL_DEVICE_HOST_IMAGE_COPY_FEATURES                               :: 1000270000;
    PHYSICAL_DEVICE_HOST_IMAGE_COPY_PROPERTIES                             :: 1000270001;
    MEMORY_TO_IMAGE_COPY                                                   :: 1000270002;
    IMAGE_TO_MEMORY_COPY                                                   :: 1000270003;
    COPY_IMAGE_TO_MEMORY_INFO                                              :: 1000270004;
    COPY_MEMORY_TO_IMAGE_INFO                                              :: 1000270005;
    HOST_IMAGE_LAYOUT_TRANSITION_INFO                                      :: 1000270006;
    COPY_IMAGE_TO_IMAGE_INFO                                               :: 1000270007;
    SUBRESOURCE_HOST_MEMCPY_SIZE                                           :: 1000270008;
    HOST_IMAGE_COPY_DEVICE_PERFORMANCE_QUERY                               :: 1000270009;
    PHYSICAL_DEVICE_SHADER_SUBGROUP_ROTATE_FEATURES                        :: 1000416000;
    PHYSICAL_DEVICE_SHADER_FLOAT_CONTROLS_2_FEATURES                       :: 1000528000;
    PHYSICAL_DEVICE_SHADER_EXPECT_ASSUME_FEATURES                          :: 1000544000;
    PIPELINE_CREATE_FLAGS_2_CREATE_INFO                                    :: 1000470005;
    PHYSICAL_DEVICE_PUSH_DESCRIPTOR_PROPERTIES                             :: 1000080000;
    BIND_DESCRIPTOR_SETS_INFO                                              :: 1000545003;
    PUSH_CONSTANTS_INFO                                                    :: 1000545004;
    PUSH_DESCRIPTOR_SET_INFO                                               :: 1000545005;
    PUSH_DESCRIPTOR_SET_WITH_TEMPLATE_INFO                                 :: 1000545006;
    PHYSICAL_DEVICE_PIPELINE_PROTECTED_ACCESS_FEATURES                     :: 1000466000;
    PIPELINE_ROBUSTNESS_CREATE_INFO                                        :: 1000068000;
    PHYSICAL_DEVICE_PIPELINE_ROBUSTNESS_FEATURES                           :: 1000068001;
    PHYSICAL_DEVICE_PIPELINE_ROBUSTNESS_PROPERTIES                         :: 1000068002;
    PHYSICAL_DEVICE_LINE_RASTERIZATION_FEATURES                            :: 1000259000;
    PIPELINE_RASTERIZATION_LINE_STATE_CREATE_INFO                          :: 1000259001;
    PHYSICAL_DEVICE_LINE_RASTERIZATION_PROPERTIES                          :: 1000259002;
    PHYSICAL_DEVICE_VERTEX_ATTRIBUTE_DIVISOR_PROPERTIES                    :: 1000525000;
    PIPELINE_VERTEX_INPUT_DIVISOR_STATE_CREATE_INFO                        :: 1000190001;
    PHYSICAL_DEVICE_VERTEX_ATTRIBUTE_DIVISOR_FEATURES                      :: 1000190002;
    RENDERING_AREA_INFO                                                    :: 1000470003;
    PHYSICAL_DEVICE_DYNAMIC_RENDERING_LOCAL_READ_FEATURES                  :: 1000232000;
    RENDERING_ATTACHMENT_LOCATION_INFO                                     :: 1000232001;
    RENDERING_INPUT_ATTACHMENT_INDEX_INFO                                  :: 1000232002;
    SWAPCHAIN_CREATE_INFO_KHR                                              :: 1000001000;
    PRESENT_INFO_KHR                                                       :: 1000001001;
    DEVICE_GROUP_PRESENT_CAPABILITIES_KHR                                  :: 1000060007;
    IMAGE_SWAPCHAIN_CREATE_INFO_KHR                                        :: 1000060008;
    BIND_IMAGE_MEMORY_SWAPCHAIN_INFO_KHR                                   :: 1000060009;
    ACQUIRE_NEXT_IMAGE_INFO_KHR                                            :: 1000060010;
    DEVICE_GROUP_PRESENT_INFO_KHR                                          :: 1000060011;
    DEVICE_GROUP_SWAPCHAIN_CREATE_INFO_KHR                                 :: 1000060012;
    DISPLAY_MODE_CREATE_INFO_KHR                                           :: 1000002000;
    DISPLAY_SURFACE_CREATE_INFO_KHR                                        :: 1000002001;
    DISPLAY_PRESENT_INFO_KHR                                               :: 1000003000;
    XLIB_SURFACE_CREATE_INFO_KHR                                           :: 1000004000;
    XCB_SURFACE_CREATE_INFO_KHR                                            :: 1000005000;
    WAYLAND_SURFACE_CREATE_INFO_KHR                                        :: 1000006000;
    ANDROID_SURFACE_CREATE_INFO_KHR                                        :: 1000008000;
    WIN32_SURFACE_CREATE_INFO_KHR                                          :: 1000009000;
    DEBUG_REPORT_CALLBACK_CREATE_INFO_EXT                                  :: 1000011000;
    PIPELINE_RASTERIZATION_STATE_RASTERIZATION_ORDER_AMD                   :: 1000018000;
    DEBUG_MARKER_OBJECT_NAME_INFO_EXT                                      :: 1000022000;
    DEBUG_MARKER_OBJECT_TAG_INFO_EXT                                       :: 1000022001;
    DEBUG_MARKER_MARKER_INFO_EXT                                           :: 1000022002;
    VIDEO_PROFILE_INFO_KHR                                                 :: 1000023000;
    VIDEO_CAPABILITIES_KHR                                                 :: 1000023001;
    VIDEO_PICTURE_RESOURCE_INFO_KHR                                        :: 1000023002;
    VIDEO_SESSION_MEMORY_REQUIREMENTS_KHR                                  :: 1000023003;
    BIND_VIDEO_SESSION_MEMORY_INFO_KHR                                     :: 1000023004;
    VIDEO_SESSION_CREATE_INFO_KHR                                          :: 1000023005;
    VIDEO_SESSION_PARAMETERS_CREATE_INFO_KHR                               :: 1000023006;
    VIDEO_SESSION_PARAMETERS_UPDATE_INFO_KHR                               :: 1000023007;
    VIDEO_BEGIN_CODING_INFO_KHR                                            :: 1000023008;
    VIDEO_END_CODING_INFO_KHR                                              :: 1000023009;
    VIDEO_CODING_CONTROL_INFO_KHR                                          :: 1000023010;
    VIDEO_REFERENCE_SLOT_INFO_KHR                                          :: 1000023011;
    QUEUE_FAMILY_VIDEO_PROPERTIES_KHR                                      :: 1000023012;
    VIDEO_PROFILE_LIST_INFO_KHR                                            :: 1000023013;
    PHYSICAL_DEVICE_VIDEO_FORMAT_INFO_KHR                                  :: 1000023014;
    VIDEO_FORMAT_PROPERTIES_KHR                                            :: 1000023015;
    QUEUE_FAMILY_QUERY_RESULT_STATUS_PROPERTIES_KHR                        :: 1000023016;
    VIDEO_DECODE_INFO_KHR                                                  :: 1000024000;
    VIDEO_DECODE_CAPABILITIES_KHR                                          :: 1000024001;
    VIDEO_DECODE_USAGE_INFO_KHR                                            :: 1000024002;
    DEDICATED_ALLOCATION_IMAGE_CREATE_INFO_NV                              :: 1000026000;
    DEDICATED_ALLOCATION_BUFFER_CREATE_INFO_NV                             :: 1000026001;
    DEDICATED_ALLOCATION_MEMORY_ALLOCATE_INFO_NV                           :: 1000026002;
    PHYSICAL_DEVICE_TRANSFORM_FEEDBACK_FEATURES_EXT                        :: 1000028000;
    PHYSICAL_DEVICE_TRANSFORM_FEEDBACK_PROPERTIES_EXT                      :: 1000028001;
    PIPELINE_RASTERIZATION_STATE_STREAM_CREATE_INFO_EXT                    :: 1000028002;
    CU_MODULE_CREATE_INFO_NVX                                              :: 1000029000;
    CU_FUNCTION_CREATE_INFO_NVX                                            :: 1000029001;
    CU_LAUNCH_INFO_NVX                                                     :: 1000029002;
    CU_MODULE_TEXTURING_MODE_CREATE_INFO_NVX                               :: 1000029004;
    IMAGE_VIEW_HANDLE_INFO_NVX                                             :: 1000030000;
    IMAGE_VIEW_ADDRESS_PROPERTIES_NVX                                      :: 1000030001;
    VIDEO_ENCODE_H264_CAPABILITIES_KHR                                     :: 1000038000;
    VIDEO_ENCODE_H264_SESSION_PARAMETERS_CREATE_INFO_KHR                   :: 1000038001;
    VIDEO_ENCODE_H264_SESSION_PARAMETERS_ADD_INFO_KHR                      :: 1000038002;
    VIDEO_ENCODE_H264_PICTURE_INFO_KHR                                     :: 1000038003;
    VIDEO_ENCODE_H264_DPB_SLOT_INFO_KHR                                    :: 1000038004;
    VIDEO_ENCODE_H264_NALU_SLICE_INFO_KHR                                  :: 1000038005;
    VIDEO_ENCODE_H264_GOP_REMAINING_FRAME_INFO_KHR                         :: 1000038006;
    VIDEO_ENCODE_H264_PROFILE_INFO_KHR                                     :: 1000038007;
    VIDEO_ENCODE_H264_RATE_CONTROL_INFO_KHR                                :: 1000038008;
    VIDEO_ENCODE_H264_RATE_CONTROL_LAYER_INFO_KHR                          :: 1000038009;
    VIDEO_ENCODE_H264_SESSION_CREATE_INFO_KHR                              :: 1000038010;
    VIDEO_ENCODE_H264_QUALITY_LEVEL_PROPERTIES_KHR                         :: 1000038011;
    VIDEO_ENCODE_H264_SESSION_PARAMETERS_GET_INFO_KHR                      :: 1000038012;
    VIDEO_ENCODE_H264_SESSION_PARAMETERS_FEEDBACK_INFO_KHR                 :: 1000038013;
    VIDEO_ENCODE_H265_CAPABILITIES_KHR                                     :: 1000039000;
    VIDEO_ENCODE_H265_SESSION_PARAMETERS_CREATE_INFO_KHR                   :: 1000039001;
    VIDEO_ENCODE_H265_SESSION_PARAMETERS_ADD_INFO_KHR                      :: 1000039002;
    VIDEO_ENCODE_H265_PICTURE_INFO_KHR                                     :: 1000039003;
    VIDEO_ENCODE_H265_DPB_SLOT_INFO_KHR                                    :: 1000039004;
    VIDEO_ENCODE_H265_NALU_SLICE_SEGMENT_INFO_KHR                          :: 1000039005;
    VIDEO_ENCODE_H265_GOP_REMAINING_FRAME_INFO_KHR                         :: 1000039006;
    VIDEO_ENCODE_H265_PROFILE_INFO_KHR                                     :: 1000039007;
    VIDEO_ENCODE_H265_RATE_CONTROL_INFO_KHR                                :: 1000039009;
    VIDEO_ENCODE_H265_RATE_CONTROL_LAYER_INFO_KHR                          :: 1000039010;
    VIDEO_ENCODE_H265_SESSION_CREATE_INFO_KHR                              :: 1000039011;
    VIDEO_ENCODE_H265_QUALITY_LEVEL_PROPERTIES_KHR                         :: 1000039012;
    VIDEO_ENCODE_H265_SESSION_PARAMETERS_GET_INFO_KHR                      :: 1000039013;
    VIDEO_ENCODE_H265_SESSION_PARAMETERS_FEEDBACK_INFO_KHR                 :: 1000039014;
    VIDEO_DECODE_H264_CAPABILITIES_KHR                                     :: 1000040000;
    VIDEO_DECODE_H264_PICTURE_INFO_KHR                                     :: 1000040001;
    VIDEO_DECODE_H264_PROFILE_INFO_KHR                                     :: 1000040003;
    VIDEO_DECODE_H264_SESSION_PARAMETERS_CREATE_INFO_KHR                   :: 1000040004;
    VIDEO_DECODE_H264_SESSION_PARAMETERS_ADD_INFO_KHR                      :: 1000040005;
    VIDEO_DECODE_H264_DPB_SLOT_INFO_KHR                                    :: 1000040006;
    TEXTURE_LOD_GATHER_FORMAT_PROPERTIES_AMD                               :: 1000041000;
    STREAM_DESCRIPTOR_SURFACE_CREATE_INFO_GGP                              :: 1000049000;
    PHYSICAL_DEVICE_CORNER_SAMPLED_IMAGE_FEATURES_NV                       :: 1000050000;
    EXTERNAL_MEMORY_IMAGE_CREATE_INFO_NV                                   :: 1000056000;
    EXPORT_MEMORY_ALLOCATE_INFO_NV                                         :: 1000056001;
    IMPORT_MEMORY_WIN32_HANDLE_INFO_NV                                     :: 1000057000;
    EXPORT_MEMORY_WIN32_HANDLE_INFO_NV                                     :: 1000057001;
    WIN32_KEYED_MUTEX_ACQUIRE_RELEASE_INFO_NV                              :: 1000058000;
    VALIDATION_FLAGS_EXT                                                   :: 1000061000;
    VI_SURFACE_CREATE_INFO_NN                                              :: 1000062000;
    IMAGE_VIEW_ASTC_DECODE_MODE_EXT                                        :: 1000067000;
    PHYSICAL_DEVICE_ASTC_DECODE_FEATURES_EXT                               :: 1000067001;
    IMPORT_MEMORY_WIN32_HANDLE_INFO_KHR                                    :: 1000073000;
    EXPORT_MEMORY_WIN32_HANDLE_INFO_KHR                                    :: 1000073001;
    MEMORY_WIN32_HANDLE_PROPERTIES_KHR                                     :: 1000073002;
    MEMORY_GET_WIN32_HANDLE_INFO_KHR                                       :: 1000073003;
    IMPORT_MEMORY_FD_INFO_KHR                                              :: 1000074000;
    MEMORY_FD_PROPERTIES_KHR                                               :: 1000074001;
    MEMORY_GET_FD_INFO_KHR                                                 :: 1000074002;
    WIN32_KEYED_MUTEX_ACQUIRE_RELEASE_INFO_KHR                             :: 1000075000;
    IMPORT_SEMAPHORE_WIN32_HANDLE_INFO_KHR                                 :: 1000078000;
    EXPORT_SEMAPHORE_WIN32_HANDLE_INFO_KHR                                 :: 1000078001;
    D3D12_FENCE_SUBMIT_INFO_KHR                                            :: 1000078002;
    SEMAPHORE_GET_WIN32_HANDLE_INFO_KHR                                    :: 1000078003;
    IMPORT_SEMAPHORE_FD_INFO_KHR                                           :: 1000079000;
    SEMAPHORE_GET_FD_INFO_KHR                                              :: 1000079001;
    COMMAND_BUFFER_INHERITANCE_CONDITIONAL_RENDERING_INFO_EXT              :: 1000081000;
    PHYSICAL_DEVICE_CONDITIONAL_RENDERING_FEATURES_EXT                     :: 1000081001;
    CONDITIONAL_RENDERING_BEGIN_INFO_EXT                                   :: 1000081002;
    PRESENT_REGIONS_KHR                                                    :: 1000084000;
    PIPELINE_VIEWPORT_W_SCALING_STATE_CREATE_INFO_NV                       :: 1000087000;
    SURFACE_CAPABILITIES_2_EXT                                             :: 1000090000;
    DISPLAY_POWER_INFO_EXT                                                 :: 1000091000;
    DEVICE_EVENT_INFO_EXT                                                  :: 1000091001;
    DISPLAY_EVENT_INFO_EXT                                                 :: 1000091002;
    SWAPCHAIN_COUNTER_CREATE_INFO_EXT                                      :: 1000091003;
    PRESENT_TIMES_INFO_GOOGLE                                              :: 1000092000;
    PHYSICAL_DEVICE_MULTIVIEW_PER_VIEW_ATTRIBUTES_PROPERTIES_NVX           :: 1000097000;
    MULTIVIEW_PER_VIEW_ATTRIBUTES_INFO_NVX                                 :: 1000044009;
    PIPELINE_VIEWPORT_SWIZZLE_STATE_CREATE_INFO_NV                         :: 1000098000;
    PHYSICAL_DEVICE_DISCARD_RECTANGLE_PROPERTIES_EXT                       :: 1000099000;
    PIPELINE_DISCARD_RECTANGLE_STATE_CREATE_INFO_EXT                       :: 1000099001;
    PHYSICAL_DEVICE_CONSERVATIVE_RASTERIZATION_PROPERTIES_EXT              :: 1000101000;
    PIPELINE_RASTERIZATION_CONSERVATIVE_STATE_CREATE_INFO_EXT              :: 1000101001;
    PHYSICAL_DEVICE_DEPTH_CLIP_ENABLE_FEATURES_EXT                         :: 1000102000;
    PIPELINE_RASTERIZATION_DEPTH_CLIP_STATE_CREATE_INFO_EXT                :: 1000102001;
    HDR_METADATA_EXT                                                       :: 1000105000;
    PHYSICAL_DEVICE_RELAXED_LINE_RASTERIZATION_FEATURES_IMG                :: 1000110000;
    SHARED_PRESENT_SURFACE_CAPABILITIES_KHR                                :: 1000111000;
    IMPORT_FENCE_WIN32_HANDLE_INFO_KHR                                     :: 1000114000;
    EXPORT_FENCE_WIN32_HANDLE_INFO_KHR                                     :: 1000114001;
    FENCE_GET_WIN32_HANDLE_INFO_KHR                                        :: 1000114002;
    IMPORT_FENCE_FD_INFO_KHR                                               :: 1000115000;
    FENCE_GET_FD_INFO_KHR                                                  :: 1000115001;
    PHYSICAL_DEVICE_PERFORMANCE_QUERY_FEATURES_KHR                         :: 1000116000;
    PHYSICAL_DEVICE_PERFORMANCE_QUERY_PROPERTIES_KHR                       :: 1000116001;
    QUERY_POOL_PERFORMANCE_CREATE_INFO_KHR                                 :: 1000116002;
    PERFORMANCE_QUERY_SUBMIT_INFO_KHR                                      :: 1000116003;
    ACQUIRE_PROFILING_LOCK_INFO_KHR                                        :: 1000116004;
    PERFORMANCE_COUNTER_KHR                                                :: 1000116005;
    PERFORMANCE_COUNTER_DESCRIPTION_KHR                                    :: 1000116006;
    PHYSICAL_DEVICE_SURFACE_INFO_2_KHR                                     :: 1000119000;
    SURFACE_CAPABILITIES_2_KHR                                             :: 1000119001;
    SURFACE_FORMAT_2_KHR                                                   :: 1000119002;
    DISPLAY_PROPERTIES_2_KHR                                               :: 1000121000;
    DISPLAY_PLANE_PROPERTIES_2_KHR                                         :: 1000121001;
    DISPLAY_MODE_PROPERTIES_2_KHR                                          :: 1000121002;
    DISPLAY_PLANE_INFO_2_KHR                                               :: 1000121003;
    DISPLAY_PLANE_CAPABILITIES_2_KHR                                       :: 1000121004;
    IOS_SURFACE_CREATE_INFO_MVK                                            :: 1000122000;
    MACOS_SURFACE_CREATE_INFO_MVK                                          :: 1000123000;
    DEBUG_UTILS_OBJECT_NAME_INFO_EXT                                       :: 1000128000;
    DEBUG_UTILS_OBJECT_TAG_INFO_EXT                                        :: 1000128001;
    DEBUG_UTILS_LABEL_EXT                                                  :: 1000128002;
    DEBUG_UTILS_MESSENGER_CALLBACK_DATA_EXT                                :: 1000128003;
    DEBUG_UTILS_MESSENGER_CREATE_INFO_EXT                                  :: 1000128004;
    ANDROID_HARDWARE_BUFFER_USAGE_ANDROID                                  :: 1000129000;
    ANDROID_HARDWARE_BUFFER_PROPERTIES_ANDROID                             :: 1000129001;
    ANDROID_HARDWARE_BUFFER_FORMAT_PROPERTIES_ANDROID                      :: 1000129002;
    IMPORT_ANDROID_HARDWARE_BUFFER_INFO_ANDROID                            :: 1000129003;
    MEMORY_GET_ANDROID_HARDWARE_BUFFER_INFO_ANDROID                        :: 1000129004;
    EXTERNAL_FORMAT_ANDROID                                                :: 1000129005;
    ANDROID_HARDWARE_BUFFER_FORMAT_PROPERTIES_2_ANDROID                    :: 1000129006;

    TEXEL_BUFFER_DESCRIPTOR_INFO_EXT                                       :: 1000135000;
    IMAGE_DESCRIPTOR_INFO_EXT                                              :: 1000135001;
    RESOURCE_DESCRIPTOR_INFO_EXT                                           :: 1000135002;
    BIND_HEAP_INFO_EXT                                                     :: 1000135003;
    PUSH_DATA_INFO_EXT                                                     :: 1000135004;
    DESCRIPTOR_SET_AND_BINDING_MAPPING_EXT                                 :: 1000135005;
    SHADER_DESCRIPTOR_SET_AND_BINDING_MAPPING_INFO_EXT                     :: 1000135006;
    OPAQUE_CAPTURE_DATA_CREATE_INFO_EXT                                    :: 1000135007;
    PHYSICAL_DEVICE_DESCRIPTOR_HEAP_PROPERTIES_EXT                         :: 1000135008;
    PHYSICAL_DEVICE_DESCRIPTOR_HEAP_FEATURES_EXT                           :: 1000135009;
    COMMAND_BUFFER_INHERITANCE_DESCRIPTOR_HEAP_INFO_EXT                    :: 1000135010;
    SAMPLER_CUSTOM_BORDER_COLOR_INDEX_CREATE_INFO_EXT                      :: 1000135011;
    INDIRECT_COMMANDS_LAYOUT_PUSH_DATA_TOKEN_NV                            :: 1000135012;
    SUBSAMPLED_IMAGE_FORMAT_PROPERTIES_EXT                                 :: 1000135013;
    PHYSICAL_DEVICE_DESCRIPTOR_HEAP_TENSOR_PROPERTIES_ARM                  :: 1000135014;
    ATTACHMENT_SAMPLE_COUNT_INFO_AMD                                       :: 1000044008;
    PHYSICAL_DEVICE_SHADER_BFLOAT16_FEATURES_KHR                           :: 1000141000;
    SAMPLE_LOCATIONS_INFO_EXT                                              :: 1000143000;
    RENDER_PASS_SAMPLE_LOCATIONS_BEGIN_INFO_EXT                            :: 1000143001;
    PIPELINE_SAMPLE_LOCATIONS_STATE_CREATE_INFO_EXT                        :: 1000143002;
    PHYSICAL_DEVICE_SAMPLE_LOCATIONS_PROPERTIES_EXT                        :: 1000143003;
    MULTISAMPLE_PROPERTIES_EXT                                             :: 1000143004;
    PHYSICAL_DEVICE_BLEND_OPERATION_ADVANCED_FEATURES_EXT                  :: 1000148000;
    PHYSICAL_DEVICE_BLEND_OPERATION_ADVANCED_PROPERTIES_EXT                :: 1000148001;
    PIPELINE_COLOR_BLEND_ADVANCED_STATE_CREATE_INFO_EXT                    :: 1000148002;
    PIPELINE_COVERAGE_TO_COLOR_STATE_CREATE_INFO_NV                        :: 1000149000;
    WRITE_DESCRIPTOR_SET_ACCELERATION_STRUCTURE_KHR                        :: 1000150007;
    ACCELERATION_STRUCTURE_BUILD_GEOMETRY_INFO_KHR                         :: 1000150000;
    ACCELERATION_STRUCTURE_DEVICE_ADDRESS_INFO_KHR                         :: 1000150002;
    ACCELERATION_STRUCTURE_GEOMETRY_AABBS_DATA_KHR                         :: 1000150003;
    ACCELERATION_STRUCTURE_GEOMETRY_INSTANCES_DATA_KHR                     :: 1000150004;
    ACCELERATION_STRUCTURE_GEOMETRY_TRIANGLES_DATA_KHR                     :: 1000150005;
    ACCELERATION_STRUCTURE_GEOMETRY_KHR                                    :: 1000150006;
    ACCELERATION_STRUCTURE_VERSION_INFO_KHR                                :: 1000150009;
    COPY_ACCELERATION_STRUCTURE_INFO_KHR                                   :: 1000150010;
    COPY_ACCELERATION_STRUCTURE_TO_MEMORY_INFO_KHR                         :: 1000150011;
    COPY_MEMORY_TO_ACCELERATION_STRUCTURE_INFO_KHR                         :: 1000150012;
    PHYSICAL_DEVICE_ACCELERATION_STRUCTURE_FEATURES_KHR                    :: 1000150013;
    PHYSICAL_DEVICE_ACCELERATION_STRUCTURE_PROPERTIES_KHR                  :: 1000150014;
    ACCELERATION_STRUCTURE_CREATE_INFO_KHR                                 :: 1000150017;
    ACCELERATION_STRUCTURE_BUILD_SIZES_INFO_KHR                            :: 1000150020;
    PHYSICAL_DEVICE_RAY_TRACING_PIPELINE_FEATURES_KHR                      :: 1000347000;
    PHYSICAL_DEVICE_RAY_TRACING_PIPELINE_PROPERTIES_KHR                    :: 1000347001;
    RAY_TRACING_PIPELINE_CREATE_INFO_KHR                                   :: 1000150015;
    RAY_TRACING_SHADER_GROUP_CREATE_INFO_KHR                               :: 1000150016;
    RAY_TRACING_PIPELINE_INTERFACE_CREATE_INFO_KHR                         :: 1000150018;
    PHYSICAL_DEVICE_RAY_QUERY_FEATURES_KHR                                 :: 1000348013;
    PIPELINE_COVERAGE_MODULATION_STATE_CREATE_INFO_NV                      :: 1000152000;
    PHYSICAL_DEVICE_SHADER_SM_BUILTINS_FEATURES_NV                         :: 1000154000;
    PHYSICAL_DEVICE_SHADER_SM_BUILTINS_PROPERTIES_NV                       :: 1000154001;
    DRM_FORMAT_MODIFIER_PROPERTIES_LIST_EXT                                :: 1000158000;
    PHYSICAL_DEVICE_IMAGE_DRM_FORMAT_MODIFIER_INFO_EXT                     :: 1000158002;
    IMAGE_DRM_FORMAT_MODIFIER_LIST_CREATE_INFO_EXT                         :: 1000158003;
    IMAGE_DRM_FORMAT_MODIFIER_EXPLICIT_CREATE_INFO_EXT                     :: 1000158004;
    IMAGE_DRM_FORMAT_MODIFIER_PROPERTIES_EXT                               :: 1000158005;
    DRM_FORMAT_MODIFIER_PROPERTIES_LIST_2_EXT                              :: 1000158006;
    VALIDATION_CACHE_CREATE_INFO_EXT                                       :: 1000160000;
    SHADER_MODULE_VALIDATION_CACHE_CREATE_INFO_EXT                         :: 1000160001;

    PIPELINE_VIEWPORT_SHADING_RATE_IMAGE_STATE_CREATE_INFO_NV              :: 1000164000;
    PHYSICAL_DEVICE_SHADING_RATE_IMAGE_FEATURES_NV                         :: 1000164001;
    PHYSICAL_DEVICE_SHADING_RATE_IMAGE_PROPERTIES_NV                       :: 1000164002;
    PIPELINE_VIEWPORT_COARSE_SAMPLE_ORDER_STATE_CREATE_INFO_NV             :: 1000164005;
    RAY_TRACING_PIPELINE_CREATE_INFO_NV                                    :: 1000165000;
    ACCELERATION_STRUCTURE_CREATE_INFO_NV                                  :: 1000165001;
    GEOMETRY_NV                                                            :: 1000165003;
    GEOMETRY_TRIANGLES_NV                                                  :: 1000165004;
    GEOMETRY_AABB_NV                                                       :: 1000165005;
    BIND_ACCELERATION_STRUCTURE_MEMORY_INFO_NV                             :: 1000165006;
    WRITE_DESCRIPTOR_SET_ACCELERATION_STRUCTURE_NV                         :: 1000165007;
    ACCELERATION_STRUCTURE_MEMORY_REQUIREMENTS_INFO_NV                     :: 1000165008;
    PHYSICAL_DEVICE_RAY_TRACING_PROPERTIES_NV                              :: 1000165009;
    RAY_TRACING_SHADER_GROUP_CREATE_INFO_NV                                :: 1000165011;
    ACCELERATION_STRUCTURE_INFO_NV                                         :: 1000165012;
    PHYSICAL_DEVICE_REPRESENTATIVE_FRAGMENT_TEST_FEATURES_NV               :: 1000166000;
    PIPELINE_REPRESENTATIVE_FRAGMENT_TEST_STATE_CREATE_INFO_NV             :: 1000166001;
    PHYSICAL_DEVICE_IMAGE_VIEW_IMAGE_FORMAT_INFO_EXT                       :: 1000170000;
    FILTER_CUBIC_IMAGE_VIEW_IMAGE_FORMAT_PROPERTIES_EXT                    :: 1000170001;
    PHYSICAL_DEVICE_COOPERATIVE_MATRIX_CONVERSION_FEATURES_QCOM            :: 1000172000;
    IMPORT_MEMORY_HOST_POINTER_INFO_EXT                                    :: 1000178000;
    MEMORY_HOST_POINTER_PROPERTIES_EXT                                     :: 1000178001;
    PHYSICAL_DEVICE_EXTERNAL_MEMORY_HOST_PROPERTIES_EXT                    :: 1000178002;
    PHYSICAL_DEVICE_SHADER_CLOCK_FEATURES_KHR                              :: 1000181000;
    PIPELINE_COMPILER_CONTROL_CREATE_INFO_AMD                              :: 1000183000;
    PHYSICAL_DEVICE_SHADER_CORE_PROPERTIES_AMD                             :: 1000185000;
    VIDEO_DECODE_H265_CAPABILITIES_KHR                                     :: 1000187000;
    VIDEO_DECODE_H265_SESSION_PARAMETERS_CREATE_INFO_KHR                   :: 1000187001;
    VIDEO_DECODE_H265_SESSION_PARAMETERS_ADD_INFO_KHR                      :: 1000187002;
    VIDEO_DECODE_H265_PROFILE_INFO_KHR                                     :: 1000187003;
    VIDEO_DECODE_H265_PICTURE_INFO_KHR                                     :: 1000187004;
    VIDEO_DECODE_H265_DPB_SLOT_INFO_KHR                                    :: 1000187005;
    DEVICE_MEMORY_OVERALLOCATION_CREATE_INFO_AMD                           :: 1000189000;
    PHYSICAL_DEVICE_VERTEX_ATTRIBUTE_DIVISOR_PROPERTIES_EXT                :: 1000190000;
    PRESENT_FRAME_TOKEN_GGP                                                :: 1000191000;
    PHYSICAL_DEVICE_MESH_SHADER_FEATURES_NV                                :: 1000202000;
    PHYSICAL_DEVICE_MESH_SHADER_PROPERTIES_NV                              :: 1000202001;
    PHYSICAL_DEVICE_SHADER_IMAGE_FOOTPRINT_FEATURES_NV                     :: 1000204000;
    PIPELINE_VIEWPORT_EXCLUSIVE_SCISSOR_STATE_CREATE_INFO_NV               :: 1000205000;
    PHYSICAL_DEVICE_EXCLUSIVE_SCISSOR_FEATURES_NV                          :: 1000205002;
    CHECKPOINT_DATA_NV                                                     :: 1000206000;
    QUEUE_FAMILY_CHECKPOINT_PROPERTIES_NV                                  :: 1000206001;
    QUEUE_FAMILY_CHECKPOINT_PROPERTIES_2_NV                                :: 1000314008;
    CHECKPOINT_DATA_2_NV                                                   :: 1000314009;
    PHYSICAL_DEVICE_PRESENT_TIMING_FEATURES_EXT                            :: 1000208000;
    SWAPCHAIN_TIMING_PROPERTIES_EXT                                        :: 1000208001;
    SWAPCHAIN_TIME_DOMAIN_PROPERTIES_EXT                                   :: 1000208002;
    PRESENT_TIMINGS_INFO_EXT                                               :: 1000208003;
    PRESENT_TIMING_INFO_EXT                                                :: 1000208004;
    PAST_PRESENTATION_TIMING_INFO_EXT                                      :: 1000208005;
    PAST_PRESENTATION_TIMING_PROPERTIES_EXT                                :: 1000208006;
    PAST_PRESENTATION_TIMING_EXT                                           :: 1000208007;
    PRESENT_TIMING_SURFACE_CAPABILITIES_EXT                                :: 1000208008;
    SWAPCHAIN_CALIBRATED_TIMESTAMP_INFO_EXT                                :: 1000208009;
    PHYSICAL_DEVICE_SHADER_INTEGER_FUNCTIONS_2_FEATURES_INTEL              :: 1000209000;
    QUERY_POOL_PERFORMANCE_QUERY_CREATE_INFO_INTEL                         :: 1000210000;
    INITIALIZE_PERFORMANCE_API_INFO_INTEL                                  :: 1000210001;
    PERFORMANCE_MARKER_INFO_INTEL                                          :: 1000210002;
    PERFORMANCE_STREAM_MARKER_INFO_INTEL                                   :: 1000210003;
    PERFORMANCE_OVERRIDE_INFO_INTEL                                        :: 1000210004;
    PERFORMANCE_CONFIGURATION_ACQUIRE_INFO_INTEL                           :: 1000210005;
    PHYSICAL_DEVICE_PCI_BUS_INFO_PROPERTIES_EXT                            :: 1000212000;
    DISPLAY_NATIVE_HDR_SURFACE_CAPABILITIES_AMD                            :: 1000213000;
    SWAPCHAIN_DISPLAY_NATIVE_HDR_CREATE_INFO_AMD                           :: 1000213001;
    IMAGEPIPE_SURFACE_CREATE_INFO_FUCHSIA                                  :: 1000214000;
    METAL_SURFACE_CREATE_INFO_EXT                                          :: 1000217000;
    PHYSICAL_DEVICE_FRAGMENT_DENSITY_MAP_FEATURES_EXT                      :: 1000218000;
    PHYSICAL_DEVICE_FRAGMENT_DENSITY_MAP_PROPERTIES_EXT                    :: 1000218001;
    RENDER_PASS_FRAGMENT_DENSITY_MAP_CREATE_INFO_EXT                       :: 1000218002;
    RENDERING_FRAGMENT_DENSITY_MAP_ATTACHMENT_INFO_EXT                     :: 1000044007;
    FRAGMENT_SHADING_RATE_ATTACHMENT_INFO_KHR                              :: 1000226000;
    PIPELINE_FRAGMENT_SHADING_RATE_STATE_CREATE_INFO_KHR                   :: 1000226001;
    PHYSICAL_DEVICE_FRAGMENT_SHADING_RATE_PROPERTIES_KHR                   :: 1000226002;
    PHYSICAL_DEVICE_FRAGMENT_SHADING_RATE_FEATURES_KHR                     :: 1000226003;
    PHYSICAL_DEVICE_FRAGMENT_SHADING_RATE_KHR                              :: 1000226004;
    RENDERING_FRAGMENT_SHADING_RATE_ATTACHMENT_INFO_KHR                    :: 1000044006;
    PHYSICAL_DEVICE_SHADER_CORE_PROPERTIES_2_AMD                           :: 1000227000;
    PHYSICAL_DEVICE_COHERENT_MEMORY_FEATURES_AMD                           :: 1000229000;
    PHYSICAL_DEVICE_SHADER_CONSTANT_DATA_FEATURES_KHR                      :: 1000231000;
    PHYSICAL_DEVICE_SHADER_ABORT_FEATURES_KHR                              :: 1000233000;
    DEVICE_FAULT_SHADER_ABORT_MESSAGE_INFO_KHR                             :: 1000233001;
    PHYSICAL_DEVICE_SHADER_ABORT_PROPERTIES_KHR                            :: 1000233002;
    PHYSICAL_DEVICE_SHADER_IMAGE_ATOMIC_INT64_FEATURES_EXT                 :: 1000234000;
    PHYSICAL_DEVICE_SHADER_QUAD_CONTROL_FEATURES_KHR                       :: 1000235000;
    PHYSICAL_DEVICE_MEMORY_BUDGET_PROPERTIES_EXT                           :: 1000237000;
    PHYSICAL_DEVICE_MEMORY_PRIORITY_FEATURES_EXT                           :: 1000238000;
    MEMORY_PRIORITY_ALLOCATE_INFO_EXT                                      :: 1000238001;
    SURFACE_PROTECTED_CAPABILITIES_KHR                                     :: 1000239000;
    PHYSICAL_DEVICE_DEDICATED_ALLOCATION_IMAGE_ALIASING_FEATURES_NV        :: 1000240000;
    PHYSICAL_DEVICE_BUFFER_DEVICE_ADDRESS_FEATURES_EXT                     :: 1000244000;
    BUFFER_DEVICE_ADDRESS_CREATE_INFO_EXT                                  :: 1000244002;
    VALIDATION_FEATURES_EXT                                                :: 1000247000;
    PHYSICAL_DEVICE_PRESENT_WAIT_FEATURES_KHR                              :: 1000248000;
    PHYSICAL_DEVICE_COOPERATIVE_MATRIX_FEATURES_NV                         :: 1000249000;
    COOPERATIVE_MATRIX_PROPERTIES_NV                                       :: 1000249001;
    PHYSICAL_DEVICE_COOPERATIVE_MATRIX_PROPERTIES_NV                       :: 1000249002;
    PHYSICAL_DEVICE_COVERAGE_REDUCTION_MODE_FEATURES_NV                    :: 1000250000;
    PIPELINE_COVERAGE_REDUCTION_STATE_CREATE_INFO_NV                       :: 1000250001;
    FRAMEBUFFER_MIXED_SAMPLES_COMBINATION_NV                               :: 1000250002;
    PHYSICAL_DEVICE_FRAGMENT_SHADER_INTERLOCK_FEATURES_EXT                 :: 1000251000;
    PHYSICAL_DEVICE_YCBCR_IMAGE_ARRAYS_FEATURES_EXT                        :: 1000252000;
    PHYSICAL_DEVICE_PROVOKING_VERTEX_FEATURES_EXT                          :: 1000254000;
    PIPELINE_RASTERIZATION_PROVOKING_VERTEX_STATE_CREATE_INFO_EXT          :: 1000254001;
    PHYSICAL_DEVICE_PROVOKING_VERTEX_PROPERTIES_EXT                        :: 1000254002;
    SURFACE_FULL_SCREEN_EXCLUSIVE_INFO_EXT                                 :: 1000255000;
    SURFACE_CAPABILITIES_FULL_SCREEN_EXCLUSIVE_EXT                         :: 1000255002;
    SURFACE_FULL_SCREEN_EXCLUSIVE_WIN32_INFO_EXT                           :: 1000255001;
    HEADLESS_SURFACE_CREATE_INFO_EXT                                       :: 1000256000;
    PHYSICAL_DEVICE_SHADER_ATOMIC_FLOAT_FEATURES_EXT                       :: 1000260000;
    PHYSICAL_DEVICE_EXTENDED_DYNAMIC_STATE_FEATURES_EXT                    :: 1000267000;
    PHYSICAL_DEVICE_PIPELINE_EXECUTABLE_PROPERTIES_FEATURES_KHR            :: 1000269000;
    PIPELINE_INFO_KHR                                                      :: 1000269001;
    PIPELINE_EXECUTABLE_PROPERTIES_KHR                                     :: 1000269002;
    PIPELINE_EXECUTABLE_INFO_KHR                                           :: 1000269003;
    PIPELINE_EXECUTABLE_STATISTIC_KHR                                      :: 1000269004;
    PIPELINE_EXECUTABLE_INTERNAL_REPRESENTATION_KHR                        :: 1000269005;
    PHYSICAL_DEVICE_MAP_MEMORY_PLACED_FEATURES_EXT                         :: 1000272000;
    PHYSICAL_DEVICE_MAP_MEMORY_PLACED_PROPERTIES_EXT                       :: 1000272001;
    MEMORY_MAP_PLACED_INFO_EXT                                             :: 1000272002;
    PHYSICAL_DEVICE_SHADER_ATOMIC_FLOAT_2_FEATURES_EXT                     :: 1000273000;
    PHYSICAL_DEVICE_DEVICE_GENERATED_COMMANDS_PROPERTIES_NV                :: 1000277000;
    GRAPHICS_SHADER_GROUP_CREATE_INFO_NV                                   :: 1000277001;
    GRAPHICS_PIPELINE_SHADER_GROUPS_CREATE_INFO_NV                         :: 1000277002;
    INDIRECT_COMMANDS_LAYOUT_TOKEN_NV                                      :: 1000277003;
    INDIRECT_COMMANDS_LAYOUT_CREATE_INFO_NV                                :: 1000277004;
    GENERATED_COMMANDS_INFO_NV                                             :: 1000277005;
    GENERATED_COMMANDS_MEMORY_REQUIREMENTS_INFO_NV                         :: 1000277006;
    PHYSICAL_DEVICE_DEVICE_GENERATED_COMMANDS_FEATURES_NV                  :: 1000277007;
    PHYSICAL_DEVICE_INHERITED_VIEWPORT_SCISSOR_FEATURES_NV                 :: 1000278000;
    COMMAND_BUFFER_INHERITANCE_VIEWPORT_SCISSOR_INFO_NV                    :: 1000278001;
    PHYSICAL_DEVICE_TEXEL_BUFFER_ALIGNMENT_FEATURES_EXT                    :: 1000281000;
    COMMAND_BUFFER_INHERITANCE_RENDER_PASS_TRANSFORM_INFO_QCOM             :: 1000282000;
    RENDER_PASS_TRANSFORM_BEGIN_INFO_QCOM                                  :: 1000282001;
    PHYSICAL_DEVICE_DEPTH_BIAS_CONTROL_FEATURES_EXT                        :: 1000283000;
    DEPTH_BIAS_INFO_EXT                                                    :: 1000283001;
    DEPTH_BIAS_REPRESENTATION_INFO_EXT                                     :: 1000283002;
    PHYSICAL_DEVICE_DEVICE_MEMORY_REPORT_FEATURES_EXT                      :: 1000284000;
    DEVICE_DEVICE_MEMORY_REPORT_CREATE_INFO_EXT                            :: 1000284001;
    DEVICE_MEMORY_REPORT_CALLBACK_DATA_EXT                                 :: 1000284002;
    SAMPLER_CUSTOM_BORDER_COLOR_CREATE_INFO_EXT                            :: 1000287000;
    PHYSICAL_DEVICE_CUSTOM_BORDER_COLOR_PROPERTIES_EXT                     :: 1000287001;
    PHYSICAL_DEVICE_CUSTOM_BORDER_COLOR_FEATURES_EXT                       :: 1000287002;
    PHYSICAL_DEVICE_TEXTURE_COMPRESSION_ASTC_3D_FEATURES_EXT               :: 1000288000;
    PIPELINE_LIBRARY_CREATE_INFO_KHR                                       :: 1000290000;
    PHYSICAL_DEVICE_PRESENT_BARRIER_FEATURES_NV                            :: 1000292000;
    SURFACE_CAPABILITIES_PRESENT_BARRIER_NV                                :: 1000292001;
    SWAPCHAIN_PRESENT_BARRIER_CREATE_INFO_NV                               :: 1000292002;
    PRESENT_ID_KHR                                                         :: 1000294000;
    PHYSICAL_DEVICE_PRESENT_ID_FEATURES_KHR                                :: 1000294001;
    VIDEO_ENCODE_INFO_KHR                                                  :: 1000299000;
    VIDEO_ENCODE_RATE_CONTROL_INFO_KHR                                     :: 1000299001;
    VIDEO_ENCODE_RATE_CONTROL_LAYER_INFO_KHR                               :: 1000299002;
    VIDEO_ENCODE_CAPABILITIES_KHR                                          :: 1000299003;
    VIDEO_ENCODE_USAGE_INFO_KHR                                            :: 1000299004;
    QUERY_POOL_VIDEO_ENCODE_FEEDBACK_CREATE_INFO_KHR                       :: 1000299005;
    PHYSICAL_DEVICE_VIDEO_ENCODE_QUALITY_LEVEL_INFO_KHR                    :: 1000299006;
    VIDEO_ENCODE_QUALITY_LEVEL_PROPERTIES_KHR                              :: 1000299007;
    VIDEO_ENCODE_QUALITY_LEVEL_INFO_KHR                                    :: 1000299008;
    VIDEO_ENCODE_SESSION_PARAMETERS_GET_INFO_KHR                           :: 1000299009;
    VIDEO_ENCODE_SESSION_PARAMETERS_FEEDBACK_INFO_KHR                      :: 1000299010;
    PHYSICAL_DEVICE_DIAGNOSTICS_CONFIG_FEATURES_NV                         :: 1000300000;
    DEVICE_DIAGNOSTICS_CONFIG_CREATE_INFO_NV                               :: 1000300001;
    PERF_HINT_INFO_QCOM                                                    :: 1000302000;
    PHYSICAL_DEVICE_QUEUE_PERF_HINT_FEATURES_QCOM                          :: 1000302001;
    PHYSICAL_DEVICE_QUEUE_PERF_HINT_PROPERTIES_QCOM                        :: 1000302002;

    PHYSICAL_DEVICE_TILE_SHADING_FEATURES_QCOM                             :: 1000309000;
    PHYSICAL_DEVICE_TILE_SHADING_PROPERTIES_QCOM                           :: 1000309001;
    RENDER_PASS_TILE_SHADING_CREATE_INFO_QCOM                              :: 1000309002;
    PER_TILE_BEGIN_INFO_QCOM                                               :: 1000309003;
    PER_TILE_END_INFO_QCOM                                                 :: 1000309004;
    DISPATCH_TILE_INFO_QCOM                                                :: 1000309005;
    QUERY_LOW_LATENCY_SUPPORT_NV                                           :: 1000310000;
    EXPORT_METAL_OBJECT_CREATE_INFO_EXT                                    :: 1000311000;
    EXPORT_METAL_OBJECTS_INFO_EXT                                          :: 1000311001;
    EXPORT_METAL_DEVICE_INFO_EXT                                           :: 1000311002;
    EXPORT_METAL_COMMAND_QUEUE_INFO_EXT                                    :: 1000311003;
    EXPORT_METAL_BUFFER_INFO_EXT                                           :: 1000311004;
    IMPORT_METAL_BUFFER_INFO_EXT                                           :: 1000311005;
    EXPORT_METAL_TEXTURE_INFO_EXT                                          :: 1000311006;
    IMPORT_METAL_TEXTURE_INFO_EXT                                          :: 1000311007;
    EXPORT_METAL_IO_SURFACE_INFO_EXT                                       :: 1000311008;
    IMPORT_METAL_IO_SURFACE_INFO_EXT                                       :: 1000311009;
    EXPORT_METAL_SHARED_EVENT_INFO_EXT                                     :: 1000311010;
    IMPORT_METAL_SHARED_EVENT_INFO_EXT                                     :: 1000311011;
    PHYSICAL_DEVICE_DESCRIPTOR_BUFFER_PROPERTIES_EXT                       :: 1000316000;
    PHYSICAL_DEVICE_DESCRIPTOR_BUFFER_DENSITY_MAP_PROPERTIES_EXT           :: 1000316001;
    PHYSICAL_DEVICE_DESCRIPTOR_BUFFER_FEATURES_EXT                         :: 1000316002;
    DESCRIPTOR_ADDRESS_INFO_EXT                                            :: 1000316003;
    DESCRIPTOR_GET_INFO_EXT                                                :: 1000316004;
    BUFFER_CAPTURE_DESCRIPTOR_DATA_INFO_EXT                                :: 1000316005;
    IMAGE_CAPTURE_DESCRIPTOR_DATA_INFO_EXT                                 :: 1000316006;
    IMAGE_VIEW_CAPTURE_DESCRIPTOR_DATA_INFO_EXT                            :: 1000316007;
    SAMPLER_CAPTURE_DESCRIPTOR_DATA_INFO_EXT                               :: 1000316008;
    OPAQUE_CAPTURE_DESCRIPTOR_DATA_CREATE_INFO_EXT                         :: 1000316010;
    DESCRIPTOR_BUFFER_BINDING_INFO_EXT                                     :: 1000316011;
    DESCRIPTOR_BUFFER_BINDING_PUSH_DESCRIPTOR_BUFFER_HANDLE_EXT            :: 1000316012;
    ACCELERATION_STRUCTURE_CAPTURE_DESCRIPTOR_DATA_INFO_EXT                :: 1000316009;
    DEVICE_MEMORY_COPY_KHR                                                 :: 1000318000;
    COPY_DEVICE_MEMORY_INFO_KHR                                            :: 1000318001;
    DEVICE_MEMORY_IMAGE_COPY_KHR                                           :: 1000318002;
    COPY_DEVICE_MEMORY_IMAGE_INFO_KHR                                      :: 1000318003;
    MEMORY_RANGE_BARRIERS_INFO_KHR                                         :: 1000318004;
    MEMORY_RANGE_BARRIER_KHR                                               :: 1000318005;
    PHYSICAL_DEVICE_DEVICE_ADDRESS_COMMANDS_FEATURES_KHR                   :: 1000318006;
    BIND_INDEX_BUFFER_3_INFO_KHR                                           :: 1000318007;
    BIND_VERTEX_BUFFER_3_INFO_KHR                                          :: 1000318008;
    DRAW_INDIRECT_2_INFO_KHR                                               :: 1000318009;
    DRAW_INDIRECT_COUNT_2_INFO_KHR                                         :: 1000318010;
    DISPATCH_INDIRECT_2_INFO_KHR                                           :: 1000318011;
    CONDITIONAL_RENDERING_BEGIN_INFO_2_EXT                                 :: 1000318012;
    BIND_TRANSFORM_FEEDBACK_BUFFER_2_INFO_EXT                              :: 1000318013;
    MEMORY_MARKER_INFO_AMD                                                 :: 1000318014;
    ACCELERATION_STRUCTURE_CREATE_INFO_2_KHR                               :: 1000318015;
    PHYSICAL_DEVICE_GRAPHICS_PIPELINE_LIBRARY_FEATURES_EXT                 :: 1000320000;
    PHYSICAL_DEVICE_GRAPHICS_PIPELINE_LIBRARY_PROPERTIES_EXT               :: 1000320001;
    GRAPHICS_PIPELINE_LIBRARY_CREATE_INFO_EXT                              :: 1000320002;
    PHYSICAL_DEVICE_SHADER_EARLY_AND_LATE_FRAGMENT_TESTS_FEATURES_AMD      :: 1000321000;
    PHYSICAL_DEVICE_FRAGMENT_SHADER_BARYCENTRIC_FEATURES_KHR               :: 1000203000;
    PHYSICAL_DEVICE_FRAGMENT_SHADER_BARYCENTRIC_PROPERTIES_KHR             :: 1000322000;
    PHYSICAL_DEVICE_SHADER_SUBGROUP_UNIFORM_CONTROL_FLOW_FEATURES_KHR      :: 1000323000;
    PHYSICAL_DEVICE_FRAGMENT_SHADING_RATE_ENUMS_PROPERTIES_NV              :: 1000326000;
    PHYSICAL_DEVICE_FRAGMENT_SHADING_RATE_ENUMS_FEATURES_NV                :: 1000326001;
    PIPELINE_FRAGMENT_SHADING_RATE_ENUM_STATE_CREATE_INFO_NV               :: 1000326002;
    ACCELERATION_STRUCTURE_GEOMETRY_MOTION_TRIANGLES_DATA_NV               :: 1000327000;
    PHYSICAL_DEVICE_RAY_TRACING_MOTION_BLUR_FEATURES_NV                    :: 1000327001;
    ACCELERATION_STRUCTURE_MOTION_INFO_NV                                  :: 1000327002;
    PHYSICAL_DEVICE_MESH_SHADER_FEATURES_EXT                               :: 1000328000;
    PHYSICAL_DEVICE_MESH_SHADER_PROPERTIES_EXT                             :: 1000328001;
    PHYSICAL_DEVICE_YCBCR_2_PLANE_444_FORMATS_FEATURES_EXT                 :: 1000330000;
    PHYSICAL_DEVICE_FRAGMENT_DENSITY_MAP_2_FEATURES_EXT                    :: 1000332000;
    PHYSICAL_DEVICE_FRAGMENT_DENSITY_MAP_2_PROPERTIES_EXT                  :: 1000332001;
    COPY_COMMAND_TRANSFORM_INFO_QCOM                                       :: 1000333000;
    PHYSICAL_DEVICE_WORKGROUP_MEMORY_EXPLICIT_LAYOUT_FEATURES_KHR          :: 1000336000;
    PHYSICAL_DEVICE_IMAGE_COMPRESSION_CONTROL_FEATURES_EXT                 :: 1000338000;
    IMAGE_COMPRESSION_CONTROL_EXT                                          :: 1000338001;
    IMAGE_COMPRESSION_PROPERTIES_EXT                                       :: 1000338004;
    PHYSICAL_DEVICE_ATTACHMENT_FEEDBACK_LOOP_LAYOUT_FEATURES_EXT           :: 1000339000;
    PHYSICAL_DEVICE_4444_FORMATS_FEATURES_EXT                              :: 1000340000;
    PHYSICAL_DEVICE_FAULT_FEATURES_EXT                                     :: 1000341000;
    DEVICE_FAULT_COUNTS_EXT                                                :: 1000341001;
    DEVICE_FAULT_INFO_EXT                                                  :: 1000341002;
    PHYSICAL_DEVICE_RGBA10X6_FORMATS_FEATURES_EXT                          :: 1000344000;
    DIRECTFB_SURFACE_CREATE_INFO_EXT                                       :: 1000346000;
    PHYSICAL_DEVICE_VERTEX_INPUT_DYNAMIC_STATE_FEATURES_EXT                :: 1000352000;
    VERTEX_INPUT_BINDING_DESCRIPTION_2_EXT                                 :: 1000352001;
    VERTEX_INPUT_ATTRIBUTE_DESCRIPTION_2_EXT                               :: 1000352002;
    PHYSICAL_DEVICE_DRM_PROPERTIES_EXT                                     :: 1000353000;
    PHYSICAL_DEVICE_ADDRESS_BINDING_REPORT_FEATURES_EXT                    :: 1000354000;
    DEVICE_ADDRESS_BINDING_CALLBACK_DATA_EXT                               :: 1000354001;
    PHYSICAL_DEVICE_DEPTH_CLIP_CONTROL_FEATURES_EXT                        :: 1000355000;
    PIPELINE_VIEWPORT_DEPTH_CLIP_CONTROL_CREATE_INFO_EXT                   :: 1000355001;
    PHYSICAL_DEVICE_PRIMITIVE_TOPOLOGY_LIST_RESTART_FEATURES_EXT           :: 1000356000;
    IMPORT_MEMORY_ZIRCON_HANDLE_INFO_FUCHSIA                               :: 1000364000;
    MEMORY_ZIRCON_HANDLE_PROPERTIES_FUCHSIA                                :: 1000364001;
    MEMORY_GET_ZIRCON_HANDLE_INFO_FUCHSIA                                  :: 1000364002;
    IMPORT_SEMAPHORE_ZIRCON_HANDLE_INFO_FUCHSIA                            :: 1000365000;
    SEMAPHORE_GET_ZIRCON_HANDLE_INFO_FUCHSIA                               :: 1000365001;
    BUFFER_COLLECTION_CREATE_INFO_FUCHSIA                                  :: 1000366000;
    IMPORT_MEMORY_BUFFER_COLLECTION_FUCHSIA                                :: 1000366001;
    BUFFER_COLLECTION_IMAGE_CREATE_INFO_FUCHSIA                            :: 1000366002;
    BUFFER_COLLECTION_PROPERTIES_FUCHSIA                                   :: 1000366003;
    BUFFER_CONSTRAINTS_INFO_FUCHSIA                                        :: 1000366004;
    BUFFER_COLLECTION_BUFFER_CREATE_INFO_FUCHSIA                           :: 1000366005;
    IMAGE_CONSTRAINTS_INFO_FUCHSIA                                         :: 1000366006;
    IMAGE_FORMAT_CONSTRAINTS_INFO_FUCHSIA                                  :: 1000366007;
    SYSMEM_COLOR_SPACE_FUCHSIA                                             :: 1000366008;
    BUFFER_COLLECTION_CONSTRAINTS_INFO_FUCHSIA                             :: 1000366009;
    SUBPASS_SHADING_PIPELINE_CREATE_INFO_HUAWEI                            :: 1000369000;
    PHYSICAL_DEVICE_SUBPASS_SHADING_FEATURES_HUAWEI                        :: 1000369001;
    PHYSICAL_DEVICE_SUBPASS_SHADING_PROPERTIES_HUAWEI                      :: 1000369002;
    PHYSICAL_DEVICE_INVOCATION_MASK_FEATURES_HUAWEI                        :: 1000370000;
    MEMORY_GET_REMOTE_ADDRESS_INFO_NV                                      :: 1000371000;
    PHYSICAL_DEVICE_EXTERNAL_MEMORY_RDMA_FEATURES_NV                       :: 1000371001;
    PIPELINE_PROPERTIES_IDENTIFIER_EXT                                     :: 1000372000;
    PHYSICAL_DEVICE_PIPELINE_PROPERTIES_FEATURES_EXT                       :: 1000372001;
    PHYSICAL_DEVICE_FRAME_BOUNDARY_FEATURES_EXT                            :: 1000375000;
    FRAME_BOUNDARY_EXT                                                     :: 1000375001;
    PHYSICAL_DEVICE_MULTISAMPLED_RENDER_TO_SINGLE_SAMPLED_FEATURES_EXT     :: 1000376000;
    SUBPASS_RESOLVE_PERFORMANCE_QUERY_EXT                                  :: 1000376001;
    MULTISAMPLED_RENDER_TO_SINGLE_SAMPLED_INFO_EXT                         :: 1000376002;
    PHYSICAL_DEVICE_EXTENDED_DYNAMIC_STATE_2_FEATURES_EXT                  :: 1000377000;
    SCREEN_SURFACE_CREATE_INFO_QNX                                         :: 1000378000;
    PHYSICAL_DEVICE_COLOR_WRITE_ENABLE_FEATURES_EXT                        :: 1000381000;
    PIPELINE_COLOR_WRITE_CREATE_INFO_EXT                                   :: 1000381001;
    PHYSICAL_DEVICE_PRIMITIVES_GENERATED_QUERY_FEATURES_EXT                :: 1000382000;
    PHYSICAL_DEVICE_RAY_TRACING_MAINTENANCE_1_FEATURES_KHR                 :: 1000386000;
    PHYSICAL_DEVICE_SHADER_UNTYPED_POINTERS_FEATURES_KHR                   :: 1000387000;
    PHYSICAL_DEVICE_VIDEO_ENCODE_RGB_CONVERSION_FEATURES_VALVE             :: 1000390000;
    VIDEO_ENCODE_RGB_CONVERSION_CAPABILITIES_VALVE                         :: 1000390001;
    VIDEO_ENCODE_PROFILE_RGB_CONVERSION_INFO_VALVE                         :: 1000390002;
    VIDEO_ENCODE_SESSION_RGB_CONVERSION_CREATE_INFO_VALVE                  :: 1000390003;
    PHYSICAL_DEVICE_IMAGE_VIEW_MIN_LOD_FEATURES_EXT                        :: 1000391000;
    IMAGE_VIEW_MIN_LOD_CREATE_INFO_EXT                                     :: 1000391001;
    PHYSICAL_DEVICE_MULTI_DRAW_FEATURES_EXT                                :: 1000392000;
    PHYSICAL_DEVICE_MULTI_DRAW_PROPERTIES_EXT                              :: 1000392001;
    PHYSICAL_DEVICE_IMAGE_2D_VIEW_OF_3D_FEATURES_EXT                       :: 1000393000;
    PHYSICAL_DEVICE_SHADER_TILE_IMAGE_FEATURES_EXT                         :: 1000395000;
    PHYSICAL_DEVICE_SHADER_TILE_IMAGE_PROPERTIES_EXT                       :: 1000395001;
    MICROMAP_BUILD_INFO_EXT                                                :: 1000396000;
    MICROMAP_VERSION_INFO_EXT                                              :: 1000396001;
    COPY_MICROMAP_INFO_EXT                                                 :: 1000396002;
    COPY_MICROMAP_TO_MEMORY_INFO_EXT                                       :: 1000396003;
    COPY_MEMORY_TO_MICROMAP_INFO_EXT                                       :: 1000396004;
    PHYSICAL_DEVICE_OPACITY_MICROMAP_FEATURES_EXT                          :: 1000396005;
    PHYSICAL_DEVICE_OPACITY_MICROMAP_PROPERTIES_EXT                        :: 1000396006;
    MICROMAP_CREATE_INFO_EXT                                               :: 1000396007;
    MICROMAP_BUILD_SIZES_INFO_EXT                                          :: 1000396008;
    ACCELERATION_STRUCTURE_TRIANGLES_OPACITY_MICROMAP_EXT                  :: 1000396009;

    PHYSICAL_DEVICE_CLUSTER_CULLING_SHADER_FEATURES_HUAWEI                 :: 1000404000;
    PHYSICAL_DEVICE_CLUSTER_CULLING_SHADER_PROPERTIES_HUAWEI               :: 1000404001;
    PHYSICAL_DEVICE_CLUSTER_CULLING_SHADER_VRS_FEATURES_HUAWEI             :: 1000404002;
    PHYSICAL_DEVICE_BORDER_COLOR_SWIZZLE_FEATURES_EXT                      :: 1000411000;
    SAMPLER_BORDER_COLOR_COMPONENT_MAPPING_CREATE_INFO_EXT                 :: 1000411001;
    PHYSICAL_DEVICE_PAGEABLE_DEVICE_LOCAL_MEMORY_FEATURES_EXT              :: 1000412000;
    PHYSICAL_DEVICE_SHADER_CORE_PROPERTIES_ARM                             :: 1000415000;
    DEVICE_QUEUE_SHADER_CORE_CONTROL_CREATE_INFO_ARM                       :: 1000417000;
    PHYSICAL_DEVICE_SCHEDULING_CONTROLS_FEATURES_ARM                       :: 1000417001;
    PHYSICAL_DEVICE_SCHEDULING_CONTROLS_PROPERTIES_ARM                     :: 1000417002;
    DISPATCH_PARAMETERS_ARM                                                :: 1000417003;
    PHYSICAL_DEVICE_SCHEDULING_CONTROLS_DISPATCH_PARAMETERS_PROPERTIES_ARM :: 1000417004;
    PHYSICAL_DEVICE_IMAGE_SLICED_VIEW_OF_3D_FEATURES_EXT                   :: 1000418000;
    IMAGE_VIEW_SLICED_CREATE_INFO_EXT                                      :: 1000418001;
    PHYSICAL_DEVICE_DESCRIPTOR_SET_HOST_MAPPING_FEATURES_VALVE             :: 1000420000;
    DESCRIPTOR_SET_BINDING_REFERENCE_VALVE                                 :: 1000420001;
    DESCRIPTOR_SET_LAYOUT_HOST_MAPPING_INFO_VALVE                          :: 1000420002;
    PHYSICAL_DEVICE_NON_SEAMLESS_CUBE_MAP_FEATURES_EXT                     :: 1000422000;
    PHYSICAL_DEVICE_RENDER_PASS_STRIPED_FEATURES_ARM                       :: 1000424000;
    PHYSICAL_DEVICE_RENDER_PASS_STRIPED_PROPERTIES_ARM                     :: 1000424001;
    RENDER_PASS_STRIPE_BEGIN_INFO_ARM                                      :: 1000424002;
    RENDER_PASS_STRIPE_INFO_ARM                                            :: 1000424003;
    RENDER_PASS_STRIPE_SUBMIT_INFO_ARM                                     :: 1000424004;
    PHYSICAL_DEVICE_COPY_MEMORY_INDIRECT_FEATURES_NV                       :: 1000426000;
    PHYSICAL_DEVICE_DEVICE_GENERATED_COMMANDS_COMPUTE_FEATURES_NV          :: 1000428000;
    COMPUTE_PIPELINE_INDIRECT_BUFFER_INFO_NV                               :: 1000428001;
    PIPELINE_INDIRECT_DEVICE_ADDRESS_INFO_NV                               :: 1000428002;
    PHYSICAL_DEVICE_RAY_TRACING_LINEAR_SWEPT_SPHERES_FEATURES_NV           :: 1000429008;
    ACCELERATION_STRUCTURE_GEOMETRY_LINEAR_SWEPT_SPHERES_DATA_NV           :: 1000429009;
    ACCELERATION_STRUCTURE_GEOMETRY_SPHERES_DATA_NV                        :: 1000429010;
    PHYSICAL_DEVICE_LINEAR_COLOR_ATTACHMENT_FEATURES_NV                    :: 1000430000;
    PHYSICAL_DEVICE_SHADER_MAXIMAL_RECONVERGENCE_FEATURES_KHR              :: 1000434000;
    PHYSICAL_DEVICE_IMAGE_COMPRESSION_CONTROL_SWAPCHAIN_FEATURES_EXT       :: 1000437000;
    PHYSICAL_DEVICE_IMAGE_PROCESSING_FEATURES_QCOM                         :: 1000440000;
    PHYSICAL_DEVICE_IMAGE_PROCESSING_PROPERTIES_QCOM                       :: 1000440001;
    IMAGE_VIEW_SAMPLE_WEIGHT_CREATE_INFO_QCOM                              :: 1000440002;
    PHYSICAL_DEVICE_NESTED_COMMAND_BUFFER_FEATURES_EXT                     :: 1000451000;
    PHYSICAL_DEVICE_NESTED_COMMAND_BUFFER_PROPERTIES_EXT                   :: 1000451001;
    NATIVE_BUFFER_USAGE_OHOS                                               :: 1000452000;
    NATIVE_BUFFER_PROPERTIES_OHOS                                          :: 1000452001;
    NATIVE_BUFFER_FORMAT_PROPERTIES_OHOS                                   :: 1000452002;
    IMPORT_NATIVE_BUFFER_INFO_OHOS                                         :: 1000452003;
    MEMORY_GET_NATIVE_BUFFER_INFO_OHOS                                     :: 1000452004;
    EXTERNAL_FORMAT_OHOS                                                   :: 1000452005;
    EXTERNAL_MEMORY_ACQUIRE_UNMODIFIED_EXT                                 :: 1000453000;
    PHYSICAL_DEVICE_EXTENDED_DYNAMIC_STATE_3_FEATURES_EXT                  :: 1000455000;
    PHYSICAL_DEVICE_EXTENDED_DYNAMIC_STATE_3_PROPERTIES_EXT                :: 1000455001;
    PHYSICAL_DEVICE_SUBPASS_MERGE_FEEDBACK_FEATURES_EXT                    :: 1000458000;
    RENDER_PASS_CREATION_CONTROL_EXT                                       :: 1000458001;
    RENDER_PASS_CREATION_FEEDBACK_CREATE_INFO_EXT                          :: 1000458002;
    RENDER_PASS_SUBPASS_FEEDBACK_CREATE_INFO_EXT                           :: 1000458003;
    DIRECT_DRIVER_LOADING_INFO_LUNARG                                      :: 1000459000;
    DIRECT_DRIVER_LOADING_LIST_LUNARG                                      :: 1000459001;
    TENSOR_CREATE_INFO_ARM                                                 :: 1000460000;
    TENSOR_VIEW_CREATE_INFO_ARM                                            :: 1000460001;
    BIND_TENSOR_MEMORY_INFO_ARM                                            :: 1000460002;
    WRITE_DESCRIPTOR_SET_TENSOR_ARM                                        :: 1000460003;
    PHYSICAL_DEVICE_TENSOR_PROPERTIES_ARM                                  :: 1000460004;
    TENSOR_FORMAT_PROPERTIES_ARM                                           :: 1000460005;
    TENSOR_DESCRIPTION_ARM                                                 :: 1000460006;
    TENSOR_MEMORY_REQUIREMENTS_INFO_ARM                                    :: 1000460007;
    TENSOR_MEMORY_BARRIER_ARM                                              :: 1000460008;
    PHYSICAL_DEVICE_TENSOR_FEATURES_ARM                                    :: 1000460009;
    DEVICE_TENSOR_MEMORY_REQUIREMENTS_ARM                                  :: 1000460010;
    COPY_TENSOR_INFO_ARM                                                   :: 1000460011;
    TENSOR_COPY_ARM                                                        :: 1000460012;
    TENSOR_DEPENDENCY_INFO_ARM                                             :: 1000460013;
    MEMORY_DEDICATED_ALLOCATE_INFO_TENSOR_ARM                              :: 1000460014;
    PHYSICAL_DEVICE_EXTERNAL_TENSOR_INFO_ARM                               :: 1000460015;
    EXTERNAL_TENSOR_PROPERTIES_ARM                                         :: 1000460016;
    EXTERNAL_MEMORY_TENSOR_CREATE_INFO_ARM                                 :: 1000460017;
    PHYSICAL_DEVICE_DESCRIPTOR_BUFFER_TENSOR_FEATURES_ARM                  :: 1000460018;
    PHYSICAL_DEVICE_DESCRIPTOR_BUFFER_TENSOR_PROPERTIES_ARM                :: 1000460019;
    DESCRIPTOR_GET_TENSOR_INFO_ARM                                         :: 1000460020;
    TENSOR_CAPTURE_DESCRIPTOR_DATA_INFO_ARM                                :: 1000460021;
    TENSOR_VIEW_CAPTURE_DESCRIPTOR_DATA_INFO_ARM                           :: 1000460022;
    FRAME_BOUNDARY_TENSORS_ARM                                             :: 1000460023;
    PHYSICAL_DEVICE_SHADER_MODULE_IDENTIFIER_FEATURES_EXT                  :: 1000462000;
    PHYSICAL_DEVICE_SHADER_MODULE_IDENTIFIER_PROPERTIES_EXT                :: 1000462001;
    PIPELINE_SHADER_STAGE_MODULE_IDENTIFIER_CREATE_INFO_EXT                :: 1000462002;
    SHADER_MODULE_IDENTIFIER_EXT                                           :: 1000462003;
    PHYSICAL_DEVICE_RASTERIZATION_ORDER_ATTACHMENT_ACCESS_FEATURES_EXT     :: 1000342000;
    PHYSICAL_DEVICE_OPTICAL_FLOW_FEATURES_NV                               :: 1000464000;
    PHYSICAL_DEVICE_OPTICAL_FLOW_PROPERTIES_NV                             :: 1000464001;
    OPTICAL_FLOW_IMAGE_FORMAT_INFO_NV                                      :: 1000464002;
    OPTICAL_FLOW_IMAGE_FORMAT_PROPERTIES_NV                                :: 1000464003;
    OPTICAL_FLOW_SESSION_CREATE_INFO_NV                                    :: 1000464004;
    OPTICAL_FLOW_EXECUTE_INFO_NV                                           :: 1000464005;
    OPTICAL_FLOW_SESSION_CREATE_PRIVATE_DATA_INFO_NV                       :: 1000464010;
    PHYSICAL_DEVICE_LEGACY_DITHERING_FEATURES_EXT                          :: 1000465000;
    PHYSICAL_DEVICE_EXTERNAL_FORMAT_RESOLVE_FEATURES_ANDROID               :: 1000468000;
    PHYSICAL_DEVICE_EXTERNAL_FORMAT_RESOLVE_PROPERTIES_ANDROID             :: 1000468001;
    ANDROID_HARDWARE_BUFFER_FORMAT_RESOLVE_PROPERTIES_ANDROID              :: 1000468002;
    PHYSICAL_DEVICE_ANTI_LAG_FEATURES_AMD                                  :: 1000476000;
    ANTI_LAG_DATA_AMD                                                      :: 1000476001;
    ANTI_LAG_PRESENTATION_INFO_AMD                                         :: 1000476002;

    SURFACE_CAPABILITIES_PRESENT_ID_2_KHR                                  :: 1000479000;
    PRESENT_ID_2_KHR                                                       :: 1000479001;
    PHYSICAL_DEVICE_PRESENT_ID_2_FEATURES_KHR                              :: 1000479002;
    SURFACE_CAPABILITIES_PRESENT_WAIT_2_KHR                                :: 1000480000;
    PHYSICAL_DEVICE_PRESENT_WAIT_2_FEATURES_KHR                            :: 1000480001;
    PRESENT_WAIT_2_INFO_KHR                                                :: 1000480002;
    PHYSICAL_DEVICE_RAY_TRACING_POSITION_FETCH_FEATURES_KHR                :: 1000481000;
    PHYSICAL_DEVICE_SHADER_OBJECT_FEATURES_EXT                             :: 1000482000;
    PHYSICAL_DEVICE_SHADER_OBJECT_PROPERTIES_EXT                           :: 1000482001;
    SHADER_CREATE_INFO_EXT                                                 :: 1000482002;
    PHYSICAL_DEVICE_PIPELINE_BINARY_FEATURES_KHR                           :: 1000483000;
    PIPELINE_BINARY_CREATE_INFO_KHR                                        :: 1000483001;
    PIPELINE_BINARY_INFO_KHR                                               :: 1000483002;
    PIPELINE_BINARY_KEY_KHR                                                :: 1000483003;
    PHYSICAL_DEVICE_PIPELINE_BINARY_PROPERTIES_KHR                         :: 1000483004;
    RELEASE_CAPTURED_PIPELINE_DATA_INFO_KHR                                :: 1000483005;
    PIPELINE_BINARY_DATA_INFO_KHR                                          :: 1000483006;
    PIPELINE_CREATE_INFO_KHR                                               :: 1000483007;
    DEVICE_PIPELINE_BINARY_INTERNAL_CACHE_CONTROL_KHR                      :: 1000483008;
    PIPELINE_BINARY_HANDLES_INFO_KHR                                       :: 1000483009;
    PHYSICAL_DEVICE_TILE_PROPERTIES_FEATURES_QCOM                          :: 1000484000;
    TILE_PROPERTIES_QCOM                                                   :: 1000484001;
    PHYSICAL_DEVICE_AMIGO_PROFILING_FEATURES_SEC                           :: 1000485000;
    AMIGO_PROFILING_SUBMIT_INFO_SEC                                        :: 1000485001;
    SURFACE_PRESENT_MODE_KHR                                               :: 1000274000;
    SURFACE_PRESENT_SCALING_CAPABILITIES_KHR                               :: 1000274001;
    SURFACE_PRESENT_MODE_COMPATIBILITY_KHR                                 :: 1000274002;
    PHYSICAL_DEVICE_SWAPCHAIN_MAINTENANCE_1_FEATURES_KHR                   :: 1000275000;
    SWAPCHAIN_PRESENT_FENCE_INFO_KHR                                       :: 1000275001;
    SWAPCHAIN_PRESENT_MODES_CREATE_INFO_KHR                                :: 1000275002;
    SWAPCHAIN_PRESENT_MODE_INFO_KHR                                        :: 1000275003;
    SWAPCHAIN_PRESENT_SCALING_CREATE_INFO_KHR                              :: 1000275004;
    RELEASE_SWAPCHAIN_IMAGES_INFO_KHR                                      :: 1000275005;
    PHYSICAL_DEVICE_MULTIVIEW_PER_VIEW_VIEWPORTS_FEATURES_QCOM             :: 1000488000;
    PHYSICAL_DEVICE_RAY_TRACING_INVOCATION_REORDER_FEATURES_NV             :: 1000490000;
    PHYSICAL_DEVICE_RAY_TRACING_INVOCATION_REORDER_PROPERTIES_NV           :: 1000490001;
    PHYSICAL_DEVICE_COOPERATIVE_VECTOR_FEATURES_NV                         :: 1000491000;
    PHYSICAL_DEVICE_COOPERATIVE_VECTOR_PROPERTIES_NV                       :: 1000491001;
    COOPERATIVE_VECTOR_PROPERTIES_NV                                       :: 1000491002;
    CONVERT_COOPERATIVE_VECTOR_MATRIX_INFO_NV                              :: 1000491004;
    PHYSICAL_DEVICE_EXTENDED_SPARSE_ADDRESS_SPACE_FEATURES_NV              :: 1000492000;
    PHYSICAL_DEVICE_EXTENDED_SPARSE_ADDRESS_SPACE_PROPERTIES_NV            :: 1000492001;
    PHYSICAL_DEVICE_MUTABLE_DESCRIPTOR_TYPE_FEATURES_EXT                   :: 1000351000;
    MUTABLE_DESCRIPTOR_TYPE_CREATE_INFO_EXT                                :: 1000351002;
    PHYSICAL_DEVICE_LEGACY_VERTEX_ATTRIBUTES_FEATURES_EXT                  :: 1000495000;
    PHYSICAL_DEVICE_LEGACY_VERTEX_ATTRIBUTES_PROPERTIES_EXT                :: 1000495001;
    LAYER_SETTINGS_CREATE_INFO_EXT                                         :: 1000496000;
    PHYSICAL_DEVICE_SHADER_CORE_BUILTINS_FEATURES_ARM                      :: 1000497000;
    PHYSICAL_DEVICE_SHADER_CORE_BUILTINS_PROPERTIES_ARM                    :: 1000497001;
    PHYSICAL_DEVICE_PIPELINE_LIBRARY_GROUP_HANDLES_FEATURES_EXT            :: 1000498000;
    PHYSICAL_DEVICE_DYNAMIC_RENDERING_UNUSED_ATTACHMENTS_FEATURES_EXT      :: 1000499000;
    PHYSICAL_DEVICE_INTERNALLY_SYNCHRONIZED_QUEUES_FEATURES_KHR            :: 1000504000;
    LATENCY_SLEEP_MODE_INFO_NV                                             :: 1000505000;
    LATENCY_SLEEP_INFO_NV                                                  :: 1000505001;
    SET_LATENCY_MARKER_INFO_NV                                             :: 1000505002;
    GET_LATENCY_MARKER_INFO_NV                                             :: 1000505003;
    LATENCY_TIMINGS_FRAME_REPORT_NV                                        :: 1000505004;
    LATENCY_SUBMISSION_PRESENT_ID_NV                                       :: 1000505005;
    OUT_OF_BAND_QUEUE_TYPE_INFO_NV                                         :: 1000505006;
    SWAPCHAIN_LATENCY_CREATE_INFO_NV                                       :: 1000505007;
    LATENCY_SURFACE_CAPABILITIES_NV                                        :: 1000505008;
    PHYSICAL_DEVICE_COOPERATIVE_MATRIX_FEATURES_KHR                        :: 1000506000;
    COOPERATIVE_MATRIX_PROPERTIES_KHR                                      :: 1000506001;
    PHYSICAL_DEVICE_COOPERATIVE_MATRIX_PROPERTIES_KHR                      :: 1000506002;
    DATA_GRAPH_PIPELINE_CREATE_INFO_ARM                                    :: 1000507000;
    DATA_GRAPH_PIPELINE_SESSION_CREATE_INFO_ARM                            :: 1000507001;
    DATA_GRAPH_PIPELINE_RESOURCE_INFO_ARM                                  :: 1000507002;
    DATA_GRAPH_PIPELINE_CONSTANT_ARM                                       :: 1000507003;
    DATA_GRAPH_PIPELINE_SESSION_MEMORY_REQUIREMENTS_INFO_ARM               :: 1000507004;
    BIND_DATA_GRAPH_PIPELINE_SESSION_MEMORY_INFO_ARM                       :: 1000507005;
    PHYSICAL_DEVICE_DATA_GRAPH_FEATURES_ARM                                :: 1000507006;
    DATA_GRAPH_PIPELINE_SHADER_MODULE_CREATE_INFO_ARM                      :: 1000507007;
    DATA_GRAPH_PIPELINE_PROPERTY_QUERY_RESULT_ARM                          :: 1000507008;
    DATA_GRAPH_PIPELINE_INFO_ARM                                           :: 1000507009;
    DATA_GRAPH_PIPELINE_COMPILER_CONTROL_CREATE_INFO_ARM                   :: 1000507010;
    DATA_GRAPH_PIPELINE_SESSION_BIND_POINT_REQUIREMENTS_INFO_ARM           :: 1000507011;
    DATA_GRAPH_PIPELINE_SESSION_BIND_POINT_REQUIREMENT_ARM                 :: 1000507012;
    DATA_GRAPH_PIPELINE_IDENTIFIER_CREATE_INFO_ARM                         :: 1000507013;
    DATA_GRAPH_PIPELINE_DISPATCH_INFO_ARM                                  :: 1000507014;
    DATA_GRAPH_PROCESSING_ENGINE_CREATE_INFO_ARM                           :: 1000507016;
    QUEUE_FAMILY_DATA_GRAPH_PROCESSING_ENGINE_PROPERTIES_ARM               :: 1000507017;
    QUEUE_FAMILY_DATA_GRAPH_PROPERTIES_ARM                                 :: 1000507018;
    PHYSICAL_DEVICE_QUEUE_FAMILY_DATA_GRAPH_PROCESSING_ENGINE_INFO_ARM     :: 1000507019;
    DATA_GRAPH_PIPELINE_CONSTANT_TENSOR_SEMI_STRUCTURED_SPARSITY_INFO_ARM  :: 1000507015;
    QUEUE_FAMILY_DATA_GRAPH_TOSA_PROPERTIES_ARM                            :: 1000508000;
    PHYSICAL_DEVICE_MULTIVIEW_PER_VIEW_RENDER_AREAS_FEATURES_QCOM          :: 1000510000;
    MULTIVIEW_PER_VIEW_RENDER_AREAS_RENDER_PASS_BEGIN_INFO_QCOM            :: 1000510001;
    PHYSICAL_DEVICE_COMPUTE_SHADER_DERIVATIVES_FEATURES_KHR                :: 1000201000;
    PHYSICAL_DEVICE_COMPUTE_SHADER_DERIVATIVES_PROPERTIES_KHR              :: 1000511000;
    VIDEO_DECODE_AV1_CAPABILITIES_KHR                                      :: 1000512000;
    VIDEO_DECODE_AV1_PICTURE_INFO_KHR                                      :: 1000512001;
    VIDEO_DECODE_AV1_PROFILE_INFO_KHR                                      :: 1000512003;
    VIDEO_DECODE_AV1_SESSION_PARAMETERS_CREATE_INFO_KHR                    :: 1000512004;
    VIDEO_DECODE_AV1_DPB_SLOT_INFO_KHR                                     :: 1000512005;
    VIDEO_ENCODE_AV1_CAPABILITIES_KHR                                      :: 1000513000;
    VIDEO_ENCODE_AV1_SESSION_PARAMETERS_CREATE_INFO_KHR                    :: 1000513001;
    VIDEO_ENCODE_AV1_PICTURE_INFO_KHR                                      :: 1000513002;
    VIDEO_ENCODE_AV1_DPB_SLOT_INFO_KHR                                     :: 1000513003;
    PHYSICAL_DEVICE_VIDEO_ENCODE_AV1_FEATURES_KHR                          :: 1000513004;
    VIDEO_ENCODE_AV1_PROFILE_INFO_KHR                                      :: 1000513005;
    VIDEO_ENCODE_AV1_RATE_CONTROL_INFO_KHR                                 :: 1000513006;
    VIDEO_ENCODE_AV1_RATE_CONTROL_LAYER_INFO_KHR                           :: 1000513007;
    VIDEO_ENCODE_AV1_QUALITY_LEVEL_PROPERTIES_KHR                          :: 1000513008;
    VIDEO_ENCODE_AV1_SESSION_CREATE_INFO_KHR                               :: 1000513009;
    VIDEO_ENCODE_AV1_GOP_REMAINING_FRAME_INFO_KHR                          :: 1000513010;
    PHYSICAL_DEVICE_VIDEO_DECODE_VP9_FEATURES_KHR                          :: 1000514000;
    VIDEO_DECODE_VP9_CAPABILITIES_KHR                                      :: 1000514001;
    VIDEO_DECODE_VP9_PICTURE_INFO_KHR                                      :: 1000514002;
    VIDEO_DECODE_VP9_PROFILE_INFO_KHR                                      :: 1000514003;
    PHYSICAL_DEVICE_VIDEO_MAINTENANCE_1_FEATURES_KHR                       :: 1000515000;
    VIDEO_INLINE_QUERY_INFO_KHR                                            :: 1000515001;
    PHYSICAL_DEVICE_PER_STAGE_DESCRIPTOR_SET_FEATURES_NV                   :: 1000516000;
    PHYSICAL_DEVICE_IMAGE_PROCESSING_2_FEATURES_QCOM                       :: 1000518000;
    PHYSICAL_DEVICE_IMAGE_PROCESSING_2_PROPERTIES_QCOM                     :: 1000518001;
    SAMPLER_BLOCK_MATCH_WINDOW_CREATE_INFO_QCOM                            :: 1000518002;
    SAMPLER_CUBIC_WEIGHTS_CREATE_INFO_QCOM                                 :: 1000519000;
    PHYSICAL_DEVICE_CUBIC_WEIGHTS_FEATURES_QCOM                            :: 1000519001;
    BLIT_IMAGE_CUBIC_WEIGHTS_INFO_QCOM                                     :: 1000519002;
    PHYSICAL_DEVICE_YCBCR_DEGAMMA_FEATURES_QCOM                            :: 1000520000;
    SAMPLER_YCBCR_CONVERSION_YCBCR_DEGAMMA_CREATE_INFO_QCOM                :: 1000520001;
    PHYSICAL_DEVICE_CUBIC_CLAMP_FEATURES_QCOM                              :: 1000521000;
    PHYSICAL_DEVICE_ATTACHMENT_FEEDBACK_LOOP_DYNAMIC_STATE_FEATURES_EXT    :: 1000524000;
    PHYSICAL_DEVICE_UNIFIED_IMAGE_LAYOUTS_FEATURES_KHR                     :: 1000527000;
    ATTACHMENT_FEEDBACK_LOOP_INFO_EXT                                      :: 1000527001;
    SCREEN_BUFFER_PROPERTIES_QNX                                           :: 1000529000;
    SCREEN_BUFFER_FORMAT_PROPERTIES_QNX                                    :: 1000529001;
    IMPORT_SCREEN_BUFFER_INFO_QNX                                          :: 1000529002;
    EXTERNAL_FORMAT_QNX                                                    :: 1000529003;
    PHYSICAL_DEVICE_EXTERNAL_MEMORY_SCREEN_BUFFER_FEATURES_QNX             :: 1000529004;
    PHYSICAL_DEVICE_LAYERED_DRIVER_PROPERTIES_MSFT                         :: 1000530000;
    CALIBRATED_TIMESTAMP_INFO_KHR                                          :: 1000184000;
    SET_DESCRIPTOR_BUFFER_OFFSETS_INFO_EXT                                 :: 1000545007;
    BIND_DESCRIPTOR_BUFFER_EMBEDDED_SAMPLERS_INFO_EXT                      :: 1000545008;
    PHYSICAL_DEVICE_DESCRIPTOR_POOL_OVERALLOCATION_FEATURES_NV             :: 1000546000;
    PHYSICAL_DEVICE_TILE_MEMORY_HEAP_FEATURES_QCOM                         :: 1000547000;
    PHYSICAL_DEVICE_TILE_MEMORY_HEAP_PROPERTIES_QCOM                       :: 1000547001;
    TILE_MEMORY_REQUIREMENTS_QCOM                                          :: 1000547002;
    TILE_MEMORY_BIND_INFO_QCOM                                             :: 1000547003;
    TILE_MEMORY_SIZE_INFO_QCOM                                             :: 1000547004;
    PHYSICAL_DEVICE_COPY_MEMORY_INDIRECT_FEATURES_KHR                      :: 1000549000;
    PHYSICAL_DEVICE_COPY_MEMORY_INDIRECT_PROPERTIES_KHR                    :: 1000426001;
    COPY_MEMORY_INDIRECT_INFO_KHR                                          :: 1000549002;
    COPY_MEMORY_TO_IMAGE_INDIRECT_INFO_KHR                                 :: 1000549003;
    PHYSICAL_DEVICE_MEMORY_DECOMPRESSION_FEATURES_EXT                      :: 1000427000;
    PHYSICAL_DEVICE_MEMORY_DECOMPRESSION_PROPERTIES_EXT                    :: 1000427001;
    DECOMPRESS_MEMORY_INFO_EXT                                             :: 1000550002;
    DISPLAY_SURFACE_STEREO_CREATE_INFO_NV                                  :: 1000551000;
    DISPLAY_MODE_STEREO_PROPERTIES_NV                                      :: 1000551001;
    VIDEO_ENCODE_INTRA_REFRESH_CAPABILITIES_KHR                            :: 1000552000;
    VIDEO_ENCODE_SESSION_INTRA_REFRESH_CREATE_INFO_KHR                     :: 1000552001;
    VIDEO_ENCODE_INTRA_REFRESH_INFO_KHR                                    :: 1000552002;
    VIDEO_REFERENCE_INTRA_REFRESH_INFO_KHR                                 :: 1000552003;
    PHYSICAL_DEVICE_VIDEO_ENCODE_INTRA_REFRESH_FEATURES_KHR                :: 1000552004;
    VIDEO_ENCODE_QUANTIZATION_MAP_CAPABILITIES_KHR                         :: 1000553000;
    VIDEO_FORMAT_QUANTIZATION_MAP_PROPERTIES_KHR                           :: 1000553001;
    VIDEO_ENCODE_QUANTIZATION_MAP_INFO_KHR                                 :: 1000553002;
    VIDEO_ENCODE_QUANTIZATION_MAP_SESSION_PARAMETERS_CREATE_INFO_KHR       :: 1000553005;
    PHYSICAL_DEVICE_VIDEO_ENCODE_QUANTIZATION_MAP_FEATURES_KHR             :: 1000553009;
    VIDEO_ENCODE_H264_QUANTIZATION_MAP_CAPABILITIES_KHR                    :: 1000553003;
    VIDEO_ENCODE_H265_QUANTIZATION_MAP_CAPABILITIES_KHR                    :: 1000553004;
    VIDEO_FORMAT_H265_QUANTIZATION_MAP_PROPERTIES_KHR                      :: 1000553006;
    VIDEO_ENCODE_AV1_QUANTIZATION_MAP_CAPABILITIES_KHR                     :: 1000553007;
    VIDEO_FORMAT_AV1_QUANTIZATION_MAP_PROPERTIES_KHR                       :: 1000553008;
    PHYSICAL_DEVICE_RAW_ACCESS_CHAINS_FEATURES_NV                          :: 1000555000;
    EXTERNAL_COMPUTE_QUEUE_DEVICE_CREATE_INFO_NV                           :: 1000556000;
    EXTERNAL_COMPUTE_QUEUE_CREATE_INFO_NV                                  :: 1000556001;
    EXTERNAL_COMPUTE_QUEUE_DATA_PARAMS_NV                                  :: 1000556002;
    PHYSICAL_DEVICE_EXTERNAL_COMPUTE_QUEUE_PROPERTIES_NV                   :: 1000556003;
    PHYSICAL_DEVICE_SHADER_RELAXED_EXTENDED_INSTRUCTION_FEATURES_KHR       :: 1000558000;
    PHYSICAL_DEVICE_COMMAND_BUFFER_INHERITANCE_FEATURES_NV                 :: 1000559000;
    PHYSICAL_DEVICE_MAINTENANCE_7_FEATURES_KHR                             :: 1000562000;
    PHYSICAL_DEVICE_MAINTENANCE_7_PROPERTIES_KHR                           :: 1000562001;
    PHYSICAL_DEVICE_LAYERED_API_PROPERTIES_LIST_KHR                        :: 1000562002;
    PHYSICAL_DEVICE_LAYERED_API_PROPERTIES_KHR                             :: 1000562003;
    PHYSICAL_DEVICE_LAYERED_API_VULKAN_PROPERTIES_KHR                      :: 1000562004;
    PHYSICAL_DEVICE_SHADER_ATOMIC_FLOAT16_VECTOR_FEATURES_NV               :: 1000563000;
    PHYSICAL_DEVICE_SHADER_REPLICATED_COMPOSITES_FEATURES_EXT              :: 1000564000;
    PHYSICAL_DEVICE_SHADER_FLOAT8_FEATURES_EXT                             :: 1000567000;
    PHYSICAL_DEVICE_RAY_TRACING_VALIDATION_FEATURES_NV                     :: 1000568000;
    PHYSICAL_DEVICE_CLUSTER_ACCELERATION_STRUCTURE_FEATURES_NV             :: 1000569000;
    PHYSICAL_DEVICE_CLUSTER_ACCELERATION_STRUCTURE_PROPERTIES_NV           :: 1000569001;
    CLUSTER_ACCELERATION_STRUCTURE_CLUSTERS_BOTTOM_LEVEL_INPUT_NV          :: 1000569002;
    CLUSTER_ACCELERATION_STRUCTURE_TRIANGLE_CLUSTER_INPUT_NV               :: 1000569003;
    CLUSTER_ACCELERATION_STRUCTURE_MOVE_OBJECTS_INPUT_NV                   :: 1000569004;
    CLUSTER_ACCELERATION_STRUCTURE_INPUT_INFO_NV                           :: 1000569005;
    CLUSTER_ACCELERATION_STRUCTURE_COMMANDS_INFO_NV                        :: 1000569006;
    RAY_TRACING_PIPELINE_CLUSTER_ACCELERATION_STRUCTURE_CREATE_INFO_NV     :: 1000569007;
    PHYSICAL_DEVICE_PARTITIONED_ACCELERATION_STRUCTURE_FEATURES_NV         :: 1000570000;
    PHYSICAL_DEVICE_PARTITIONED_ACCELERATION_STRUCTURE_PROPERTIES_NV       :: 1000570001;
    WRITE_DESCRIPTOR_SET_PARTITIONED_ACCELERATION_STRUCTURE_NV             :: 1000570002;
    PARTITIONED_ACCELERATION_STRUCTURE_INSTANCES_INPUT_NV                  :: 1000570003;
    BUILD_PARTITIONED_ACCELERATION_STRUCTURE_INFO_NV                       :: 1000570004;
    PARTITIONED_ACCELERATION_STRUCTURE_FLAGS_NV                            :: 1000570005;
    PHYSICAL_DEVICE_DEVICE_GENERATED_COMMANDS_FEATURES_EXT                 :: 1000572000;
    PHYSICAL_DEVICE_DEVICE_GENERATED_COMMANDS_PROPERTIES_EXT               :: 1000572001;
    GENERATED_COMMANDS_MEMORY_REQUIREMENTS_INFO_EXT                        :: 1000572002;
    INDIRECT_EXECUTION_SET_CREATE_INFO_EXT                                 :: 1000572003;
    GENERATED_COMMANDS_INFO_EXT                                            :: 1000572004;
    INDIRECT_COMMANDS_LAYOUT_CREATE_INFO_EXT                               :: 1000572006;
    INDIRECT_COMMANDS_LAYOUT_TOKEN_EXT                                     :: 1000572007;
    WRITE_INDIRECT_EXECUTION_SET_PIPELINE_EXT                              :: 1000572008;
    WRITE_INDIRECT_EXECUTION_SET_SHADER_EXT                                :: 1000572009;
    INDIRECT_EXECUTION_SET_PIPELINE_INFO_EXT                               :: 1000572010;
    INDIRECT_EXECUTION_SET_SHADER_INFO_EXT                                 :: 1000572011;
    INDIRECT_EXECUTION_SET_SHADER_LAYOUT_INFO_EXT                          :: 1000572012;
    GENERATED_COMMANDS_PIPELINE_INFO_EXT                                   :: 1000572013;
    GENERATED_COMMANDS_SHADER_INFO_EXT                                     :: 1000572014;
    PHYSICAL_DEVICE_FAULT_FEATURES_KHR                                     :: 1000573000;
    PHYSICAL_DEVICE_FAULT_PROPERTIES_KHR                                   :: 1000573001;
    DEVICE_FAULT_INFO_KHR                                                  :: 1000573002;
    DEVICE_FAULT_DEBUG_INFO_KHR                                            :: 1000573003;
    PHYSICAL_DEVICE_MAINTENANCE_8_FEATURES_KHR                             :: 1000574000;
    MEMORY_BARRIER_ACCESS_FLAGS_3_KHR                                      :: 1000574002;
    PHYSICAL_DEVICE_IMAGE_ALIGNMENT_CONTROL_FEATURES_MESA                  :: 1000575000;
    PHYSICAL_DEVICE_IMAGE_ALIGNMENT_CONTROL_PROPERTIES_MESA                :: 1000575001;
    IMAGE_ALIGNMENT_CONTROL_CREATE_INFO_MESA                               :: 1000575002;
    PHYSICAL_DEVICE_SHADER_FMA_FEATURES_KHR                                :: 1000579000;
    PUSH_CONSTANT_BANK_INFO_NV                                             :: 1000580000;
    PHYSICAL_DEVICE_PUSH_CONSTANT_BANK_FEATURES_NV                         :: 1000580001;
    PHYSICAL_DEVICE_PUSH_CONSTANT_BANK_PROPERTIES_NV                       :: 1000580002;
    PHYSICAL_DEVICE_RAY_TRACING_INVOCATION_REORDER_FEATURES_EXT            :: 1000581000;
    PHYSICAL_DEVICE_RAY_TRACING_INVOCATION_REORDER_PROPERTIES_EXT          :: 1000581001;
    PHYSICAL_DEVICE_DEPTH_CLAMP_CONTROL_FEATURES_EXT                       :: 1000582000;
    PIPELINE_VIEWPORT_DEPTH_CLAMP_CONTROL_CREATE_INFO_EXT                  :: 1000582001;
    PHYSICAL_DEVICE_MAINTENANCE_9_FEATURES_KHR                             :: 1000584000;
    PHYSICAL_DEVICE_MAINTENANCE_9_PROPERTIES_KHR                           :: 1000584001;
    QUEUE_FAMILY_OWNERSHIP_TRANSFER_PROPERTIES_KHR                         :: 1000584002;
    PHYSICAL_DEVICE_VIDEO_MAINTENANCE_2_FEATURES_KHR                       :: 1000586000;
    VIDEO_DECODE_H264_INLINE_SESSION_PARAMETERS_INFO_KHR                   :: 1000586001;
    VIDEO_DECODE_H265_INLINE_SESSION_PARAMETERS_INFO_KHR                   :: 1000586002;
    VIDEO_DECODE_AV1_INLINE_SESSION_PARAMETERS_INFO_KHR                    :: 1000586003;
    SURFACE_CREATE_INFO_OHOS                                               :: 1000685000;
    PHYSICAL_DEVICE_HDR_VIVID_FEATURES_HUAWEI                              :: 1000590000;
    HDR_VIVID_DYNAMIC_METADATA_HUAWEI                                      :: 1000590001;
    PHYSICAL_DEVICE_COOPERATIVE_MATRIX_2_FEATURES_NV                       :: 1000593000;
    COOPERATIVE_MATRIX_FLEXIBLE_DIMENSIONS_PROPERTIES_NV                   :: 1000593001;
    PHYSICAL_DEVICE_COOPERATIVE_MATRIX_2_PROPERTIES_NV                     :: 1000593002;
    PHYSICAL_DEVICE_PIPELINE_OPACITY_MICROMAP_FEATURES_ARM                 :: 1000596000;
    IMPORT_MEMORY_METAL_HANDLE_INFO_EXT                                    :: 1000602000;
    MEMORY_METAL_HANDLE_PROPERTIES_EXT                                     :: 1000602001;
    MEMORY_GET_METAL_HANDLE_INFO_EXT                                       :: 1000602002;
    PHYSICAL_DEVICE_DEPTH_CLAMP_ZERO_ONE_FEATURES_KHR                      :: 1000421000;
    PHYSICAL_DEVICE_PERFORMANCE_COUNTERS_BY_REGION_FEATURES_ARM            :: 1000605000;
    PHYSICAL_DEVICE_PERFORMANCE_COUNTERS_BY_REGION_PROPERTIES_ARM          :: 1000605001;
    PERFORMANCE_COUNTER_ARM                                                :: 1000605002;
    PERFORMANCE_COUNTER_DESCRIPTION_ARM                                    :: 1000605003;
    RENDER_PASS_PERFORMANCE_COUNTERS_BY_REGION_BEGIN_INFO_ARM              :: 1000605004;
    PHYSICAL_DEVICE_SHADER_INSTRUMENTATION_FEATURES_ARM                    :: 1000607000;
    PHYSICAL_DEVICE_SHADER_INSTRUMENTATION_PROPERTIES_ARM                  :: 1000607001;
    SHADER_INSTRUMENTATION_CREATE_INFO_ARM                                 :: 1000607002;
    SHADER_INSTRUMENTATION_METRIC_DESCRIPTION_ARM                          :: 1000607003;
    PHYSICAL_DEVICE_VERTEX_ATTRIBUTE_ROBUSTNESS_FEATURES_EXT               :: 1000608000;
    PHYSICAL_DEVICE_FORMAT_PACK_FEATURES_ARM                               :: 1000609000;
    PHYSICAL_DEVICE_FRAGMENT_DENSITY_MAP_LAYERED_FEATURES_VALVE            :: 1000611000;
    PHYSICAL_DEVICE_FRAGMENT_DENSITY_MAP_LAYERED_PROPERTIES_VALVE          :: 1000611001;
    PIPELINE_FRAGMENT_DENSITY_MAP_LAYERED_CREATE_INFO_VALVE                :: 1000611002;
    PHYSICAL_DEVICE_ROBUSTNESS_2_FEATURES_KHR                              :: 1000286000;
    PHYSICAL_DEVICE_ROBUSTNESS_2_PROPERTIES_KHR                            :: 1000286001;
    SET_PRESENT_CONFIG_NV                                                  :: 1000613000;
    PHYSICAL_DEVICE_PRESENT_METERING_FEATURES_NV                           :: 1000613001;
    PHYSICAL_DEVICE_FRAGMENT_DENSITY_MAP_OFFSET_FEATURES_EXT               :: 1000425000;
    PHYSICAL_DEVICE_FRAGMENT_DENSITY_MAP_OFFSET_PROPERTIES_EXT             :: 1000425001;
    RENDER_PASS_FRAGMENT_DENSITY_MAP_OFFSET_END_INFO_EXT                   :: 1000425002;
    PHYSICAL_DEVICE_ZERO_INITIALIZE_DEVICE_MEMORY_FEATURES_EXT             :: 1000620000;
    PHYSICAL_DEVICE_PRESENT_MODE_FIFO_LATEST_READY_FEATURES_KHR            :: 1000361000;
    PHYSICAL_DEVICE_SHADER_64_BIT_INDEXING_FEATURES_EXT                    :: 1000627000;
    PHYSICAL_DEVICE_CUSTOM_RESOLVE_FEATURES_EXT                            :: 1000628000;
    BEGIN_CUSTOM_RESOLVE_INFO_EXT                                          :: 1000628001;
    CUSTOM_RESOLVE_CREATE_INFO_EXT                                         :: 1000628002;
    PHYSICAL_DEVICE_DATA_GRAPH_MODEL_FEATURES_QCOM                         :: 1000629000;
    DATA_GRAPH_PIPELINE_BUILTIN_MODEL_CREATE_INFO_QCOM                     :: 1000629001;
    PHYSICAL_DEVICE_MAINTENANCE_10_FEATURES_KHR                            :: 1000630000;
    PHYSICAL_DEVICE_MAINTENANCE_10_PROPERTIES_KHR                          :: 1000630001;
    RENDERING_ATTACHMENT_FLAGS_INFO_KHR                                    :: 1000630002;
    RENDERING_END_INFO_KHR                                                 :: 1000619003;
    RESOLVE_IMAGE_MODE_INFO_KHR                                            :: 1000630004;
    PHYSICAL_DEVICE_DATA_GRAPH_OPTICAL_FLOW_FEATURES_ARM                   :: 1000631000;
    QUEUE_FAMILY_DATA_GRAPH_OPTICAL_FLOW_PROPERTIES_ARM                    :: 1000631001;
    DATA_GRAPH_OPTICAL_FLOW_IMAGE_FORMAT_INFO_ARM                          :: 1000631003;
    DATA_GRAPH_OPTICAL_FLOW_IMAGE_FORMAT_PROPERTIES_ARM                    :: 1000631004;
    DATA_GRAPH_PIPELINE_OPTICAL_FLOW_DISPATCH_INFO_ARM                     :: 1000631005;
    DATA_GRAPH_PIPELINE_OPTICAL_FLOW_CREATE_INFO_ARM                       :: 1000631002;
    DATA_GRAPH_PIPELINE_RESOURCE_INFO_IMAGE_LAYOUT_ARM                     :: 1000631006;
    DATA_GRAPH_PIPELINE_SINGLE_NODE_CREATE_INFO_ARM                        :: 1000631007;
    DATA_GRAPH_PIPELINE_SINGLE_NODE_CONNECTION_ARM                         :: 1000631008;
    PHYSICAL_DEVICE_SHADER_LONG_VECTOR_FEATURES_EXT                        :: 1000635000;
    PHYSICAL_DEVICE_SHADER_LONG_VECTOR_PROPERTIES_EXT                      :: 1000635001;
    PHYSICAL_DEVICE_PIPELINE_CACHE_INCREMENTAL_MODE_FEATURES_SEC           :: 1000637000;
    PHYSICAL_DEVICE_SHADER_UNIFORM_BUFFER_UNSIZED_ARRAY_FEATURES_EXT       :: 1000642000;
    COMPUTE_OCCUPANCY_PRIORITY_PARAMETERS_NV                               :: 1000645000;
    PHYSICAL_DEVICE_COMPUTE_OCCUPANCY_PRIORITY_FEATURES_NV                 :: 1000645001;
    PHYSICAL_DEVICE_MAINTENANCE_11_FEATURES_KHR                            :: 1000657000;
    QUEUE_FAMILY_OPTIMAL_IMAGE_TRANSFER_GRANULARITY_PROPERTIES_KHR         :: 1000657001;
    PHYSICAL_DEVICE_SHADER_SUBGROUP_PARTITIONED_FEATURES_EXT               :: 1000662000;
    UBM_SURFACE_CREATE_INFO_SEC                                            :: 1000664000;
    PHYSICAL_DEVICE_SHADER_MIXED_FLOAT_DOT_PRODUCT_FEATURES_VALVE          :: 1000673000;
    PHYSICAL_DEVICE_THROTTLE_HINT_FEATURES_SEC                             :: 1000674000;
    THROTTLE_HINT_SUBMIT_INFO_SEC                                          :: 1000674001;
    DATA_GRAPH_PIPELINE_NEURAL_STATISTICS_CREATE_INFO_ARM                  :: 1000676000;
    DATA_GRAPH_PIPELINE_SESSION_NEURAL_STATISTICS_CREATE_INFO_ARM          :: 1000676001;
    PHYSICAL_DEVICE_DATA_GRAPH_NEURAL_ACCELERATOR_STATISTICS_FEATURES_ARM  :: 1000676002;
    PHYSICAL_DEVICE_PRIMITIVE_RESTART_INDEX_FEATURES_EXT                   :: 1000678000;
    PHYSICAL_DEVICE_VARIABLE_POINTER_FEATURES                              :: 1000120000;
    PHYSICAL_DEVICE_SHADER_DRAW_PARAMETER_FEATURES                         :: 1000063000;

    DEBUG_REPORT_CREATE_INFO_EXT                                           :: 1000011000;
    RENDERING_INFO_KHR                                                     :: 1000044000;
    RENDERING_ATTACHMENT_INFO_KHR                                          :: 1000044001;
    PIPELINE_RENDERING_CREATE_INFO_KHR                                     :: 1000044002;
    PHYSICAL_DEVICE_DYNAMIC_RENDERING_FEATURES_KHR                         :: 1000044003;
    COMMAND_BUFFER_INHERITANCE_RENDERING_INFO_KHR                          :: 1000044004;
    RENDER_PASS_MULTIVIEW_CREATE_INFO_KHR                                  :: 1000053000;
    PHYSICAL_DEVICE_MULTIVIEW_FEATURES_KHR                                 :: 1000053001;
    PHYSICAL_DEVICE_MULTIVIEW_PROPERTIES_KHR                               :: 1000053002;
    PHYSICAL_DEVICE_FEATURES_2_KHR                                         :: 1000059000;
    PHYSICAL_DEVICE_PROPERTIES_2_KHR                                       :: 1000059001;
    FORMAT_PROPERTIES_2_KHR                                                :: 1000059002;
    IMAGE_FORMAT_PROPERTIES_2_KHR                                          :: 1000059003;
    PHYSICAL_DEVICE_IMAGE_FORMAT_INFO_2_KHR                                :: 1000059004;
    QUEUE_FAMILY_PROPERTIES_2_KHR                                          :: 1000059005;
    PHYSICAL_DEVICE_MEMORY_PROPERTIES_2_KHR                                :: 1000059006;
    SPARSE_IMAGE_FORMAT_PROPERTIES_2_KHR                                   :: 1000059007;
    PHYSICAL_DEVICE_SPARSE_IMAGE_FORMAT_INFO_2_KHR                         :: 1000059008;
    MEMORY_ALLOCATE_FLAGS_INFO_KHR                                         :: 1000060000;
    DEVICE_GROUP_RENDER_PASS_BEGIN_INFO_KHR                                :: 1000060003;
    DEVICE_GROUP_COMMAND_BUFFER_BEGIN_INFO_KHR                             :: 1000060004;
    DEVICE_GROUP_SUBMIT_INFO_KHR                                           :: 1000060005;
    DEVICE_GROUP_BIND_SPARSE_INFO_KHR                                      :: 1000060006;
    BIND_BUFFER_MEMORY_DEVICE_GROUP_INFO_KHR                               :: 1000060013;
    BIND_IMAGE_MEMORY_DEVICE_GROUP_INFO_KHR                                :: 1000060014;
    PHYSICAL_DEVICE_TEXTURE_COMPRESSION_ASTC_HDR_FEATURES_EXT              :: 1000066000;
    PIPELINE_ROBUSTNESS_CREATE_INFO_EXT                                    :: 1000068000;
    PHYSICAL_DEVICE_PIPELINE_ROBUSTNESS_FEATURES_EXT                       :: 1000068001;
    PHYSICAL_DEVICE_PIPELINE_ROBUSTNESS_PROPERTIES_EXT                     :: 1000068002;
    PHYSICAL_DEVICE_GROUP_PROPERTIES_KHR                                   :: 1000070000;
    DEVICE_GROUP_DEVICE_CREATE_INFO_KHR                                    :: 1000070001;
    PHYSICAL_DEVICE_EXTERNAL_IMAGE_FORMAT_INFO_KHR                         :: 1000071000;
    EXTERNAL_IMAGE_FORMAT_PROPERTIES_KHR                                   :: 1000071001;
    PHYSICAL_DEVICE_EXTERNAL_BUFFER_INFO_KHR                               :: 1000071002;
    EXTERNAL_BUFFER_PROPERTIES_KHR                                         :: 1000071003;
    PHYSICAL_DEVICE_ID_PROPERTIES_KHR                                      :: 1000071004;
    EXTERNAL_MEMORY_BUFFER_CREATE_INFO_KHR                                 :: 1000072000;
    EXTERNAL_MEMORY_IMAGE_CREATE_INFO_KHR                                  :: 1000072001;
    EXPORT_MEMORY_ALLOCATE_INFO_KHR                                        :: 1000072002;
    PHYSICAL_DEVICE_EXTERNAL_SEMAPHORE_INFO_KHR                            :: 1000076000;
    EXTERNAL_SEMAPHORE_PROPERTIES_KHR                                      :: 1000076001;
    EXPORT_SEMAPHORE_CREATE_INFO_KHR                                       :: 1000077000;
    PHYSICAL_DEVICE_PUSH_DESCRIPTOR_PROPERTIES_KHR                         :: 1000080000;
    PHYSICAL_DEVICE_SHADER_FLOAT16_INT8_FEATURES_KHR                       :: 1000082000;
    PHYSICAL_DEVICE_FLOAT16_INT8_FEATURES_KHR                              :: 1000082000;
    PHYSICAL_DEVICE_16BIT_STORAGE_FEATURES_KHR                             :: 1000083000;
    DESCRIPTOR_UPDATE_TEMPLATE_CREATE_INFO_KHR                             :: 1000085000;

    SURFACE_CAPABILITIES2_EXT                                              :: 1000090000;
    PHYSICAL_DEVICE_IMAGELESS_FRAMEBUFFER_FEATURES_KHR                     :: 1000108000;
    FRAMEBUFFER_ATTACHMENTS_CREATE_INFO_KHR                                :: 1000108001;
    FRAMEBUFFER_ATTACHMENT_IMAGE_INFO_KHR                                  :: 1000108002;
    RENDER_PASS_ATTACHMENT_BEGIN_INFO_KHR                                  :: 1000108003;
    ATTACHMENT_DESCRIPTION_2_KHR                                           :: 1000109000;
    ATTACHMENT_REFERENCE_2_KHR                                             :: 1000109001;
    SUBPASS_DESCRIPTION_2_KHR                                              :: 1000109002;
    SUBPASS_DEPENDENCY_2_KHR                                               :: 1000109003;
    RENDER_PASS_CREATE_INFO_2_KHR                                          :: 1000109004;
    SUBPASS_BEGIN_INFO_KHR                                                 :: 1000109005;
    SUBPASS_END_INFO_KHR                                                   :: 1000109006;
    PHYSICAL_DEVICE_EXTERNAL_FENCE_INFO_KHR                                :: 1000112000;
    EXTERNAL_FENCE_PROPERTIES_KHR                                          :: 1000112001;
    EXPORT_FENCE_CREATE_INFO_KHR                                           :: 1000113000;
    PHYSICAL_DEVICE_POINT_CLIPPING_PROPERTIES_KHR                          :: 1000117000;
    RENDER_PASS_INPUT_ATTACHMENT_ASPECT_CREATE_INFO_KHR                    :: 1000117001;
    IMAGE_VIEW_USAGE_CREATE_INFO_KHR                                       :: 1000117002;
    PIPELINE_TESSELLATION_DOMAIN_ORIGIN_STATE_CREATE_INFO_KHR              :: 1000117003;
    PHYSICAL_DEVICE_VARIABLE_POINTERS_FEATURES_KHR                         :: 1000120000;
    PHYSICAL_DEVICE_VARIABLE_POINTER_FEATURES_KHR                          :: 1000120000;
    MEMORY_DEDICATED_REQUIREMENTS_KHR                                      :: 1000127000;
    MEMORY_DEDICATED_ALLOCATE_INFO_KHR                                     :: 1000127001;
    PHYSICAL_DEVICE_SAMPLER_FILTER_MINMAX_PROPERTIES_EXT                   :: 1000130000;
    SAMPLER_REDUCTION_MODE_CREATE_INFO_EXT                                 :: 1000130001;
    PHYSICAL_DEVICE_INLINE_UNIFORM_BLOCK_FEATURES_EXT                      :: 1000138000;
    PHYSICAL_DEVICE_INLINE_UNIFORM_BLOCK_PROPERTIES_EXT                    :: 1000138001;
    WRITE_DESCRIPTOR_SET_INLINE_UNIFORM_BLOCK_EXT                          :: 1000138002;
    DESCRIPTOR_POOL_INLINE_UNIFORM_BLOCK_CREATE_INFO_EXT                   :: 1000138003;
    BUFFER_MEMORY_REQUIREMENTS_INFO_2_KHR                                  :: 1000146000;
    IMAGE_MEMORY_REQUIREMENTS_INFO_2_KHR                                   :: 1000146001;
    IMAGE_SPARSE_MEMORY_REQUIREMENTS_INFO_2_KHR                            :: 1000146002;
    MEMORY_REQUIREMENTS_2_KHR                                              :: 1000146003;
    SPARSE_IMAGE_MEMORY_REQUIREMENTS_2_KHR                                 :: 1000146004;
    IMAGE_FORMAT_LIST_CREATE_INFO_KHR                                      :: 1000147000;
    ATTACHMENT_SAMPLE_COUNT_INFO_NV                                        :: 1000044008;
    SAMPLER_YCBCR_CONVERSION_CREATE_INFO_KHR                               :: 1000156000;
    SAMPLER_YCBCR_CONVERSION_INFO_KHR                                      :: 1000156001;
    BIND_IMAGE_PLANE_MEMORY_INFO_KHR                                       :: 1000156002;
    IMAGE_PLANE_MEMORY_REQUIREMENTS_INFO_KHR                               :: 1000156003;
    PHYSICAL_DEVICE_SAMPLER_YCBCR_CONVERSION_FEATURES_KHR                  :: 1000156004;
    SAMPLER_YCBCR_CONVERSION_IMAGE_FORMAT_PROPERTIES_KHR                   :: 1000156005;
    BIND_BUFFER_MEMORY_INFO_KHR                                            :: 1000157000;
    BIND_IMAGE_MEMORY_INFO_KHR                                             :: 1000157001;
    DESCRIPTOR_SET_LAYOUT_BINDING_FLAGS_CREATE_INFO_EXT                    :: 1000161000;
    PHYSICAL_DEVICE_DESCRIPTOR_INDEXING_FEATURES_EXT                       :: 1000161001;
    PHYSICAL_DEVICE_DESCRIPTOR_INDEXING_PROPERTIES_EXT                     :: 1000161002;
    DESCRIPTOR_SET_VARIABLE_DESCRIPTOR_COUNT_ALLOCATE_INFO_EXT             :: 1000161003;
    DESCRIPTOR_SET_VARIABLE_DESCRIPTOR_COUNT_LAYOUT_SUPPORT_EXT            :: 1000161004;
    PHYSICAL_DEVICE_MAINTENANCE_3_PROPERTIES_KHR                           :: 1000168000;
    DESCRIPTOR_SET_LAYOUT_SUPPORT_KHR                                      :: 1000168001;
    DEVICE_QUEUE_GLOBAL_PRIORITY_CREATE_INFO_EXT                           :: 1000174000;
    PHYSICAL_DEVICE_SHADER_SUBGROUP_EXTENDED_TYPES_FEATURES_KHR            :: 1000175000;
    PHYSICAL_DEVICE_8BIT_STORAGE_FEATURES_KHR                              :: 1000177000;
    PHYSICAL_DEVICE_SHADER_ATOMIC_INT64_FEATURES_KHR                       :: 1000180000;
    CALIBRATED_TIMESTAMP_INFO_EXT                                          :: 1000184000;
    DEVICE_QUEUE_GLOBAL_PRIORITY_CREATE_INFO_KHR                           :: 1000174000;
    PHYSICAL_DEVICE_GLOBAL_PRIORITY_QUERY_FEATURES_KHR                     :: 1000388000;
    QUEUE_FAMILY_GLOBAL_PRIORITY_PROPERTIES_KHR                            :: 1000388001;
    PIPELINE_VERTEX_INPUT_DIVISOR_STATE_CREATE_INFO_EXT                    :: 1000190001;
    PHYSICAL_DEVICE_VERTEX_ATTRIBUTE_DIVISOR_FEATURES_EXT                  :: 1000190002;
    PIPELINE_CREATION_FEEDBACK_CREATE_INFO_EXT                             :: 1000192000;
    PHYSICAL_DEVICE_DRIVER_PROPERTIES_KHR                                  :: 1000196000;
    PHYSICAL_DEVICE_FLOAT_CONTROLS_PROPERTIES_KHR                          :: 1000197000;
    PHYSICAL_DEVICE_DEPTH_STENCIL_RESOLVE_PROPERTIES_KHR                   :: 1000199000;
    SUBPASS_DESCRIPTION_DEPTH_STENCIL_RESOLVE_KHR                          :: 1000199001;
    PHYSICAL_DEVICE_COMPUTE_SHADER_DERIVATIVES_FEATURES_NV                 :: 1000201000;
    PHYSICAL_DEVICE_FRAGMENT_SHADER_BARYCENTRIC_FEATURES_NV                :: 1000203000;
    PHYSICAL_DEVICE_TIMELINE_SEMAPHORE_FEATURES_KHR                        :: 1000207000;
    PHYSICAL_DEVICE_TIMELINE_SEMAPHORE_PROPERTIES_KHR                      :: 1000207001;
    SEMAPHORE_TYPE_CREATE_INFO_KHR                                         :: 1000207002;
    TIMELINE_SEMAPHORE_SUBMIT_INFO_KHR                                     :: 1000207003;
    SEMAPHORE_WAIT_INFO_KHR                                                :: 1000207004;
    SEMAPHORE_SIGNAL_INFO_KHR                                              :: 1000207005;

    QUERY_POOL_CREATE_INFO_INTEL                                           :: 1000210000;
    PHYSICAL_DEVICE_VULKAN_MEMORY_MODEL_FEATURES_KHR                       :: 1000211000;
    PHYSICAL_DEVICE_SHADER_TERMINATE_INVOCATION_FEATURES_KHR               :: 1000215000;
    PHYSICAL_DEVICE_SCALAR_BLOCK_LAYOUT_FEATURES_EXT                       :: 1000221000;
    PHYSICAL_DEVICE_SUBGROUP_SIZE_CONTROL_PROPERTIES_EXT                   :: 1000225000;
    PIPELINE_SHADER_STAGE_REQUIRED_SUBGROUP_SIZE_CREATE_INFO_EXT           :: 1000225001;
    PHYSICAL_DEVICE_SUBGROUP_SIZE_CONTROL_FEATURES_EXT                     :: 1000225002;
    PHYSICAL_DEVICE_DYNAMIC_RENDERING_LOCAL_READ_FEATURES_KHR              :: 1000232000;
    RENDERING_ATTACHMENT_LOCATION_INFO_KHR                                 :: 1000232001;
    RENDERING_INPUT_ATTACHMENT_INDEX_INFO_KHR                              :: 1000232002;
    PHYSICAL_DEVICE_SEPARATE_DEPTH_STENCIL_LAYOUTS_FEATURES_KHR            :: 1000241000;
    ATTACHMENT_REFERENCE_STENCIL_LAYOUT_KHR                                :: 1000241001;
    ATTACHMENT_DESCRIPTION_STENCIL_LAYOUT_KHR                              :: 1000241002;
    PHYSICAL_DEVICE_BUFFER_ADDRESS_FEATURES_EXT                            :: 1000244000;
    BUFFER_DEVICE_ADDRESS_INFO_EXT                                         :: 1000244001;
    PHYSICAL_DEVICE_TOOL_PROPERTIES_EXT                                    :: 1000245000;
    IMAGE_STENCIL_USAGE_CREATE_INFO_EXT                                    :: 1000246000;
    PHYSICAL_DEVICE_UNIFORM_BUFFER_STANDARD_LAYOUT_FEATURES_KHR            :: 1000253000;
    PHYSICAL_DEVICE_BUFFER_DEVICE_ADDRESS_FEATURES_KHR                     :: 1000257000;
    BUFFER_DEVICE_ADDRESS_INFO_KHR                                         :: 1000244001;
    BUFFER_OPAQUE_CAPTURE_ADDRESS_CREATE_INFO_KHR                          :: 1000257002;
    MEMORY_OPAQUE_CAPTURE_ADDRESS_ALLOCATE_INFO_KHR                        :: 1000257003;
    DEVICE_MEMORY_OPAQUE_CAPTURE_ADDRESS_INFO_KHR                          :: 1000257004;
    PHYSICAL_DEVICE_LINE_RASTERIZATION_FEATURES_EXT                        :: 1000259000;
    PIPELINE_RASTERIZATION_LINE_STATE_CREATE_INFO_EXT                      :: 1000259001;
    PHYSICAL_DEVICE_LINE_RASTERIZATION_PROPERTIES_EXT                      :: 1000259002;
    PHYSICAL_DEVICE_HOST_QUERY_RESET_FEATURES_EXT                          :: 1000261000;
    PHYSICAL_DEVICE_INDEX_TYPE_UINT8_FEATURES_EXT                          :: 1000265000;
    PHYSICAL_DEVICE_HOST_IMAGE_COPY_FEATURES_EXT                           :: 1000270000;
    PHYSICAL_DEVICE_HOST_IMAGE_COPY_PROPERTIES_EXT                         :: 1000270001;
    MEMORY_TO_IMAGE_COPY_EXT                                               :: 1000270002;
    IMAGE_TO_MEMORY_COPY_EXT                                               :: 1000270003;
    COPY_IMAGE_TO_MEMORY_INFO_EXT                                          :: 1000270004;
    COPY_MEMORY_TO_IMAGE_INFO_EXT                                          :: 1000270005;
    HOST_IMAGE_LAYOUT_TRANSITION_INFO_EXT                                  :: 1000270006;
    COPY_IMAGE_TO_IMAGE_INFO_EXT                                           :: 1000270007;
    SUBRESOURCE_HOST_MEMCPY_SIZE_EXT                                       :: 1000270008;
    HOST_IMAGE_COPY_DEVICE_PERFORMANCE_QUERY_EXT                           :: 1000270009;
    MEMORY_MAP_INFO_KHR                                                    :: 1000271000;
    MEMORY_UNMAP_INFO_KHR                                                  :: 1000271001;
    SURFACE_PRESENT_MODE_EXT                                               :: 1000274000;
    SURFACE_PRESENT_SCALING_CAPABILITIES_EXT                               :: 1000274001;
    SURFACE_PRESENT_MODE_COMPATIBILITY_EXT                                 :: 1000274002;
    PHYSICAL_DEVICE_SWAPCHAIN_MAINTENANCE_1_FEATURES_EXT                   :: 1000275000;
    SWAPCHAIN_PRESENT_FENCE_INFO_EXT                                       :: 1000275001;
    SWAPCHAIN_PRESENT_MODES_CREATE_INFO_EXT                                :: 1000275002;
    SWAPCHAIN_PRESENT_MODE_INFO_EXT                                        :: 1000275003;
    SWAPCHAIN_PRESENT_SCALING_CREATE_INFO_EXT                              :: 1000275004;
    RELEASE_SWAPCHAIN_IMAGES_INFO_EXT                                      :: 1000275005;
    PHYSICAL_DEVICE_SHADER_DEMOTE_TO_HELPER_INVOCATION_FEATURES_EXT        :: 1000276000;
    PHYSICAL_DEVICE_SHADER_INTEGER_DOT_PRODUCT_FEATURES_KHR                :: 1000280000;
    PHYSICAL_DEVICE_SHADER_INTEGER_DOT_PRODUCT_PROPERTIES_KHR              :: 1000280001;
    PHYSICAL_DEVICE_TEXEL_BUFFER_ALIGNMENT_PROPERTIES_EXT                  :: 1000281001;
    PHYSICAL_DEVICE_ROBUSTNESS_2_FEATURES_EXT                              :: 1000286000;
    PHYSICAL_DEVICE_ROBUSTNESS_2_PROPERTIES_EXT                            :: 1000286001;
    PHYSICAL_DEVICE_PRIVATE_DATA_FEATURES_EXT                              :: 1000295000;
    DEVICE_PRIVATE_DATA_CREATE_INFO_EXT                                    :: 1000295001;
    PRIVATE_DATA_SLOT_CREATE_INFO_EXT                                      :: 1000295002;
    PHYSICAL_DEVICE_PIPELINE_CREATION_CACHE_CONTROL_FEATURES_EXT           :: 1000297000;
    MEMORY_BARRIER_2_KHR                                                   :: 1000314000;
    BUFFER_MEMORY_BARRIER_2_KHR                                            :: 1000314001;
    IMAGE_MEMORY_BARRIER_2_KHR                                             :: 1000314002;
    DEPENDENCY_INFO_KHR                                                    :: 1000314003;
    SUBMIT_INFO_2_KHR                                                      :: 1000314004;
    SEMAPHORE_SUBMIT_INFO_KHR                                              :: 1000314005;
    COMMAND_BUFFER_SUBMIT_INFO_KHR                                         :: 1000314006;
    PHYSICAL_DEVICE_SYNCHRONIZATION_2_FEATURES_KHR                         :: 1000314007;
    PHYSICAL_DEVICE_ZERO_INITIALIZE_WORKGROUP_MEMORY_FEATURES_KHR          :: 1000325000;
    PHYSICAL_DEVICE_IMAGE_ROBUSTNESS_FEATURES_EXT                          :: 1000335000;
    COPY_BUFFER_INFO_2_KHR                                                 :: 1000337000;
    COPY_IMAGE_INFO_2_KHR                                                  :: 1000337001;
    COPY_BUFFER_TO_IMAGE_INFO_2_KHR                                        :: 1000337002;
    COPY_IMAGE_TO_BUFFER_INFO_2_KHR                                        :: 1000337003;
    BLIT_IMAGE_INFO_2_KHR                                                  :: 1000337004;
    RESOLVE_IMAGE_INFO_2_KHR                                               :: 1000337005;
    BUFFER_COPY_2_KHR                                                      :: 1000337006;
    IMAGE_COPY_2_KHR                                                       :: 1000337007;
    IMAGE_BLIT_2_KHR                                                       :: 1000337008;
    BUFFER_IMAGE_COPY_2_KHR                                                :: 1000337009;
    IMAGE_RESOLVE_2_KHR                                                    :: 1000337010;
    SUBRESOURCE_LAYOUT_2_EXT                                               :: 1000338002;
    IMAGE_SUBRESOURCE_2_EXT                                                :: 1000338003;
    PHYSICAL_DEVICE_RASTERIZATION_ORDER_ATTACHMENT_ACCESS_FEATURES_ARM     :: 1000342000;
    PHYSICAL_DEVICE_MUTABLE_DESCRIPTOR_TYPE_FEATURES_VALVE                 :: 1000351000;
    MUTABLE_DESCRIPTOR_TYPE_CREATE_INFO_VALVE                              :: 1000351002;
    FORMAT_PROPERTIES_3_KHR                                                :: 1000360000;
    PHYSICAL_DEVICE_PRESENT_MODE_FIFO_LATEST_READY_FEATURES_EXT            :: 1000361000;
    PIPELINE_INFO_EXT                                                      :: 1000269001;
    PHYSICAL_DEVICE_GLOBAL_PRIORITY_QUERY_FEATURES_EXT                     :: 1000388000;
    QUEUE_FAMILY_GLOBAL_PRIORITY_PROPERTIES_EXT                            :: 1000388001;
    PHYSICAL_DEVICE_MAINTENANCE_4_FEATURES_KHR                             :: 1000413000;
    PHYSICAL_DEVICE_MAINTENANCE_4_PROPERTIES_KHR                           :: 1000413001;
    DEVICE_BUFFER_MEMORY_REQUIREMENTS_KHR                                  :: 1000413002;
    DEVICE_IMAGE_MEMORY_REQUIREMENTS_KHR                                   :: 1000413003;
    PHYSICAL_DEVICE_SHADER_SUBGROUP_ROTATE_FEATURES_KHR                    :: 1000416000;
    PHYSICAL_DEVICE_DEPTH_CLAMP_ZERO_ONE_FEATURES_EXT                      :: 1000421000;
    PHYSICAL_DEVICE_FRAGMENT_DENSITY_MAP_OFFSET_FEATURES_QCOM              :: 1000425000;
    PHYSICAL_DEVICE_FRAGMENT_DENSITY_MAP_OFFSET_PROPERTIES_QCOM            :: 1000425001;
    SUBPASS_FRAGMENT_DENSITY_MAP_OFFSET_END_INFO_QCOM                      :: 1000425002;
    PHYSICAL_DEVICE_COPY_MEMORY_INDIRECT_PROPERTIES_NV                     :: 1000426001;
    PHYSICAL_DEVICE_MEMORY_DECOMPRESSION_FEATURES_NV                       :: 1000427000;
    PHYSICAL_DEVICE_MEMORY_DECOMPRESSION_PROPERTIES_NV                     :: 1000427001;
    PHYSICAL_DEVICE_PIPELINE_PROTECTED_ACCESS_FEATURES_EXT                 :: 1000466000;
    PHYSICAL_DEVICE_MAINTENANCE_5_FEATURES_KHR                             :: 1000470000;
    PHYSICAL_DEVICE_MAINTENANCE_5_PROPERTIES_KHR                           :: 1000470001;
    RENDERING_AREA_INFO_KHR                                                :: 1000470003;
    DEVICE_IMAGE_SUBRESOURCE_INFO_KHR                                      :: 1000470004;
    SUBRESOURCE_LAYOUT_2_KHR                                               :: 1000338002;
    IMAGE_SUBRESOURCE_2_KHR                                                :: 1000338003;
    PIPELINE_CREATE_FLAGS_2_CREATE_INFO_KHR                                :: 1000470005;
    BUFFER_USAGE_FLAGS_2_CREATE_INFO_KHR                                   :: 1000470006;
    SHADER_REQUIRED_SUBGROUP_SIZE_CREATE_INFO_EXT                          :: 1000225001;
    PHYSICAL_DEVICE_VERTEX_ATTRIBUTE_DIVISOR_PROPERTIES_KHR                :: 1000525000;
    PIPELINE_VERTEX_INPUT_DIVISOR_STATE_CREATE_INFO_KHR                    :: 1000190001;
    PHYSICAL_DEVICE_VERTEX_ATTRIBUTE_DIVISOR_FEATURES_KHR                  :: 1000190002;
    PHYSICAL_DEVICE_SHADER_FLOAT_CONTROLS_2_FEATURES_KHR                   :: 1000528000;
    PHYSICAL_DEVICE_INDEX_TYPE_UINT8_FEATURES_KHR                          :: 1000265000;
    PHYSICAL_DEVICE_LINE_RASTERIZATION_FEATURES_KHR                        :: 1000259000;
    PIPELINE_RASTERIZATION_LINE_STATE_CREATE_INFO_KHR                      :: 1000259001;
    PHYSICAL_DEVICE_LINE_RASTERIZATION_PROPERTIES_KHR                      :: 1000259002;
    PHYSICAL_DEVICE_SHADER_EXPECT_ASSUME_FEATURES_KHR                      :: 1000544000;
    PHYSICAL_DEVICE_MAINTENANCE_6_FEATURES_KHR                             :: 1000545000;
    PHYSICAL_DEVICE_MAINTENANCE_6_PROPERTIES_KHR                           :: 1000545001;
    BIND_MEMORY_STATUS_KHR                                                 :: 1000545002;
    BIND_DESCRIPTOR_SETS_INFO_KHR                                          :: 1000545003;
    PUSH_CONSTANTS_INFO_KHR                                                :: 1000545004;
    PUSH_DESCRIPTOR_SET_INFO_KHR                                           :: 1000545005;
    PUSH_DESCRIPTOR_SET_WITH_TEMPLATE_INFO_KHR                             :: 1000545006;
    RENDERING_END_INFO_EXT                                                 :: 1000619003;
    MAX_ENUM                                                               :: 2147483647;
}

Object_Type :: enum u32 {
    UNKNOWN                         :: 0;
    INSTANCE                        :: 1;
    PHYSICAL_DEVICE                 :: 2;
    DEVICE                          :: 3;
    QUEUE                           :: 4;
    SEMAPHORE                       :: 5;
    COMMAND_BUFFER                  :: 6;
    FENCE                           :: 7;
    DEVICE_MEMORY                   :: 8;
    BUFFER                          :: 9;
    IMAGE                           :: 10;
    EVENT                           :: 11;
    QUERY_POOL                      :: 12;
    BUFFER_VIEW                     :: 13;
    IMAGE_VIEW                      :: 14;
    SHADER_MODULE                   :: 15;
    PIPELINE_CACHE                  :: 16;
    PIPELINE_LAYOUT                 :: 17;
    RENDER_PASS                     :: 18;
    PIPELINE                        :: 19;
    DESCRIPTOR_SET_LAYOUT           :: 20;
    SAMPLER                         :: 21;
    DESCRIPTOR_POOL                 :: 22;
    DESCRIPTOR_SET                  :: 23;
    FRAMEBUFFER                     :: 24;
    COMMAND_POOL                    :: 25;
    DESCRIPTOR_UPDATE_TEMPLATE      :: 1000085000;
    SAMPLER_YCBCR_CONVERSION        :: 1000156000;
    PRIVATE_DATA_SLOT               :: 1000295000;
    SURFACE_KHR                     :: 1000000000;
    SWAPCHAIN_KHR                   :: 1000001000;
    DISPLAY_KHR                     :: 1000002000;
    DISPLAY_MODE_KHR                :: 1000002001;
    DEBUG_REPORT_CALLBACK_EXT       :: 1000011000;
    VIDEO_SESSION_KHR               :: 1000023000;
    VIDEO_SESSION_PARAMETERS_KHR    :: 1000023001;
    CU_MODULE_NVX                   :: 1000029000;
    CU_FUNCTION_NVX                 :: 1000029001;
    DEBUG_UTILS_MESSENGER_EXT       :: 1000128000;
    GPA_SESSION_AMD                 :: 1000133000;
    ACCELERATION_STRUCTURE_KHR      :: 1000150000;
    VALIDATION_CACHE_EXT            :: 1000160000;
    ACCELERATION_STRUCTURE_NV       :: 1000165000;
    PERFORMANCE_CONFIGURATION_INTEL :: 1000210000;
    DEFERRED_OPERATION_KHR          :: 1000268000;
    INDIRECT_COMMANDS_LAYOUT_NV     :: 1000277000;
    CUDA_MODULE_NV                  :: 1000307000;
    CUDA_FUNCTION_NV                :: 1000307001;
    BUFFER_COLLECTION_FUCHSIA       :: 1000366000;
    MICROMAP_EXT                    :: 1000396000;
    TENSOR_ARM                      :: 1000460000;
    TENSOR_VIEW_ARM                 :: 1000460001;
    OPTICAL_FLOW_SESSION_NV         :: 1000464000;
    SHADER_EXT                      :: 1000482000;
    PIPELINE_BINARY_KHR             :: 1000483000;
    DATA_GRAPH_PIPELINE_SESSION_ARM :: 1000507000;
    EXTERNAL_COMPUTE_QUEUE_NV       :: 1000556000;
    INDIRECT_COMMANDS_LAYOUT_EXT    :: 1000572000;
    INDIRECT_EXECUTION_SET_EXT      :: 1000572001;
    SHADER_INSTRUMENTATION_ARM      :: 1000607000;
    DESCRIPTOR_UPDATE_TEMPLATE_KHR  :: DESCRIPTOR_UPDATE_TEMPLATE;
    SAMPLER_YCBCR_CONVERSION_KHR    :: SAMPLER_YCBCR_CONVERSION;
    PRIVATE_DATA_SLOT_EXT           :: PRIVATE_DATA_SLOT;
}

Result :: enum s32 {
    SUCCESS                                            :: 0;
    NOT_READY                                          :: 1;
    TIMEOUT                                            :: 2;
    EVENT_SET                                          :: 3;
    EVENT_RESET                                        :: 4;
    INCOMPLETE                                         :: 5;
    ERROR_OUT_OF_HOST_MEMORY                           :: -1;
    ERROR_OUT_OF_DEVICE_MEMORY                         :: -2;
    ERROR_INITIALIZATION_FAILED                        :: -3;
    ERROR_DEVICE_LOST                                  :: -4;
    ERROR_MEMORY_MAP_FAILED                            :: -5;
    ERROR_LAYER_NOT_PRESENT                            :: -6;
    ERROR_EXTENSION_NOT_PRESENT                        :: -7;
    ERROR_FEATURE_NOT_PRESENT                          :: -8;
    ERROR_INCOMPATIBLE_DRIVER                          :: -9;
    ERROR_TOO_MANY_OBJECTS                             :: -10;
    ERROR_FORMAT_NOT_SUPPORTED                         :: -11;
    ERROR_FRAGMENTED_POOL                              :: -12;
    ERROR_UNKNOWN                                      :: -13;
    ERROR_VALIDATION_FAILED                            :: -1000011001;
    ERROR_OUT_OF_POOL_MEMORY                           :: -1000069000;
    ERROR_INVALID_EXTERNAL_HANDLE                      :: -1000072003;
    ERROR_INVALID_OPAQUE_CAPTURE_ADDRESS               :: -1000257000;
    ERROR_FRAGMENTATION                                :: -1000161000;
    PIPELINE_COMPILE_REQUIRED                          :: 1000297000;
    ERROR_NOT_PERMITTED                                :: -1000174001;
    ERROR_SURFACE_LOST_KHR                             :: -1000000000;
    ERROR_NATIVE_WINDOW_IN_USE_KHR                     :: -1000000001;
    SUBOPTIMAL_KHR                                     :: 1000001003;
    ERROR_OUT_OF_DATE_KHR                              :: -1000001004;
    ERROR_INCOMPATIBLE_DISPLAY_KHR                     :: -1000003001;
    ERROR_INVALID_SHADER_NV                            :: -1000012000;
    ERROR_IMAGE_USAGE_NOT_SUPPORTED_KHR                :: -1000023000;
    ERROR_VIDEO_PICTURE_LAYOUT_NOT_SUPPORTED_KHR       :: -1000023001;
    ERROR_VIDEO_PROFILE_OPERATION_NOT_SUPPORTED_KHR    :: -1000023002;
    ERROR_VIDEO_PROFILE_FORMAT_NOT_SUPPORTED_KHR       :: -1000023003;
    ERROR_VIDEO_PROFILE_CODEC_NOT_SUPPORTED_KHR        :: -1000023004;
    ERROR_VIDEO_STD_VERSION_NOT_SUPPORTED_KHR          :: -1000023005;
    ERROR_INVALID_DRM_FORMAT_MODIFIER_PLANE_LAYOUT_EXT :: -1000158000;
    ERROR_PRESENT_TIMING_QUEUE_FULL_EXT                :: -1000208000;
    ERROR_FULL_SCREEN_EXCLUSIVE_MODE_LOST_EXT          :: -1000255000;
    THREAD_IDLE_KHR                                    :: 1000268000;
    THREAD_DONE_KHR                                    :: 1000268001;
    OPERATION_DEFERRED_KHR                             :: 1000268002;
    OPERATION_NOT_DEFERRED_KHR                         :: 1000268003;
    ERROR_INVALID_VIDEO_STD_PARAMETERS_KHR             :: -1000299000;
    ERROR_COMPRESSION_EXHAUSTED_EXT                    :: -1000338000;
    INCOMPATIBLE_SHADER_BINARY_EXT                     :: 1000482000;
    PIPELINE_BINARY_MISSING_KHR                        :: 1000483000;
    ERROR_NOT_ENOUGH_SPACE_KHR                         :: -1000483000;
    ERROR_VALIDATION_FAILED_EXT                        :: -1000011001;
    ERROR_OUT_OF_POOL_MEMORY_KHR                       :: -1000069000;
    ERROR_INVALID_EXTERNAL_HANDLE_KHR                  :: -1000072003;
    ERROR_FRAGMENTATION_EXT                            :: -1000161000;
    ERROR_NOT_PERMITTED_EXT                            :: -1000174001;
    ERROR_NOT_PERMITTED_KHR                            :: -1000174001;
    ERROR_INVALID_DEVICE_ADDRESS_EXT                   :: -1000257000;
    ERROR_INVALID_OPAQUE_CAPTURE_ADDRESS_KHR           :: -1000257000;
    PIPELINE_COMPILE_REQUIRED_EXT                      :: 1000297000;
    ERROR_PIPELINE_COMPILE_REQUIRED_EXT                :: 1000297000;

    ERROR_INCOMPATIBLE_SHADER_BINARY_EXT :: 1000482000;
    RESULT_MAX_ENUM                      :: 2147483647;
}

System_Allocation_Scope :: enum u32 {
    COMMAND  :: 0;
    OBJECT   :: 1;
    CACHE    :: 2;
    DEVICE   :: 3;
    INSTANCE :: 4;
    MAX_ENUM :: 2147483647;
}

Internal_Allocation_Type :: enum u32 {
    EXECUTABLE :: 0;
    MAX_ENUM   :: 2147483647;
}

Physical_Device_Type :: enum u32 {
    OTHER          :: 0;
    INTEGRATED_GPU :: 1;
    DISCRETE_GPU   :: 2;
    VIRTUAL_GPU    :: 3;
    CPU            :: 4;
    MAX_ENUM       :: 2147483647;
}

Sharing_Mode :: enum u32 {
    EXCLUSIVE  :: 0;
    CONCURRENT :: 1;
    MAX_ENUM   :: 2147483647;
}

Present_Mode_Khr :: enum u32 {
    IMMEDIATE_KHR                 :: 0;
    MAILBOX_KHR                   :: 1;
    FIFO_KHR                      :: 2;
    FIFO_RELAXED_KHR              :: 3;
    SHARED_DEMAND_REFRESH_KHR     :: 1000111000;
    SHARED_CONTINUOUS_REFRESH_KHR :: 1000111001;
    FIFO_LATEST_READY_KHR         :: 1000361000;
    FIFO_LATEST_READY_EXT         :: 1000361000;
    MAX_ENUM_KHR                  :: 2147483647;
}

Format :: enum u32 {
    UNDEFINED                                      :: 0;
    R4G4_UNORM_PACK8                               :: 1;
    R4G4B4A4_UNORM_PACK16                          :: 2;
    B4G4R4A4_UNORM_PACK16                          :: 3;
    R5G6B5_UNORM_PACK16                            :: 4;
    B5G6R5_UNORM_PACK16                            :: 5;
    R5G5B5A1_UNORM_PACK16                          :: 6;
    B5G5R5A1_UNORM_PACK16                          :: 7;
    A1R5G5B5_UNORM_PACK16                          :: 8;
    R8_UNORM                                       :: 9;
    R8_SNORM                                       :: 10;
    R8_USCALED                                     :: 11;
    R8_SSCALED                                     :: 12;
    R8_UINT                                        :: 13;
    R8_SINT                                        :: 14;
    R8_SRGB                                        :: 15;
    R8G8_UNORM                                     :: 16;
    R8G8_SNORM                                     :: 17;
    R8G8_USCALED                                   :: 18;
    R8G8_SSCALED                                   :: 19;
    R8G8_UINT                                      :: 20;
    R8G8_SINT                                      :: 21;
    R8G8_SRGB                                      :: 22;
    R8G8B8_UNORM                                   :: 23;
    R8G8B8_SNORM                                   :: 24;
    R8G8B8_USCALED                                 :: 25;
    R8G8B8_SSCALED                                 :: 26;
    R8G8B8_UINT                                    :: 27;
    R8G8B8_SINT                                    :: 28;
    R8G8B8_SRGB                                    :: 29;
    B8G8R8_UNORM                                   :: 30;
    B8G8R8_SNORM                                   :: 31;
    B8G8R8_USCALED                                 :: 32;
    B8G8R8_SSCALED                                 :: 33;
    B8G8R8_UINT                                    :: 34;
    B8G8R8_SINT                                    :: 35;
    B8G8R8_SRGB                                    :: 36;
    R8G8B8A8_UNORM                                 :: 37;
    R8G8B8A8_SNORM                                 :: 38;
    R8G8B8A8_USCALED                               :: 39;
    R8G8B8A8_SSCALED                               :: 40;
    R8G8B8A8_UINT                                  :: 41;
    R8G8B8A8_SINT                                  :: 42;
    R8G8B8A8_SRGB                                  :: 43;
    B8G8R8A8_UNORM                                 :: 44;
    B8G8R8A8_SNORM                                 :: 45;
    B8G8R8A8_USCALED                               :: 46;
    B8G8R8A8_SSCALED                               :: 47;
    B8G8R8A8_UINT                                  :: 48;
    B8G8R8A8_SINT                                  :: 49;
    B8G8R8A8_SRGB                                  :: 50;
    A8B8G8R8_UNORM_PACK32                          :: 51;
    A8B8G8R8_SNORM_PACK32                          :: 52;
    A8B8G8R8_USCALED_PACK32                        :: 53;
    A8B8G8R8_SSCALED_PACK32                        :: 54;
    A8B8G8R8_UINT_PACK32                           :: 55;
    A8B8G8R8_SINT_PACK32                           :: 56;
    A8B8G8R8_SRGB_PACK32                           :: 57;
    A2R10G10B10_UNORM_PACK32                       :: 58;
    A2R10G10B10_SNORM_PACK32                       :: 59;
    A2R10G10B10_USCALED_PACK32                     :: 60;
    A2R10G10B10_SSCALED_PACK32                     :: 61;
    A2R10G10B10_UINT_PACK32                        :: 62;
    A2R10G10B10_SINT_PACK32                        :: 63;
    A2B10G10R10_UNORM_PACK32                       :: 64;
    A2B10G10R10_SNORM_PACK32                       :: 65;
    A2B10G10R10_USCALED_PACK32                     :: 66;
    A2B10G10R10_SSCALED_PACK32                     :: 67;
    A2B10G10R10_UINT_PACK32                        :: 68;
    A2B10G10R10_SINT_PACK32                        :: 69;
    R16_UNORM                                      :: 70;
    R16_SNORM                                      :: 71;
    R16_USCALED                                    :: 72;
    R16_SSCALED                                    :: 73;
    R16_UINT                                       :: 74;
    R16_SINT                                       :: 75;
    R16_SFLOAT                                     :: 76;
    R16G16_UNORM                                   :: 77;
    R16G16_SNORM                                   :: 78;
    R16G16_USCALED                                 :: 79;
    R16G16_SSCALED                                 :: 80;
    R16G16_UINT                                    :: 81;
    R16G16_SINT                                    :: 82;
    R16G16_SFLOAT                                  :: 83;
    R16G16B16_UNORM                                :: 84;
    R16G16B16_SNORM                                :: 85;
    R16G16B16_USCALED                              :: 86;
    R16G16B16_SSCALED                              :: 87;
    R16G16B16_UINT                                 :: 88;
    R16G16B16_SINT                                 :: 89;
    R16G16B16_SFLOAT                               :: 90;
    R16G16B16A16_UNORM                             :: 91;
    R16G16B16A16_SNORM                             :: 92;
    R16G16B16A16_USCALED                           :: 93;
    R16G16B16A16_SSCALED                           :: 94;
    R16G16B16A16_UINT                              :: 95;
    R16G16B16A16_SINT                              :: 96;
    R16G16B16A16_SFLOAT                            :: 97;
    R32_UINT                                       :: 98;
    R32_SINT                                       :: 99;
    R32_SFLOAT                                     :: 100;
    R32G32_UINT                                    :: 101;
    R32G32_SINT                                    :: 102;
    R32G32_SFLOAT                                  :: 103;
    R32G32B32_UINT                                 :: 104;
    R32G32B32_SINT                                 :: 105;
    R32G32B32_SFLOAT                               :: 106;
    R32G32B32A32_UINT                              :: 107;
    R32G32B32A32_SINT                              :: 108;
    R32G32B32A32_SFLOAT                            :: 109;
    R64_UINT                                       :: 110;
    R64_SINT                                       :: 111;
    R64_SFLOAT                                     :: 112;
    R64G64_UINT                                    :: 113;
    R64G64_SINT                                    :: 114;
    R64G64_SFLOAT                                  :: 115;
    R64G64B64_UINT                                 :: 116;
    R64G64B64_SINT                                 :: 117;
    R64G64B64_SFLOAT                               :: 118;
    R64G64B64A64_UINT                              :: 119;
    R64G64B64A64_SINT                              :: 120;
    R64G64B64A64_SFLOAT                            :: 121;
    B10G11R11_UFLOAT_PACK32                        :: 122;
    E5B9G9R9_UFLOAT_PACK32                         :: 123;
    D16_UNORM                                      :: 124;
    X8_D24_UNORM_PACK32                            :: 125;
    D32_SFLOAT                                     :: 126;
    S8_UINT                                        :: 127;
    D16_UNORM_S8_UINT                              :: 128;
    D24_UNORM_S8_UINT                              :: 129;
    D32_SFLOAT_S8_UINT                             :: 130;
    BC1_RGB_UNORM_BLOCK                            :: 131;
    BC1_RGB_SRGB_BLOCK                             :: 132;
    BC1_RGBA_UNORM_BLOCK                           :: 133;
    BC1_RGBA_SRGB_BLOCK                            :: 134;
    BC2_UNORM_BLOCK                                :: 135;
    BC2_SRGB_BLOCK                                 :: 136;
    BC3_UNORM_BLOCK                                :: 137;
    BC3_SRGB_BLOCK                                 :: 138;
    BC4_UNORM_BLOCK                                :: 139;
    BC4_SNORM_BLOCK                                :: 140;
    BC5_UNORM_BLOCK                                :: 141;
    BC5_SNORM_BLOCK                                :: 142;
    BC6H_UFLOAT_BLOCK                              :: 143;
    BC6H_SFLOAT_BLOCK                              :: 144;
    BC7_UNORM_BLOCK                                :: 145;
    BC7_SRGB_BLOCK                                 :: 146;
    ETC2_R8G8B8_UNORM_BLOCK                        :: 147;
    ETC2_R8G8B8_SRGB_BLOCK                         :: 148;
    ETC2_R8G8B8A1_UNORM_BLOCK                      :: 149;
    ETC2_R8G8B8A1_SRGB_BLOCK                       :: 150;
    ETC2_R8G8B8A8_UNORM_BLOCK                      :: 151;
    ETC2_R8G8B8A8_SRGB_BLOCK                       :: 152;
    EAC_R11_UNORM_BLOCK                            :: 153;
    EAC_R11_SNORM_BLOCK                            :: 154;
    EAC_R11G11_UNORM_BLOCK                         :: 155;
    EAC_R11G11_SNORM_BLOCK                         :: 156;
    ASTC_4x4_UNORM_BLOCK                           :: 157;
    ASTC_4x4_SRGB_BLOCK                            :: 158;
    ASTC_5x4_UNORM_BLOCK                           :: 159;
    ASTC_5x4_SRGB_BLOCK                            :: 160;
    ASTC_5x5_UNORM_BLOCK                           :: 161;
    ASTC_5x5_SRGB_BLOCK                            :: 162;
    ASTC_6x5_UNORM_BLOCK                           :: 163;
    ASTC_6x5_SRGB_BLOCK                            :: 164;
    ASTC_6x6_UNORM_BLOCK                           :: 165;
    ASTC_6x6_SRGB_BLOCK                            :: 166;
    ASTC_8x5_UNORM_BLOCK                           :: 167;
    ASTC_8x5_SRGB_BLOCK                            :: 168;
    ASTC_8x6_UNORM_BLOCK                           :: 169;
    ASTC_8x6_SRGB_BLOCK                            :: 170;
    ASTC_8x8_UNORM_BLOCK                           :: 171;
    ASTC_8x8_SRGB_BLOCK                            :: 172;
    ASTC_10x5_UNORM_BLOCK                          :: 173;
    ASTC_10x5_SRGB_BLOCK                           :: 174;
    ASTC_10x6_UNORM_BLOCK                          :: 175;
    ASTC_10x6_SRGB_BLOCK                           :: 176;
    ASTC_10x8_UNORM_BLOCK                          :: 177;
    ASTC_10x8_SRGB_BLOCK                           :: 178;
    ASTC_10x10_UNORM_BLOCK                         :: 179;
    ASTC_10x10_SRGB_BLOCK                          :: 180;
    ASTC_12x10_UNORM_BLOCK                         :: 181;
    ASTC_12x10_SRGB_BLOCK                          :: 182;
    ASTC_12x12_UNORM_BLOCK                         :: 183;
    ASTC_12x12_SRGB_BLOCK                          :: 184;
    G8B8G8R8_422_UNORM                             :: 1000156000;
    B8G8R8G8_422_UNORM                             :: 1000156001;
    G8_B8_R8_3PLANE_420_UNORM                      :: 1000156002;
    G8_B8R8_2PLANE_420_UNORM                       :: 1000156003;
    G8_B8_R8_3PLANE_422_UNORM                      :: 1000156004;
    G8_B8R8_2PLANE_422_UNORM                       :: 1000156005;
    G8_B8_R8_3PLANE_444_UNORM                      :: 1000156006;
    R10X6_UNORM_PACK16                             :: 1000156007;
    R10X6G10X6_UNORM_2PACK16                       :: 1000156008;
    R10X6G10X6B10X6A10X6_UNORM_4PACK16             :: 1000156009;
    G10X6B10X6G10X6R10X6_422_UNORM_4PACK16         :: 1000156010;
    B10X6G10X6R10X6G10X6_422_UNORM_4PACK16         :: 1000156011;
    G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16     :: 1000156012;
    G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16      :: 1000156013;
    G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16     :: 1000156014;
    G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16      :: 1000156015;
    G10X6_B10X6_R10X6_3PLANE_444_UNORM_3PACK16     :: 1000156016;
    R12X4_UNORM_PACK16                             :: 1000156017;
    R12X4G12X4_UNORM_2PACK16                       :: 1000156018;
    R12X4G12X4B12X4A12X4_UNORM_4PACK16             :: 1000156019;
    G12X4B12X4G12X4R12X4_422_UNORM_4PACK16         :: 1000156020;
    B12X4G12X4R12X4G12X4_422_UNORM_4PACK16         :: 1000156021;
    G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16     :: 1000156022;
    G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16      :: 1000156023;
    G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16     :: 1000156024;
    G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16      :: 1000156025;
    G12X4_B12X4_R12X4_3PLANE_444_UNORM_3PACK16     :: 1000156026;
    G16B16G16R16_422_UNORM                         :: 1000156027;
    B16G16R16G16_422_UNORM                         :: 1000156028;
    G16_B16_R16_3PLANE_420_UNORM                   :: 1000156029;
    G16_B16R16_2PLANE_420_UNORM                    :: 1000156030;
    G16_B16_R16_3PLANE_422_UNORM                   :: 1000156031;
    G16_B16R16_2PLANE_422_UNORM                    :: 1000156032;
    G16_B16_R16_3PLANE_444_UNORM                   :: 1000156033;
    G8_B8R8_2PLANE_444_UNORM                       :: 1000330000;
    G10X6_B10X6R10X6_2PLANE_444_UNORM_3PACK16      :: 1000330001;
    G12X4_B12X4R12X4_2PLANE_444_UNORM_3PACK16      :: 1000330002;
    G16_B16R16_2PLANE_444_UNORM                    :: 1000330003;
    A4R4G4B4_UNORM_PACK16                          :: 1000340000;
    A4B4G4R4_UNORM_PACK16                          :: 1000340001;
    ASTC_4x4_SFLOAT_BLOCK                          :: 1000066000;
    ASTC_5x4_SFLOAT_BLOCK                          :: 1000066001;
    ASTC_5x5_SFLOAT_BLOCK                          :: 1000066002;
    ASTC_6x5_SFLOAT_BLOCK                          :: 1000066003;
    ASTC_6x6_SFLOAT_BLOCK                          :: 1000066004;
    ASTC_8x5_SFLOAT_BLOCK                          :: 1000066005;
    ASTC_8x6_SFLOAT_BLOCK                          :: 1000066006;
    ASTC_8x8_SFLOAT_BLOCK                          :: 1000066007;
    ASTC_10x5_SFLOAT_BLOCK                         :: 1000066008;
    ASTC_10x6_SFLOAT_BLOCK                         :: 1000066009;
    ASTC_10x8_SFLOAT_BLOCK                         :: 1000066010;
    ASTC_10x10_SFLOAT_BLOCK                        :: 1000066011;
    ASTC_12x10_SFLOAT_BLOCK                        :: 1000066012;
    ASTC_12x12_SFLOAT_BLOCK                        :: 1000066013;
    A1B5G5R5_UNORM_PACK16                          :: 1000470000;
    A8_UNORM                                       :: 1000470001;
    PVRTC1_2BPP_UNORM_BLOCK_IMG                    :: 1000054000;
    PVRTC1_4BPP_UNORM_BLOCK_IMG                    :: 1000054001;
    PVRTC2_2BPP_UNORM_BLOCK_IMG                    :: 1000054002;
    PVRTC2_4BPP_UNORM_BLOCK_IMG                    :: 1000054003;
    PVRTC1_2BPP_SRGB_BLOCK_IMG                     :: 1000054004;
    PVRTC1_4BPP_SRGB_BLOCK_IMG                     :: 1000054005;
    PVRTC2_2BPP_SRGB_BLOCK_IMG                     :: 1000054006;
    PVRTC2_4BPP_SRGB_BLOCK_IMG                     :: 1000054007;
    ASTC_3x3x3_UNORM_BLOCK_EXT                     :: 1000288000;
    ASTC_3x3x3_SRGB_BLOCK_EXT                      :: 1000288001;
    ASTC_3x3x3_SFLOAT_BLOCK_EXT                    :: 1000288002;
    ASTC_4x3x3_UNORM_BLOCK_EXT                     :: 1000288003;
    ASTC_4x3x3_SRGB_BLOCK_EXT                      :: 1000288004;
    ASTC_4x3x3_SFLOAT_BLOCK_EXT                    :: 1000288005;
    ASTC_4x4x3_UNORM_BLOCK_EXT                     :: 1000288006;
    ASTC_4x4x3_SRGB_BLOCK_EXT                      :: 1000288007;
    ASTC_4x4x3_SFLOAT_BLOCK_EXT                    :: 1000288008;
    ASTC_4x4x4_UNORM_BLOCK_EXT                     :: 1000288009;
    ASTC_4x4x4_SRGB_BLOCK_EXT                      :: 1000288010;
    ASTC_4x4x4_SFLOAT_BLOCK_EXT                    :: 1000288011;
    ASTC_5x4x4_UNORM_BLOCK_EXT                     :: 1000288012;
    ASTC_5x4x4_SRGB_BLOCK_EXT                      :: 1000288013;
    ASTC_5x4x4_SFLOAT_BLOCK_EXT                    :: 1000288014;
    ASTC_5x5x4_UNORM_BLOCK_EXT                     :: 1000288015;
    ASTC_5x5x4_SRGB_BLOCK_EXT                      :: 1000288016;
    ASTC_5x5x4_SFLOAT_BLOCK_EXT                    :: 1000288017;
    ASTC_5x5x5_UNORM_BLOCK_EXT                     :: 1000288018;
    ASTC_5x5x5_SRGB_BLOCK_EXT                      :: 1000288019;
    ASTC_5x5x5_SFLOAT_BLOCK_EXT                    :: 1000288020;
    ASTC_6x5x5_UNORM_BLOCK_EXT                     :: 1000288021;
    ASTC_6x5x5_SRGB_BLOCK_EXT                      :: 1000288022;
    ASTC_6x5x5_SFLOAT_BLOCK_EXT                    :: 1000288023;
    ASTC_6x6x5_UNORM_BLOCK_EXT                     :: 1000288024;
    ASTC_6x6x5_SRGB_BLOCK_EXT                      :: 1000288025;
    ASTC_6x6x5_SFLOAT_BLOCK_EXT                    :: 1000288026;
    ASTC_6x6x6_UNORM_BLOCK_EXT                     :: 1000288027;
    ASTC_6x6x6_SRGB_BLOCK_EXT                      :: 1000288028;
    ASTC_6x6x6_SFLOAT_BLOCK_EXT                    :: 1000288029;
    R8_BOOL_ARM                                    :: 1000460000;
    R16_SFLOAT_FPENCODING_BFLOAT16_ARM             :: 1000460001;
    R8_SFLOAT_FPENCODING_FLOAT8E4M3_ARM            :: 1000460002;
    R8_SFLOAT_FPENCODING_FLOAT8E5M2_ARM            :: 1000460003;
    R16G16_SFIXED5_NV                              :: 1000464000;
    R10X6_UINT_PACK16_ARM                          :: 1000609000;
    R10X6G10X6_UINT_2PACK16_ARM                    :: 1000609001;
    R10X6G10X6B10X6A10X6_UINT_4PACK16_ARM          :: 1000609002;
    R12X4_UINT_PACK16_ARM                          :: 1000609003;
    R12X4G12X4_UINT_2PACK16_ARM                    :: 1000609004;
    R12X4G12X4B12X4A12X4_UINT_4PACK16_ARM          :: 1000609005;
    R14X2_UINT_PACK16_ARM                          :: 1000609006;
    R14X2G14X2_UINT_2PACK16_ARM                    :: 1000609007;
    R14X2G14X2B14X2A14X2_UINT_4PACK16_ARM          :: 1000609008;
    R14X2_UNORM_PACK16_ARM                         :: 1000609009;
    R14X2G14X2_UNORM_2PACK16_ARM                   :: 1000609010;
    R14X2G14X2B14X2A14X2_UNORM_4PACK16_ARM         :: 1000609011;
    G14X2_B14X2R14X2_2PLANE_420_UNORM_3PACK16_ARM  :: 1000609012;
    G14X2_B14X2R14X2_2PLANE_422_UNORM_3PACK16_ARM  :: 1000609013;
    ASTC_4x4_SFLOAT_BLOCK_EXT                      :: 1000066000;
    ASTC_5x4_SFLOAT_BLOCK_EXT                      :: 1000066001;
    ASTC_5x5_SFLOAT_BLOCK_EXT                      :: 1000066002;
    ASTC_6x5_SFLOAT_BLOCK_EXT                      :: 1000066003;
    ASTC_6x6_SFLOAT_BLOCK_EXT                      :: 1000066004;
    ASTC_8x5_SFLOAT_BLOCK_EXT                      :: 1000066005;
    ASTC_8x6_SFLOAT_BLOCK_EXT                      :: 1000066006;
    ASTC_8x8_SFLOAT_BLOCK_EXT                      :: 1000066007;
    ASTC_10x5_SFLOAT_BLOCK_EXT                     :: 1000066008;
    ASTC_10x6_SFLOAT_BLOCK_EXT                     :: 1000066009;
    ASTC_10x8_SFLOAT_BLOCK_EXT                     :: 1000066010;
    ASTC_10x10_SFLOAT_BLOCK_EXT                    :: 1000066011;
    ASTC_12x10_SFLOAT_BLOCK_EXT                    :: 1000066012;
    ASTC_12x12_SFLOAT_BLOCK_EXT                    :: 1000066013;
    G8B8G8R8_422_UNORM_KHR                         :: 1000156000;
    B8G8R8G8_422_UNORM_KHR                         :: 1000156001;
    G8_B8_R8_3PLANE_420_UNORM_KHR                  :: 1000156002;
    G8_B8R8_2PLANE_420_UNORM_KHR                   :: 1000156003;
    G8_B8_R8_3PLANE_422_UNORM_KHR                  :: 1000156004;
    G8_B8R8_2PLANE_422_UNORM_KHR                   :: 1000156005;
    G8_B8_R8_3PLANE_444_UNORM_KHR                  :: 1000156006;
    R10X6_UNORM_PACK16_KHR                         :: 1000156007;
    R10X6G10X6_UNORM_2PACK16_KHR                   :: 1000156008;
    R10X6G10X6B10X6A10X6_UNORM_4PACK16_KHR         :: 1000156009;
    G10X6B10X6G10X6R10X6_422_UNORM_4PACK16_KHR     :: 1000156010;
    B10X6G10X6R10X6G10X6_422_UNORM_4PACK16_KHR     :: 1000156011;
    G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16_KHR :: 1000156012;
    G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16_KHR  :: 1000156013;
    G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16_KHR :: 1000156014;
    G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16_KHR  :: 1000156015;
    G10X6_B10X6_R10X6_3PLANE_444_UNORM_3PACK16_KHR :: 1000156016;
    R12X4_UNORM_PACK16_KHR                         :: 1000156017;
    R12X4G12X4_UNORM_2PACK16_KHR                   :: 1000156018;
    R12X4G12X4B12X4A12X4_UNORM_4PACK16_KHR         :: 1000156019;
    G12X4B12X4G12X4R12X4_422_UNORM_4PACK16_KHR     :: 1000156020;
    B12X4G12X4R12X4G12X4_422_UNORM_4PACK16_KHR     :: 1000156021;
    G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16_KHR :: 1000156022;
    G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16_KHR  :: 1000156023;
    G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16_KHR :: 1000156024;
    G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16_KHR  :: 1000156025;
    G12X4_B12X4_R12X4_3PLANE_444_UNORM_3PACK16_KHR :: 1000156026;
    G16B16G16R16_422_UNORM_KHR                     :: 1000156027;
    B16G16R16G16_422_UNORM_KHR                     :: 1000156028;
    G16_B16_R16_3PLANE_420_UNORM_KHR               :: 1000156029;
    G16_B16R16_2PLANE_420_UNORM_KHR                :: 1000156030;
    G16_B16_R16_3PLANE_422_UNORM_KHR               :: 1000156031;
    G16_B16R16_2PLANE_422_UNORM_KHR                :: 1000156032;
    G16_B16_R16_3PLANE_444_UNORM_KHR               :: 1000156033;
    G8_B8R8_2PLANE_444_UNORM_EXT                   :: 1000330000;
    G10X6_B10X6R10X6_2PLANE_444_UNORM_3PACK16_EXT  :: 1000330001;
    G12X4_B12X4R12X4_2PLANE_444_UNORM_3PACK16_EXT  :: 1000330002;
    G16_B16R16_2PLANE_444_UNORM_EXT                :: 1000330003;
    A4R4G4B4_UNORM_PACK16_EXT                      :: 1000340000;
    A4B4G4R4_UNORM_PACK16_EXT                      :: 1000340001;

    R16G16_S10_5_NV                                :: 1000464000;
    A1B5G5R5_UNORM_PACK16_KHR                      :: 1000470000;
    A8_UNORM_KHR                                   :: 1000470001;
    MAX_ENUM                                       :: 2147483647;
}

Color_Space_Khr :: enum u32 {
    SRGB_NONLINEAR_KHR            :: 0;
    DISPLAY_P3_NONLINEAR_EXT      :: 1000104001;
    EXTENDED_SRGB_LINEAR_EXT      :: 1000104002;
    DISPLAY_P3_LINEAR_EXT         :: 1000104003;
    DCI_P3_NONLINEAR_EXT          :: 1000104004;
    BT709_LINEAR_EXT              :: 1000104005;
    BT709_NONLINEAR_EXT           :: 1000104006;
    BT2020_LINEAR_EXT             :: 1000104007;
    HDR10_ST2084_EXT              :: 1000104008;

    DOLBYVISION_EXT               :: 1000104009;
    HDR10_HLG_EXT                 :: 1000104010;
    ADOBERGB_LINEAR_EXT           :: 1000104011;
    ADOBERGB_NONLINEAR_EXT        :: 1000104012;
    PASS_THROUGH_EXT              :: 1000104013;
    EXTENDED_SRGB_NONLINEAR_EXT   :: 1000104014;
    DISPLAY_NATIVE_AMD            :: 1000213000;

    COLORSPACE_SRGB_NONLINEAR_KHR :: 0;

    DCI_P3_LINEAR_EXT             :: 1000104003;
    MAX_ENUM_KHR                  :: 2147483647;
}

Image_View_Type :: enum u32 {
    _1D        :: 0;
    _2D        :: 1;
    _3D        :: 2;
    CUBE       :: 3;
    _1D_ARRAY  :: 4;
    _2D_ARRAY  :: 5;
    CUBE_ARRAY :: 6;
    MAX_ENUM   :: 2147483647;
}

Image_Type :: enum u32 {
    _1D      :: 0;
    _2D      :: 1;
    _3D      :: 2;
    MAX_ENUM :: 2147483647;
}

Image_Tiling :: enum u32 {
    OPTIMAL                 :: 0;
    LINEAR                  :: 1;
    DRM_FORMAT_MODIFIER_EXT :: 1000158000;
    MAX_ENUM                :: 2147483647;
}

Image_Layout :: enum u32 {
    UNDEFINED                                      :: 0;
    GENERAL                                        :: 1;
    COLOR_ATTACHMENT_OPTIMAL                       :: 2;
    DEPTH_STENCIL_ATTACHMENT_OPTIMAL               :: 3;
    DEPTH_STENCIL_READ_ONLY_OPTIMAL                :: 4;
    SHADER_READ_ONLY_OPTIMAL                       :: 5;
    TRANSFER_SRC_OPTIMAL                           :: 6;
    TRANSFER_DST_OPTIMAL                           :: 7;
    PREINITIALIZED                                 :: 8;
    DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL     :: 1000117000;
    DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL     :: 1000117001;
    DEPTH_ATTACHMENT_OPTIMAL                       :: 1000241000;
    DEPTH_READ_ONLY_OPTIMAL                        :: 1000241001;
    STENCIL_ATTACHMENT_OPTIMAL                     :: 1000241002;
    STENCIL_READ_ONLY_OPTIMAL                      :: 1000241003;
    READ_ONLY_OPTIMAL                              :: 1000314000;
    ATTACHMENT_OPTIMAL                             :: 1000314001;
    RENDERING_LOCAL_READ                           :: 1000232000;
    PRESENT_SRC_KHR                                :: 1000001002;
    VIDEO_DECODE_DST_KHR                           :: 1000024000;
    VIDEO_DECODE_SRC_KHR                           :: 1000024001;
    VIDEO_DECODE_DPB_KHR                           :: 1000024002;
    SHARED_PRESENT_KHR                             :: 1000111000;
    FRAGMENT_DENSITY_MAP_OPTIMAL_EXT               :: 1000218000;
    FRAGMENT_SHADING_RATE_ATTACHMENT_OPTIMAL_KHR   :: 1000164003;
    VIDEO_ENCODE_DST_KHR                           :: 1000299000;
    VIDEO_ENCODE_SRC_KHR                           :: 1000299001;
    VIDEO_ENCODE_DPB_KHR                           :: 1000299002;
    ATTACHMENT_FEEDBACK_LOOP_OPTIMAL_EXT           :: 1000339000;
    TENSOR_ALIASING_ARM                            :: 1000460000;
    VIDEO_ENCODE_QUANTIZATION_MAP_KHR              :: 1000553000;
    ZERO_INITIALIZED_EXT                           :: 1000620000;
    DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL_KHR :: 1000117000;
    DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL_KHR :: 1000117001;
    SHADING_RATE_OPTIMAL_NV                        :: 1000164003;
    RENDERING_LOCAL_READ_KHR                       :: 1000232000;
    DEPTH_ATTACHMENT_OPTIMAL_KHR                   :: 1000241000;
    DEPTH_READ_ONLY_OPTIMAL_KHR                    :: 1000241001;
    STENCIL_ATTACHMENT_OPTIMAL_KHR                 :: 1000241002;
    STENCIL_READ_ONLY_OPTIMAL_KHR                  :: 1000241003;
    READ_ONLY_OPTIMAL_KHR                          :: 1000314000;
    ATTACHMENT_OPTIMAL_KHR                         :: 1000314001;
    MAX_ENUM                                       :: 2147483647;
}

Vertex_Input_Rate :: enum u32 {
    VERTEX   :: 0;
    INSTANCE :: 1;
    MAX_ENUM :: 2147483647;
}

Primitive_Topology :: enum u32 {
    POINT_LIST                    :: 0;
    LINE_LIST                     :: 1;
    LINE_STRIP                    :: 2;
    TRIANGLE_LIST                 :: 3;
    TRIANGLE_STRIP                :: 4;
    TRIANGLE_FAN                  :: 5;
    LINE_LIST_WITH_ADJACENCY      :: 6;
    LINE_STRIP_WITH_ADJACENCY     :: 7;
    TRIANGLE_LIST_WITH_ADJACENCY  :: 8;
    TRIANGLE_STRIP_WITH_ADJACENCY :: 9;
    PATCH_LIST                    :: 10;
    MAX_ENUM                      :: 2147483647;
}

Compare_Op :: enum u32 {
    NEVER            :: 0;
    LESS             :: 1;
    EQUAL            :: 2;
    LESS_OR_EQUAL    :: 3;
    GREATER          :: 4;
    NOT_EQUAL        :: 5;
    GREATER_OR_EQUAL :: 6;
    ALWAYS           :: 7;
    MAX_ENUM         :: 2147483647;
}

Polygon_Mode :: enum u32 {
    FILL              :: 0;
    LINE              :: 1;
    POINT             :: 2;
    FILL_RECTANGLE_NV :: 1000153000;
    MAX_ENUM          :: 2147483647;
}

Front_Face :: enum u32 {
    COUNTER_CLOCKWISE :: 0;
    CLOCKWISE         :: 1;
    MAX_ENUM          :: 2147483647;
}

Blend_Op :: enum u32 {
    ADD                    :: 0;
    SUBTRACT               :: 1;
    REVERSE_SUBTRACT       :: 2;
    MIN                    :: 3;
    MAX                    :: 4;
    ZERO_EXT               :: 1000148000;
    SRC_EXT                :: 1000148001;
    DST_EXT                :: 1000148002;
    SRC_OVER_EXT           :: 1000148003;
    DST_OVER_EXT           :: 1000148004;
    SRC_IN_EXT             :: 1000148005;
    DST_IN_EXT             :: 1000148006;
    SRC_OUT_EXT            :: 1000148007;
    DST_OUT_EXT            :: 1000148008;
    SRC_ATOP_EXT           :: 1000148009;
    DST_ATOP_EXT           :: 1000148010;
    XOR_EXT                :: 1000148011;
    MULTIPLY_EXT           :: 1000148012;
    SCREEN_EXT             :: 1000148013;
    OVERLAY_EXT            :: 1000148014;
    DARKEN_EXT             :: 1000148015;
    LIGHTEN_EXT            :: 1000148016;
    COLORDODGE_EXT         :: 1000148017;
    COLORBURN_EXT          :: 1000148018;
    HARDLIGHT_EXT          :: 1000148019;
    SOFTLIGHT_EXT          :: 1000148020;
    DIFFERENCE_EXT         :: 1000148021;
    EXCLUSION_EXT          :: 1000148022;
    INVERT_EXT             :: 1000148023;
    INVERT_RGB_EXT         :: 1000148024;
    LINEARDODGE_EXT        :: 1000148025;
    LINEARBURN_EXT         :: 1000148026;
    VIVIDLIGHT_EXT         :: 1000148027;
    LINEARLIGHT_EXT        :: 1000148028;
    PINLIGHT_EXT           :: 1000148029;
    HARDMIX_EXT            :: 1000148030;
    HSL_HUE_EXT            :: 1000148031;
    HSL_SATURATION_EXT     :: 1000148032;
    HSL_COLOR_EXT          :: 1000148033;
    HSL_LUMINOSITY_EXT     :: 1000148034;
    PLUS_EXT               :: 1000148035;
    PLUS_CLAMPED_EXT       :: 1000148036;
    PLUS_CLAMPED_ALPHA_EXT :: 1000148037;
    PLUS_DARKER_EXT        :: 1000148038;
    MINUS_EXT              :: 1000148039;
    MINUS_CLAMPED_EXT      :: 1000148040;
    CONTRAST_EXT           :: 1000148041;
    INVERT_OVG_EXT         :: 1000148042;
    RED_EXT                :: 1000148043;
    GREEN_EXT              :: 1000148044;
    BLUE_EXT               :: 1000148045;
    MAX_ENUM               :: 2147483647;
}

Blend_Factor :: enum u32 {
    ZERO                     :: 0;
    ONE                      :: 1;
    SRC_COLOR                :: 2;
    ONE_MINUS_SRC_COLOR      :: 3;
    DST_COLOR                :: 4;
    ONE_MINUS_DST_COLOR      :: 5;
    SRC_ALPHA                :: 6;
    ONE_MINUS_SRC_ALPHA      :: 7;
    DST_ALPHA                :: 8;
    ONE_MINUS_DST_ALPHA      :: 9;
    CONSTANT_COLOR           :: 10;
    ONE_MINUS_CONSTANT_COLOR :: 11;
    CONSTANT_ALPHA           :: 12;
    ONE_MINUS_CONSTANT_ALPHA :: 13;
    SRC_ALPHA_SATURATE       :: 14;
    SRC1_COLOR               :: 15;
    ONE_MINUS_SRC1_COLOR     :: 16;
    SRC1_ALPHA               :: 17;
    ONE_MINUS_SRC1_ALPHA     :: 18;
    MAX_ENUM                 :: 2147483647;
}

Logic_Op :: enum u32 {
    CLEAR         :: 0;
    AND           :: 1;
    AND_REVERSE   :: 2;
    COPY          :: 3;
    AND_INVERTED  :: 4;
    NO_OP         :: 5;
    XOR           :: 6;
    OR            :: 7;
    NOR           :: 8;
    EQUIVALENT    :: 9;
    INVERT        :: 10;
    OR_REVERSE    :: 11;
    COPY_INVERTED :: 12;
    OR_INVERTED   :: 13;
    NAND          :: 14;
    SET           :: 15;
    MAX_ENUM      :: 2147483647;
}

Dynamic_State :: enum u32 {
    VIEWPORT                                :: 0;
    SCISSOR                                 :: 1;
    LINE_WIDTH                              :: 2;
    DEPTH_BIAS                              :: 3;
    BLEND_CONSTANTS                         :: 4;
    DEPTH_BOUNDS                            :: 5;
    STENCIL_COMPARE_MASK                    :: 6;
    STENCIL_WRITE_MASK                      :: 7;
    STENCIL_REFERENCE                       :: 8;
    CULL_MODE                               :: 1000267000;
    FRONT_FACE                              :: 1000267001;
    PRIMITIVE_TOPOLOGY                      :: 1000267002;
    VIEWPORT_WITH_COUNT                     :: 1000267003;
    SCISSOR_WITH_COUNT                      :: 1000267004;
    VERTEX_INPUT_BINDING_STRIDE             :: 1000267005;
    DEPTH_TEST_ENABLE                       :: 1000267006;
    DEPTH_WRITE_ENABLE                      :: 1000267007;
    DEPTH_COMPARE_OP                        :: 1000267008;
    DEPTH_BOUNDS_TEST_ENABLE                :: 1000267009;
    STENCIL_TEST_ENABLE                     :: 1000267010;
    STENCIL_OP                              :: 1000267011;
    RASTERIZER_DISCARD_ENABLE               :: 1000377001;
    DEPTH_BIAS_ENABLE                       :: 1000377002;
    PRIMITIVE_RESTART_ENABLE                :: 1000377004;
    LINE_STIPPLE                            :: 1000259000;
    VIEWPORT_W_SCALING_NV                   :: 1000087000;
    DISCARD_RECTANGLE_EXT                   :: 1000099000;
    DISCARD_RECTANGLE_ENABLE_EXT            :: 1000099001;
    DISCARD_RECTANGLE_MODE_EXT              :: 1000099002;
    SAMPLE_LOCATIONS_EXT                    :: 1000143000;
    RAY_TRACING_PIPELINE_STACK_SIZE_KHR     :: 1000347000;
    VIEWPORT_SHADING_RATE_PALETTE_NV        :: 1000164004;
    VIEWPORT_COARSE_SAMPLE_ORDER_NV         :: 1000164006;
    EXCLUSIVE_SCISSOR_ENABLE_NV             :: 1000205000;
    EXCLUSIVE_SCISSOR_NV                    :: 1000205001;
    FRAGMENT_SHADING_RATE_KHR               :: 1000226000;
    VERTEX_INPUT_EXT                        :: 1000352000;
    PATCH_CONTROL_POINTS_EXT                :: 1000377000;
    LOGIC_OP_EXT                            :: 1000377003;
    COLOR_WRITE_ENABLE_EXT                  :: 1000381000;
    DEPTH_CLAMP_ENABLE_EXT                  :: 1000455003;
    POLYGON_MODE_EXT                        :: 1000455004;
    RASTERIZATION_SAMPLES_EXT               :: 1000455005;
    SAMPLE_MASK_EXT                         :: 1000455006;
    ALPHA_TO_COVERAGE_ENABLE_EXT            :: 1000455007;
    ALPHA_TO_ONE_ENABLE_EXT                 :: 1000455008;
    LOGIC_OP_ENABLE_EXT                     :: 1000455009;
    COLOR_BLEND_ENABLE_EXT                  :: 1000455010;
    COLOR_BLEND_EQUATION_EXT                :: 1000455011;
    COLOR_WRITE_MASK_EXT                    :: 1000455012;
    TESSELLATION_DOMAIN_ORIGIN_EXT          :: 1000455002;
    RASTERIZATION_STREAM_EXT                :: 1000455013;
    CONSERVATIVE_RASTERIZATION_MODE_EXT     :: 1000455014;
    EXTRA_PRIMITIVE_OVERESTIMATION_SIZE_EXT :: 1000455015;
    DEPTH_CLIP_ENABLE_EXT                   :: 1000455016;
    SAMPLE_LOCATIONS_ENABLE_EXT             :: 1000455017;
    COLOR_BLEND_ADVANCED_EXT                :: 1000455018;
    PROVOKING_VERTEX_MODE_EXT               :: 1000455019;
    LINE_RASTERIZATION_MODE_EXT             :: 1000455020;
    LINE_STIPPLE_ENABLE_EXT                 :: 1000455021;
    DEPTH_CLIP_NEGATIVE_ONE_TO_ONE_EXT      :: 1000455022;
    VIEWPORT_W_SCALING_ENABLE_NV            :: 1000455023;
    VIEWPORT_SWIZZLE_NV                     :: 1000455024;
    COVERAGE_TO_COLOR_ENABLE_NV             :: 1000455025;
    COVERAGE_TO_COLOR_LOCATION_NV           :: 1000455026;
    COVERAGE_MODULATION_MODE_NV             :: 1000455027;
    COVERAGE_MODULATION_TABLE_ENABLE_NV     :: 1000455028;
    COVERAGE_MODULATION_TABLE_NV            :: 1000455029;
    SHADING_RATE_IMAGE_ENABLE_NV            :: 1000455030;
    REPRESENTATIVE_FRAGMENT_TEST_ENABLE_NV  :: 1000455031;
    COVERAGE_REDUCTION_MODE_NV              :: 1000455032;
    ATTACHMENT_FEEDBACK_LOOP_ENABLE_EXT     :: 1000524000;
    DEPTH_CLAMP_RANGE_EXT                   :: 1000582000;
    LINE_STIPPLE_EXT                        :: 1000259000;
    CULL_MODE_EXT                           :: 1000267000;
    FRONT_FACE_EXT                          :: 1000267001;
    PRIMITIVE_TOPOLOGY_EXT                  :: 1000267002;
    VIEWPORT_WITH_COUNT_EXT                 :: 1000267003;
    SCISSOR_WITH_COUNT_EXT                  :: 1000267004;
    VERTEX_INPUT_BINDING_STRIDE_EXT         :: 1000267005;
    DEPTH_TEST_ENABLE_EXT                   :: 1000267006;
    DEPTH_WRITE_ENABLE_EXT                  :: 1000267007;
    DEPTH_COMPARE_OP_EXT                    :: 1000267008;
    DEPTH_BOUNDS_TEST_ENABLE_EXT            :: 1000267009;
    STENCIL_TEST_ENABLE_EXT                 :: 1000267010;
    STENCIL_OP_EXT                          :: 1000267011;
    RASTERIZER_DISCARD_ENABLE_EXT           :: 1000377001;
    DEPTH_BIAS_ENABLE_EXT                   :: 1000377002;
    PRIMITIVE_RESTART_ENABLE_EXT            :: 1000377004;
    LINE_STIPPLE_KHR                        :: 1000259000;
    MAX_ENUM                                :: 2147483647;
}

Semaphore_Type :: enum u32 {
    BINARY       :: 0;
    TIMELINE     :: 1;
    BINARY_KHR   :: BINARY;
    TIMELINE_KHR :: TIMELINE;
}

Command_Pool_Create_Flags :: enum u32 {
    TRANSIENT            :: 1;
    RESET_COMMAND_BUFFER :: 2;
    PROTECTED            :: 4;
    FLAG_BITS_MAX_ENUM   :: 2147483647;
}

Command_Buffer_Level :: enum u32 {
    PRIMARY   :: 0;
    SECONDARY :: 1;
    MAX_ENUM  :: 2147483647;
}

Attachment_Store_Op :: enum u32 {
    STORE     :: 0;
    DONT_CARE :: 1;
    NONE      :: 1000301000;
    NONE_KHR  :: 1000301000;
    NONE_QCOM :: 1000301000;
    NONE_EXT  :: 1000301000;
    MAX_ENUM  :: 2147483647;
}

Attachment_Load_Op :: enum u32 {
    LOAD      :: 0;
    CLEAR     :: 1;
    DONT_CARE :: 2;
    NONE      :: 1000400000;
    NONE_EXT  :: 1000400000;
    NONE_KHR  :: 1000400000;
    MAX_ENUM  :: 2147483647;
}

Pipeline_Bind_Point :: enum u32 {
    GRAPHICS               :: 0;
    COMPUTE                :: 1;

    RAY_TRACING_KHR        :: 1000165000;
    SUBPASS_SHADING_HUAWEI :: 1000369003;
    DATA_GRAPH_ARM         :: 1000507000;
    RAY_TRACING_NV         :: 1000165000;
    MAX_ENUM               :: 2147483647;
}

Sampler_Mipmap_Mode :: enum u32 {
    NEAREST :: 0;
    LINEAR  :: 1;
}

Sampler_Address_Mode :: enum u32 {
    REPEAT                   :: 0;
    MIRRORED_REPEAT          :: 1;
    CLAMP_TO_EDGE            :: 2;
    CLAMP_TO_BORDER          :: 3;
    MIRROR_CLAMP_TO_EDGE     :: 4;
    MIRROR_CLAMP_TO_EDGE_KHR :: MIRROR_CLAMP_TO_EDGE;
}

Filter :: enum u32 {
    NEAREST   :: 0;
    LINEAR    :: 1;
    CUBIC_EXT :: 1000015000;
    CUBIC_IMG :: CUBIC_EXT;
}

Border_Color :: enum u32 {
    FLOAT_TRANSPARENT_BLACK :: 0;
    INT_TRANSPARENT_BLACK   :: 1;
    FLOAT_OPAQUE_BLACK      :: 2;
    INT_OPAQUE_BLACK        :: 3;
    FLOAT_OPAQUE_WHITE      :: 4;
    INT_OPAQUE_WHITE        :: 5;
    FLOAT_CUSTOM_EXT        :: 1000287003;
    INT_CUSTOM_EXT          :: 1000287004;
}

Descriptor_Type :: enum u32 {
    SAMPLER                               :: 0;
    COMBINED_IMAGE_SAMPLER                :: 1;
    SAMPLED_IMAGE                         :: 2;
    STORAGE_IMAGE                         :: 3;
    UNIFORM_TEXEL_BUFFER                  :: 4;
    STORAGE_TEXEL_BUFFER                  :: 5;
    UNIFORM_BUFFER                        :: 6;
    STORAGE_BUFFER                        :: 7;
    UNIFORM_BUFFER_DYNAMIC                :: 8;
    STORAGE_BUFFER_DYNAMIC                :: 9;
    INPUT_ATTACHMENT                      :: 10;
    INLINE_UNIFORM_BLOCK                  :: 1000138000;
    ACCELERATION_STRUCTURE_KHR            :: 1000150000;
    ACCELERATION_STRUCTURE_NV             :: 1000165000;
    SAMPLE_WEIGHT_IMAGE_QCOM              :: 1000440000;
    BLOCK_MATCH_IMAGE_QCOM                :: 1000440001;
    TENSOR_ARM                            :: 1000460000;
    MUTABLE_EXT                           :: 1000351000;
    PARTITIONED_ACCELERATION_STRUCTURE_NV :: 1000570000;
    INLINE_UNIFORM_BLOCK_EXT              :: INLINE_UNIFORM_BLOCK;
    MUTABLE_VALVE                         :: MUTABLE_EXT;
}

Index_Type :: enum u32 {
    UINT16    :: 0;
    UINT32    :: 1;
    UINT8     :: 1000265000;
    NONE_KHR  :: 1000165000;
    NONE_NV   :: NONE_KHR;
    UINT8_EXT :: UINT8;
    UINT8_KHR :: UINT8;
}

make_version :: (major: u32, minor: u32, patch: u32) -> u32 {
    return (major << 22) | (minor << 12) | patch;
}

create_instance :: inline (
    p_create_info: *Instance_Create_Info,
    p_allocator:   *Allocation_Callbacks = null,
) -> Result, Instance {
    instance: Instance = ---;

    result := vkCreateInstance(p_create_info, p_allocator, *instance);

    return result, instance;
}

destroy_instance :: (
    instance:    Instance,
    p_allocator: *Allocation_Callbacks = null,
) -> void #foreign libvulkan "vkDestroyInstance";

destroy_surface_khr :: (
    instance:    Instance,
    surface:     Surface_Khr,
    p_allocator: *Allocation_Callbacks = null,
) -> void #foreign libvulkan "vkDestroySurfaceKHR";

enumerate_physical_devices :: (instance: Instance) -> Result, [..]Physical_Device {
    physical_devices: [..]Physical_Device;
    count: u32;

    result := vkEnumeratePhysicalDevices(instance, *count, null);
    if result != .SUCCESS {
        return result, physical_devices;
    }

    array_resize(*physical_devices, count);

    result = vkEnumeratePhysicalDevices(instance, *count, physical_devices.data);

    return result, physical_devices;
}

get_physical_device_properties :: inline (physical_device: Physical_Device) -> Physical_Device_Properties {
    properties: Physical_Device_Properties;
    vkGetPhysicalDeviceProperties(physical_device, *properties);

    return properties;
}

get_physical_device_queue_family_properties_2 :: inline (physical_device: Physical_Device) -> [..]Queue_Family_Properties_2 {
    qfps: [..]Queue_Family_Properties_2;
    count: u32;

    vkGetPhysicalDeviceQueueFamilyProperties2(physical_device, *count, null);

    array_resize(*qfps, count);

    vkGetPhysicalDeviceQueueFamilyProperties2(physical_device, *count, qfps.data);

    return qfps;
}

get_physical_device_surface_support_khr :: inline (
    physical_device:    Physical_Device,
    queue_family_index: u32,
    surface:            Surface_Khr,
) -> Result, bool {
    is_supported: Bool;

    result := vkGetPhysicalDeviceSurfaceSupportKHR(
        physical_device,
        queue_family_index,
        surface,
        *is_supported,
    );

    return result, cast(bool, is_supported);
}

create_device :: inline (
    physical_device: Physical_Device,
    p_create_info:   *Device_Create_Info,
    p_allocator:     *Allocation_Callbacks = null,
) -> Result, Device {
    device: Device = ---;

    result := vkCreateDevice(physical_device, p_create_info, p_allocator, *device);

    return result, device;
}

destroy_device :: (
    device:      Device,
    p_allocator: *Allocation_Callbacks = null,
) -> void #foreign libvulkan "vkDestroyDevice";

get_physical_device_features_2 :: (
    physical_device: Physical_Device,
    p_features:      *Physical_Device_Features_2,
) -> void #foreign libvulkan "vkGetPhysicalDeviceFeatures2";

get_device_queue :: inline (device: Device, queue_family_index: u32, queue_index: u32) -> Queue {
    queue: Queue;

    vkGetDeviceQueue(device, queue_family_index, queue_index, *queue);

    return queue;
}

get_physical_device_surface_capabilities_khr :: inline (
    physical_device: Physical_Device,
    surface: Surface_Khr,
) -> Result, Surface_Capabilities_Khr {
    capabilities: Surface_Capabilities_Khr = ---;

    result := vkGetPhysicalDeviceSurfaceCapabilitiesKHR(
        physical_device,
        surface,
        *capabilities,
    );

    return result, capabilities;
}

get_physical_device_surface_formats_khr :: (
    physical_device: Physical_Device,
    surface: Surface_Khr,
) -> Result, [..]Surface_Format_Khr {
    formats: [..]Surface_Format_Khr;

    count: u32;

    result := vkGetPhysicalDeviceSurfaceFormatsKHR(
        physical_device,
        surface,
        *count,
        null,
    );
    if result != .SUCCESS {
        return result, formats;
    }

    array_resize(*formats, count);

    result = vkGetPhysicalDeviceSurfaceFormatsKHR(
        physical_device,
        surface,
        *count,
        formats.data,
    );

    return result, formats;
}

create_swapchain_khr :: inline (
    device:        Device,
    p_create_info: *Swapchain_Create_Info_Khr,
    p_allocator:   *Allocation_Callbacks = null,
) -> Result, Swapchain_Khr {
    swapchain: Swapchain_Khr;

    result := vkCreateSwapchainKHR(
        device,
        p_create_info,
        p_allocator,
        *swapchain,
    );

    return result, swapchain;
}

destroy_swapchain_khr :: (
    device:      Device,
    swapchain:   Swapchain_Khr,
    p_allocator: *Allocation_Callbacks = null,
) -> void #foreign libvulkan "vkDestroySwapchainKHR";

get_swapchain_images_khr :: (device: Device, swapchain: Swapchain_Khr) -> Result, [..]Image {
    images: [..]Image;

    count: u32;

    result := vkGetSwapchainImagesKHR(
        device,
        swapchain,
        *count,
        null,
    );
    if result != .SUCCESS {
        return result, images;
    }

    array_resize(*images, count);

    result = vkGetSwapchainImagesKHR(
        device,
        swapchain,
        *count,
        images.data,
    );

    return result, images;
}

create_image_view :: inline (
    device:        Device,
    p_create_info: *Image_View_Create_Info,
    p_allocator:   *Allocation_Callbacks = null,
) -> Result, Image_View {
    view: Image_View = ---;

    result := vkCreateImageView(
        device,
        p_create_info,
        p_allocator,
        *view,
    );

    return result, view;
}

destroy_image :: (
    device:      Device,
    image:       Image,
    p_allocator: *Allocation_Callbacks = null,
) -> void #foreign libvulkan "vkDestroyImage";

destroy_image_view :: (
    device:      Device,
    image_view:  Image_View,
    p_allocator: *Allocation_Callbacks = null,
) -> void #foreign libvulkan "vkDestroyImageView";

destroy_semaphore :: (
    device:     Device,
    semaphore:  Semaphore,
    pAllocator: *Allocation_Callbacks = null,
) -> void #foreign libvulkan "vkDestroySemaphore";

create_semaphore :: inline (
    device:        Device,
    p_create_info: *Semaphore_Create_Info,
    p_allocator:   *Allocation_Callbacks = null,
) -> Result, Semaphore {
    semaphore: Semaphore = ---;

    result := vkCreateSemaphore(
        device,
        p_create_info,
        p_allocator,
        *semaphore,
    );

    return result, semaphore;
}

create_shader_module :: (
    device:        Device,
    p_create_info: *Shader_Module_Create_Info,
    p_allocator:   *Allocation_Callbacks = null,
) -> Result, Shader_Module {
    shader_module: Shader_Module;

    result := vkCreateShaderModule(
        device,
        p_create_info,
        p_allocator,
        *shader_module,
    );

    return result, shader_module;
}

destroy_shader_module :: (
    device:       Device,
    shaderModule: Shader_Module,
    pAllocator:   *Allocation_Callbacks = null,
) -> void #foreign libvulkan "vkDestroyShaderModule";

create_pipeline_layout :: inline (
    device:        Device,
    p_create_info: *Pipeline_Layout_Create_Info,
    p_allocator:   *Allocation_Callbacks = null,
) -> Result, Pipeline_Layout {
    pipeline_layout: Pipeline_Layout = ---;

    result := vkCreatePipelineLayout(
        device,
        p_create_info,
        p_allocator,
        *pipeline_layout,
    );

    return result, pipeline_layout;
}

destroy_pipeline :: (
    device:      Device,
    pipeline:    Pipeline,
    p_allocator: *Allocation_Callbacks = null,
) -> void #foreign libvulkan "vkDestroyPipeline";

destroy_pipeline_layout :: (
    device: Device,
    pipeline_layout: Pipeline_Layout,
    p_allocator: *Allocation_Callbacks = null,
) -> void #foreign libvulkan "vkDestroyPipelineLayout";

create_graphics_pipelines :: inline (
    device:         Device,
    pipeline_cache: Pipeline_Cache,
    p_create_infos: []Graphics_Pipeline_Create_Info,
    p_allocator:    *Allocation_Callbacks = null,
) -> Result, [..]Pipeline {
    pipelines: [..]Pipeline;
    array_resize(*pipelines, p_create_infos.count);

    result := vkCreateGraphicsPipelines(
        device,
        pipeline_cache,
        p_create_infos.count,
        p_create_infos.data,
        p_allocator,
        pipelines.data,
    );

    return result, pipelines;
}


create_graphics_pipeline :: inline (
    device:         Device,
    pipeline_cache: Pipeline_Cache,
    p_create_info:  *Graphics_Pipeline_Create_Info,
    p_allocator:    *Allocation_Callbacks = null,
) -> Result, Pipeline {
    pipeline: Pipeline = ---;

    result := vkCreateGraphicsPipelines(
        device,
        pipeline_cache,
        1,
        p_create_info,
        p_allocator,
        *pipeline,
    );

    return result, pipeline;
}

create_command_pool :: (
    device:        Device,
    p_create_info: *Command_Pool_Create_Info,
    p_allocator:   *Allocation_Callbacks = null,
) -> Result, Command_Pool {
    command_pool: Command_Pool = ---;

    result := vkCreateCommandPool(
        device,
        p_create_info,
        p_allocator,
        *command_pool,
    );

    return result, command_pool;
}

allocate_command_buffer :: inline (
    device: Device,
    p_allocate_info: *Command_Buffer_Allocate_Info,
) -> Result, Command_Buffer {
    command_buffer: Command_Buffer = ---;

    result := vkAllocateCommandBuffers(
        device,
        p_allocate_info,
        *command_buffer,
    );

    return result, command_buffer;
}

destroy_command_pool :: (
    device:      Device,
    commandPool: Command_Pool,
    pAllocator:  *Allocation_Callbacks = null,
) -> void #foreign libvulkan "vkDestroyCommandPool";

device_wait_idle :: (device: Device) -> Result #foreign libvulkan "vkDeviceWaitIdle";

wait_semaphores :: (
    device:      Device,
    p_wait_info: *Semaphore_Wait_Info,
    timeout:     u64,
) -> Result #foreign libvulkan "vkWaitSemaphores";

reset_command_pool :: (
    device:       Device,
    command_pool: Command_Pool,
    flags:        Command_Pool_Reset_Flags,
) -> Result #foreign libvulkan "vkResetCommandPool";

acquire_next_image_khr :: inline (
    device:    Device,
    swapchain: Swapchain_Khr,
    timeout:   u64,
    semaphore: Semaphore,
    fence:     Fence,
) -> Result, u32 {
    index: u32;

    result := vkAcquireNextImageKHR(
        device,
        swapchain,
        timeout,
        semaphore,
        fence,
        *index,
    );

    return result, index;
}

begin_command_buffer :: (
    command_buffer: Command_Buffer,
    p_begin_info:   *Command_Buffer_Begin_Info,
) -> Result #foreign libvulkan "vkBeginCommandBuffer";

cmd_pipeline_barrier_2 :: (
    command_buffer: Command_Buffer,
    p_dependency_info: *Dependency_Info,
) -> void #foreign libvulkan "vkCmdPipelineBarrier2";

cmd_begin_rendering :: (
    command_buffer: Command_Buffer,
    p_rendering_info: *Rendering_Info,
) -> void #foreign libvulkan "vkCmdBeginRendering";

cmd_set_viewport :: inline (
    command_buffer: Command_Buffer,
    viewports:      []Viewport,
) {
    vkCmdSetViewport(
        command_buffer,
        0,
        cast(u32, viewports.count),
        viewports.data,
    );
}

cmd_set_scissor :: inline (command_buffer: Command_Buffer, scissors: []Rect_2D) {
    vkCmdSetScissor(
        command_buffer,
        0,
        cast(u32, scissors.count),
        scissors.data,
    );
}

cmd_bind_pipeline :: (
    command_buffer:      Command_Buffer,
    pipeline_bind_point: Pipeline_Bind_Point,
    pipeline:            Pipeline,
) -> void #foreign libvulkan "vkCmdBindPipeline";

cmd_draw :: (
    command_buffer: Command_Buffer,
    vertex_count:   u32,
    instance_count: u32,
    first_vertex:   u32,
    first_instance: u32,
) -> void #foreign libvulkan "vkCmdDraw";

cmd_end_rendering :: (command_buffer: Command_Buffer) -> void #foreign libvulkan "vkCmdEndRendering";

end_command_buffer :: (command_buffer: Command_Buffer) -> Result #foreign libvulkan "vkEndCommandBuffer";

queue_submit_2 :: inline (
    queue:     Queue,
    p_submits: []Submit_Info_2,
    fence:     Fence
) -> Result {
    return vkQueueSubmit2(
        queue,
        cast(u32, p_submits.count),
        p_submits.data,
        fence,
    );
}

queue_present_khr :: (
    queue: Queue,
    p_present_info: *Present_Info_Khr,
) -> Result #foreign libvulkan "vkQueuePresentKHR";

cmd_copy_buffer_to_image :: (
    command_buffer: Command_Buffer,
    src_buffer: Buffer,
    dst_image: Image,
    dst_image_layout: Image_Layout,
    region_count: u32,
    p_regions: *Buffer_Image_Copy,
) -> void #foreign libvulkan "vkCmdCopyBufferToImage";

queue_submit :: inline (queue: Queue, submits: []Submit_Info, fence: Fence) -> Result {
    return vkQueueSubmit(queue, xx submits.count, submits.data, fence);
}

queue_wait_idle :: (queue: Queue) -> Result #foreign libvulkan "vkQueueWaitIdle";

free_command_buffers :: inline (
    device:          Device,
    command_pool:    Command_Pool,
    command_buffers: []Command_Buffer,
) {
    vkFreeCommandBuffers(device, command_pool, xx command_buffers.count, command_buffers.data);
}

create_sampler :: inline (
    device: Device,
    p_create_info: *Sampler_Create_Info,
    p_allocator: *Allocation_Callbacks = null,
) -> Result, Sampler {
    sampler: Sampler;

    result := vkCreateSampler(device, p_create_info, p_allocator, *sampler);

    return result, sampler;
}

destroy_sampler :: (
    device:      Device,
    sampler:     Sampler,
    p_allocator: *Allocation_Callbacks = null,
) -> void #foreign libvulkan "vkDestroySampler";

get_buffer_device_address :: (
    device: Device,
    p_info: *Buffer_Device_Address_Info,
) -> Device_Address #foreign libvulkan "vkGetBufferDeviceAddress";

cmd_copy_buffer :: inline (
    command_buffer: Command_Buffer,
    src_buffer:     Buffer,
    dst_buffer:     Buffer,
    regions:        []Buffer_Copy,
) {
    vkCmdCopyBuffer(command_buffer, src_buffer, dst_buffer, xx regions.count, regions.data);
}

update_descriptor_sets :: inline (
    device: Device,
    descriptor_writes: []Write_Descriptor_Set,
    descriptor_copies: []Copy_Descriptor_Set,
) {
    vkUpdateDescriptorSets(
        device,
        xx descriptor_writes.count,
        descriptor_writes.data,
        xx descriptor_copies.count,
        descriptor_copies.data,
    );
}

create_descriptor_pool :: inline (
    device:        Device,
    p_create_info: *Descriptor_Pool_Create_Info,
    p_allocator:   *Allocation_Callbacks = null,
) -> Result, Descriptor_Pool {
    descriptor_pool: Descriptor_Pool;

    result := vkCreateDescriptorPool(device, p_create_info, p_allocator, *descriptor_pool);

    return result, descriptor_pool;
}

create_descriptor_set_layout :: inline (
    device: Device,
    p_create_info: *Descriptor_Set_Layout_Create_Info,
    p_allocator: *Allocation_Callbacks = null,
) -> Result, Descriptor_Set_Layout {
    set_layout: Descriptor_Set_Layout;

    result := vkCreateDescriptorSetLayout(device, p_create_info, p_allocator, *set_layout);

    return result, set_layout;
}

allocate_descriptor_sets :: (device: Device, p_allocate_info: *Descriptor_Set_Allocate_Info) -> Result, [..]Descriptor_Set {
    descriptor_sets: [..]Descriptor_Set;
    array_resize(*descriptor_sets, p_allocate_info.descriptor_set_count);

    result := vkAllocateDescriptorSets(device, p_allocate_info, descriptor_sets.data);

    return result, descriptor_sets;
}

destroy_descriptor_pool :: (
    device:          Device,
    descriptor_pool: Descriptor_Pool,
    p_allocator:     *Allocation_Callbacks = null,
) -> void #foreign libvulkan "vkDestroyDescriptorPool";

destroy_descriptor_set_layout :: (
    device:                Device,
    descriptor_set_layout: Descriptor_Set_Layout,
    p_allocator:           *Allocation_Callbacks = null,
) -> void #foreign libvulkan "vkDestroyDescriptorSetLayout";

create_buffer :: inline (
    device:        Device,
    p_create_info: *Buffer_Create_Info,
    p_allocator:   *Allocation_Callbacks = null,
) -> Result, Buffer {
    buffer: Buffer;
    result := vkCreateBuffer(device, p_create_info, p_allocator, *buffer);

    return result, buffer;
}

get_buffer_memory_requirements :: (device: Device, buffer: Buffer) -> Memory_Requirements {
    memory_reqs: Memory_Requirements;

    vkGetBufferMemoryRequirements(device, buffer, *memory_reqs);

    return memory_reqs;
}

get_buffer_memory_requirements_2 :: (
    device:                Device,
    p_info:                *Buffer_Memory_Requirements_Info_2,
    p_memory_requirements: *Memory_Requirements_2,
) -> void #foreign libvulkan "vkGetBufferMemoryRequirements2";

cmd_bind_descriptor_sets :: inline (
    command_buffer:      Command_Buffer,
    pipeline_bind_point: Pipeline_Bind_Point,
    layout:              Pipeline_Layout,
    first_set:           u32,
    descriptor_sets:     []Descriptor_Set,
    dynamic_offsets:     []u32,
) {
    vkCmdBindDescriptorSets(
        command_buffer,
        pipeline_bind_point,
        layout,
        first_set,
        xx descriptor_sets.count,
        descriptor_sets.data,
        xx dynamic_offsets.count,
        dynamic_offsets.data,
    );
}

cmd_push_constants :: (
    command_buffer: Command_Buffer,
    layout:         Pipeline_Layout,
    stage_flags:    Shader_Stage_Flags,
    offset:         u32,
    size:           u32,
    p_values:       *void,
) -> void #foreign libvulkan "vkCmdPushConstants";


cmd_bind_index_buffer :: (
    command_buffer: Command_Buffer,
    buffer:         Buffer,
    offset:         Device_Size,
    index_type:     Index_Type,
) -> void #foreign libvulkan "vkCmdBindIndexBuffer";

cmd_draw_indexed_indirect :: (
    command_buffer: Command_Buffer,
    buffer:         Buffer,
    offset:         Device_Size,
    draw_count:     u32,
    stride:         u32,
) -> void #foreign libvulkan "vkCmdDrawIndexedIndirect";



#scope_file

Instance_T              :: struct {}
Surface_Khr_T           :: struct {}
Physical_Device_T       :: struct {}
Device_T                :: struct {}
Queue_T                 :: struct {}
Device_Memory_T         :: struct {}
Swapchain_Khr_T         :: struct {}
Image_T                 :: struct {}
Image_View_T            :: struct {}
Semaphore_T             :: struct {}
Shader_Module_T         :: struct {}
Descriptor_Set_Layout_T :: struct {}
Pipeline_T              :: struct {}
Pipeline_Layout_T       :: struct {}
Sample_Mask_T           :: struct {}
Render_Pass_T           :: struct {}
Pipeline_Cache_T        :: struct {}
Command_Pool_T          :: struct {}
Command_Buffer_T        :: struct {}
Fence_T                 :: struct {}
Framebuffer_T           :: struct {}
Buffer_T                :: struct {}
Sampler_T               :: struct {}
Descriptor_Set_T        :: struct {}
Buffer_View_T           :: struct {}
Descriptor_Pool_T       :: struct {}

vkCreateInstance :: (
    p_create_info: *Instance_Create_Info,
    p_allocator:   *Allocation_Callbacks,
    p_instance:    *Instance,
) -> Result #foreign libvulkan;

vkEnumeratePhysicalDevices :: (
    instance:                Instance,
    p_physical_device_count: *u32,
    p_physical_devices:      *Physical_Device,
) -> Result #foreign libvulkan;

vkGetPhysicalDeviceProperties :: (
    physical_device: Physical_Device,
    p_properties:    *Physical_Device_Properties,
) -> void #foreign libvulkan;

vkGetPhysicalDeviceQueueFamilyProperties2 :: (
    physical_device:               Physical_Device,
    p_queue_family_property_count: *u32,
    p_queue_family_properties:     *Queue_Family_Properties_2,
) -> void #foreign libvulkan;


vkGetPhysicalDeviceSurfaceSupportKHR :: (
    physical_device:    Physical_Device,
    queue_family_index: u32,
    surface:            Surface_Khr,
    p_supported:        *Bool,
) -> Result #foreign libvulkan;

vkCreateDevice :: (
    physical_device: Physical_Device,
    p_create_info:   *Device_Create_Info,
    p_allocator:     *Allocation_Callbacks,
    p_device:        *Device,
) -> Result #foreign libvulkan;

vkGetDeviceQueue :: (
    device:             Device,
    queue_family_index: u32,
    queue_index:        u32,
    p_queue:            *Queue,
) -> void #foreign libvulkan;

vkGetPhysicalDeviceSurfaceCapabilitiesKHR :: (
    physical_device:        Physical_Device,
    surface:                Surface_Khr,
    p_surface_capabilities: *Surface_Capabilities_Khr,
) -> Result #foreign libvulkan;

vkGetPhysicalDeviceSurfaceFormatsKHR :: (
    physical_device:        Physical_Device,
    surface:                Surface_Khr,
    p_surface_format_count: *u32,
    p_surface_formats:      *Surface_Format_Khr,
) -> Result #foreign libvulkan;

vkCreateSwapchainKHR :: (
    device:        Device,
    p_create_info: *Swapchain_Create_Info_Khr,
    p_allocator:   *Allocation_Callbacks,
    p_swapchain:   *Swapchain_Khr,
) -> Result #foreign libvulkan;

vkGetSwapchainImagesKHR :: (
    device:                  Device,
    swapchain:               Swapchain_Khr,
    p_swapchain_image_count: *u32,
    p_swapchain_images:      *Image,
) -> Result #foreign libvulkan;

vkCreateImageView :: (
    device:        Device,
    p_create_info: *Image_View_Create_Info,
    p_allocator:   *Allocation_Callbacks,
    p_view:        *Image_View,
) -> Result #foreign libvulkan;

vkCreateSemaphore :: (
    device:        Device,
    p_create_info: *Semaphore_Create_Info,
    p_allocator:   *Allocation_Callbacks,
    p_semaphore:   *Semaphore
) -> Result #foreign libvulkan;

vkCreateShaderModule :: (
    device:          Device,
    p_create_info:   *Shader_Module_Create_Info,
    p_allocator:     *Allocation_Callbacks,
    p_shader_module: *Shader_Module,
) -> Result #foreign libvulkan;

vkCreatePipelineLayout :: (
    device:            Device,
    p_create_info:     *Pipeline_Layout_Create_Info,
    p_allocator:       *Allocation_Callbacks,
    p_pipeline_layout: *Pipeline_Layout,
) -> Result #foreign libvulkan;

vkCreateGraphicsPipelines :: (
    device:            Device,
    pipeline_cache:    Pipeline_Cache,
    create_info_count: u32,
    p_create_infos:    *Graphics_Pipeline_Create_Info,
    p_allocator:       *Allocation_Callbacks,
    p_pipelines:       *Pipeline,
) -> Result #foreign libvulkan;

vkCreateCommandPool :: (
    device:         Device,
    p_create_info:  *Command_Pool_Create_Info,
    p_allocator:    *Allocation_Callbacks,
    p_command_pool: *Command_Pool,
) -> Result #foreign libvulkan;

vkAllocateCommandBuffers :: (
    device:            Device,
    p_allocate_info:   *Command_Buffer_Allocate_Info,
    p_command_buffers: *Command_Buffer,
) -> Result #foreign libvulkan;

vkAcquireNextImageKHR :: (
    device:        Device,
    swapchain:     Swapchain_Khr,
    timeout:       u64,
    semaphore:     Semaphore,
    fence:         Fence,
    p_image_index: *u32,
) -> Result #foreign libvulkan;

vkCmdSetViewport :: (
    commandBuffer: Command_Buffer,
    firstViewport: u32,
    viewportCount: u32,
    pViewports:    *Viewport,
) -> void #foreign libvulkan;

vkCmdSetScissor :: (
    commandBuffer: Command_Buffer,
    firstScissor:  u32,
    scissorCount:  u32,
    pScissors:     *Rect_2D,
) -> void #foreign libvulkan;

vkQueueSubmit2 :: (
    queue:        Queue,
    submit_count: u32,
    p_submits:    *Submit_Info_2,
    fence:        Fence,
) -> Result #foreign libvulkan;

vkQueueSubmit :: (
    queue:        Queue,
    submit_count: u32,
    p_submits:    *Submit_Info,
    fence:        Fence,
) -> Result #foreign libvulkan;

vkFreeCommandBuffers :: (
    device:               Device,
    command_pool:         Command_Pool,
    command_buffer_count: u32,
    p_command_buffers:    *Command_Buffer,
) -> void #foreign libvulkan;

vkCreateSampler :: (
    device:        Device,
    p_create_info: *Sampler_Create_Info,
    p_allocator:   *Allocation_Callbacks,
    p_sampler:     *Sampler,
) -> Result #foreign libvulkan;

vkCmdCopyBuffer :: (
    command_buffer: Command_Buffer,
    src_buffer:     Buffer,
    dst_buffer:     Buffer,
    region_count:   u32,
    p_regions:      *Buffer_Copy,
) -> void #foreign libvulkan;

vkUpdateDescriptorSets :: (
    device:                 Device,
    descriptor_write_count: u32,
    p_descriptor_writes:    *Write_Descriptor_Set,
    descriptor_copy_count:  u32,
    p_descriptor_copies:    *Copy_Descriptor_Set,
) -> void #foreign libvulkan;

vkCreateDescriptorPool :: (
    device:            Device,
    p_create_info:     *Descriptor_Pool_Create_Info,
    p_allocator:       *Allocation_Callbacks,
    p_descriptor_pool: *Descriptor_Pool,
) -> Result #foreign libvulkan;


vkCreateDescriptorSetLayout :: (
    device:      Device,
    pCreateInfo: *Descriptor_Set_Layout_Create_Info,
    pAllocator:  *Allocation_Callbacks,
    pSetLayout:  *Descriptor_Set_Layout
) -> Result #foreign libvulkan;

vkAllocateDescriptorSets :: (
    device:            Device,
    p_allocate_info:   *Descriptor_Set_Allocate_Info,
    p_descriptor_sets: *Descriptor_Set
) -> Result #foreign libvulkan;

vkCreateBuffer :: (
    device:        Device,
    p_create_info: *Buffer_Create_Info,
    p_allocator:   *Allocation_Callbacks,
    p_buffer:      *Buffer,
) -> Result #foreign libvulkan;

vkGetBufferMemoryRequirements :: (
    device:                Device,
    buffer:                Buffer,
    p_memory_requirements: *Memory_Requirements,
) -> void #foreign libvulkan;

vkGetBufferMemoryRequirements2 :: (
    device:                Device,
    p_info:                *Buffer_Memory_Requirements_Info_2,
    p_memory_requirements: *Memory_Requirements_2,
) -> void #foreign libvulkan;

vkCmdBindDescriptorSets :: (
    command_buffer: Command_Buffer,
    pipeline_bind_point: Pipeline_Bind_Point,
    layout: Pipeline_Layout,
    first_set: u32,
    descriptor_set_count: u32,
    p_descriptor_sets: *Descriptor_Set,
    dynamic_offset_count: u32,
    p_dynamic_offsets: *u32,
) -> void #foreign libvulkan;

#if OS == {
    case .LINUX;
        libvulkan :: #library,system "libvulkan";
    case;
        #assert "Unsupported OS";
}

#import "Basic";
