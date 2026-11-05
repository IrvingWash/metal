IMPL_VULKAN_MINIMUM_SAMPLED_IMAGE_POOL_SIZE :: 8;
IMPL_VULKAN_MINIMUM_SAMPLER_POOL_SIZE       :: 2;

Impl_Vulkan_Init_Info :: struct {
    api_version:          u32; // Fill with API version of Instance, e.g. VK_API_VERSION_1_3 or your value of VkApplicationInfo::apiVersion. May be lower than header version (VK_HEADER_VERSION_COMPLETE)
    instance:             VK.Instance;
    physical_device:      VK.Physical_Device;
    device:               VK.Device;
    queue_family:         u32;
    queue:                VK.Queue;
    descriptor_pool:      VK.Descriptor_Pool; // See requirements in note above; ignored if using DescriptorPoolSize > 0
    descriptor_pool_size: u32; // Optional: set to create internal ImageView descriptor pool automatically instead of using DescriptorPool.
    min_image_count:      u32; // >= 2
    image_count:          u32; // >= MinImageCount
    pipeline_cache:       VK.Pipeline_Cache; // Optional

    pipeline_info_main: Impl_Vulkan_Pipeline_Info; // Infos for Main Viewport (created by app/user)

    // (Optional) Dynamic Rendering
    // Need to explicitly enable VK_KHR_dynamic_rendering extension to use this, even for Vulkan 1.3 + setup PipelineInfoMain.PipelineRenderingCreateInfo.
    use_dynamic_rendering: bool;

    // (Optional) Allocation, Debugging
    allocator:           *VK.Allocation_Callbacks;
    check_vk_result_fn:  #type (err: VK.Result) -> void #c_call;
    min_allocation_size: VK.Device_Size; // Minimum allocation size. Set to 1024*1024 to satisfy zealous best practices validation layer and waste a little memory.

    // (Optional) Customize default vertex/fragment shaders.
    // - if .sType == VK_STRUCTURE_TYPE_SHADER_MODULE_CREATE_INFO we use specified structs, otherwise we use defaults.
    // - Shader inputs/outputs need to match ours. Code/data pointed to by the structure needs to survive for whole during of backend usage.
    custom_shader_vert_create_info: VK.Shader_Module_Create_Info;
    custom_shader_vert_create_info.s_type = 0;
    custom_shader_frag_create_info: VK.Shader_Module_Create_Info;
    custom_shader_frag_create_info.s_type = 0;
}

Impl_Vulkan_Pipeline_Info :: struct {
    render_pass:          VK.Render_Pass; // Ignored if using dynamic rendering
    subpass:              u32; //
    msaa_samples:         VK.Sample_Count_Flags; // 0 defaults to VK_SAMPLE_COUNT_1_BIT
    extra_dynamic_states: Vector(VK.Dynamic_State); // Optional, allows to insert more dynamic states into our VkPipeline

    pipeline_rendering_create_info: VK.Pipeline_Rendering_Create_Info; // Optional, valid if .sType == VK_STRUCTURE_TYPE_PIPELINE_RENDERING_CREATE_INFO_KHR
    pipeline_rendering_create_info.s_type = 0;
}

impl_vulkan_init :: (info: *Impl_Vulkan_Init_Info) -> bool #foreign libimgui "_Z21ImGui_ImplVulkan_InitP25ImGui_ImplVulkan_InitInfo";

impl_vulkan_new_frame :: () -> void #foreign libimgui "_Z25ImGui_ImplVulkan_NewFramev";

impl_vulkan_shutdown :: () -> void #foreign libimgui "_Z25ImGui_ImplVulkan_Shutdownv";

impl_vulkan_render_draw_data :: (
    draw_data:      *Draw_Data,
    command_buffer: VK.Command_Buffer,
    pipeline:       VK.Pipeline = null,
) -> void #foreign libimgui "_Z31ImGui_ImplVulkan_RenderDrawDataP10ImDrawDataP17VkCommandBuffer_TP12VkPipeline_T";


#scope_file

VK :: #import "Jai_Vulkan";
