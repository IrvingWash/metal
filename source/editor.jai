init_editor :: () {
    editor.ctx = IM.CreateContext();
    editor.io = IM.GetIO();

    IM.ImplSDL3_InitForVulkan(cast(*void, state.window));

    pool_sizes := VK.Descriptor_Pool_Size.[
        { type = .SAMPLED_IMAGE, descriptor_count = IM.IMGUI_IMPL_VULKAN_MINIMUM_SAMPLED_IMAGE_POOL_SIZE },
        { type = .SAMPLER, descriptor_count = IM.IMGUI_IMPL_VULKAN_MINIMUM_SAMPLER_POOL_SIZE },
    ];
    pool_info := VK.Descriptor_Pool_Create_Info.{
        flags           = .FREE_DESCRIPTOR_SET,
        max_sets        = 16,
        pool_size_count = pool_sizes.count,
        p_pool_sizes    = pool_sizes.data,
    };
    result:, editor.descriptor_pool = VK.create_descriptor_pool(state.renderer.device, *pool_info);
    assert(result == .SUCCESS, "%", result);

    vulkan_init_info: IM.ImplVulkan_InitInfo;
    vulkan_init_info.PipelineInfoMain.PipelineRenderingCreateInfo.sType = .VK_STRUCTURE_TYPE_PIPELINE_RENDERING_CREATE_INFO;
    vulkan_init_info.ApiVersion          = VK.make_version(1, 4, 0);
    vulkan_init_info.Instance            = cast(*void, state.renderer.instance);
    vulkan_init_info.PhysicalDevice      = cast(*void, state.renderer.physical_device);
    vulkan_init_info.Device              = cast(*void, state.renderer.device);
    vulkan_init_info.QueueFamily         = state.renderer.graphics_queue_info.family_index;
    vulkan_init_info.Queue               = cast(*void, state.renderer.graphics_queue_info.queue);
    vulkan_init_info.DescriptorPool      = cast(*void, editor.descriptor_pool);
    vulkan_init_info.MinImageCount       = state.renderer.swapchain_info.config.min_image_count;
    vulkan_init_info.ImageCount          = cast(u32, state.renderer.swapchain_info.images.count);
    vulkan_init_info.UseDynamicRendering = true;
    vulkan_init_info.PipelineInfoMain.PipelineRenderingCreateInfo.colorAttachmentCount     = 1;
    vulkan_init_info.PipelineInfoMain.PipelineRenderingCreateInfo.pColorAttachmentFormats = cast(*void, *state.
        renderer.
        swapchain_info
        .config.
        image_format
    );

    IM.ImplVulkan_Init(*vulkan_init_info);
}

draw_editor :: () {
    IM.ImplVulkan_NewFrame();
    IM.ImplSDL3_NewFrame();
    IM.NewFrame();
    IM.ShowDemoWindow();

    IM.Render();
}

deinit_editor :: () {
    VK.device_wait_idle(state.renderer.device);

    IM.ImplVulkan_Shutdown();
    VK.destroy_descriptor_pool(state.renderer.device, editor.descriptor_pool);
    IM.ImplSDL3_Shutdown();

    IM.DestroyContext(editor.ctx);

    editor = {};
}



#scope_file

Editor :: struct {
    ctx: *IM.ImGuiContext;
    io:  *IM.IO;

    descriptor_pool: VK.Descriptor_Pool;
}

editor: Editor;

IM :: #import "Dear_ImGui";
VK :: #import "Jai_Vulkan";
