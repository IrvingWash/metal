#module_parameters()(Window_Type: Type, APPLICATION_NAME: string, DEBUG: bool = false);

Additional_Instance_Extensions_Getter :: #type () -> [..]*u8;

Window_Render_Size_Getter             :: #type (window: Window_Type) -> width: u32, height: u32;

Window_Surface_Creator :: #type (
    window: Window_Type,
    instance: VK.Instance,
    allocator: *VK.Allocation_Callbacks = null,
) -> VK.Surface_Khr;

Renderer :: struct {
    window:                Window_Type;
    get_window_render_size: Window_Render_Size_Getter;

    instance:            VK.Instance;
    surface:             VK.Surface_Khr;
    physical_device:     VK.Physical_Device;
    graphics_queue_info: Queue_Info;
    device:              VK.Device;
    allocator:           VMA.Allocator;

    timeline_semaphore_info: Timeline_Semaphore_Info;

    swapchain_info:   Swapchain_Info;
    depth_image_info: Image_Info;

    #if DEBUG {
        debug_utils_messenger: VK.Debug_Utils_Messenger_Ext;
    }
}

Queue_Info :: struct {
    family_index: u32;
    queue:        VK.Queue;
}

Swapchain_Info :: struct {
    swapchain:                  VK.Swapchain_Khr;
    config:                     VK.Swapchain_Create_Info_Khr;

    images:                     [..]VK.Image;
    image_views:                [..]VK.Image_View;
    render_complete_semaphores: [..]VK.Semaphore;
}

Image_Info :: struct {
    image:      VK.Image;
    image_view: VK.Image_View;
    allocation: VMA.Allocation;
}

Timeline_Semaphore_Info :: struct {
    semaphore:         VK.Semaphore;
    next_signal_value: u64;
}

init :: (
    window:                                Window_Type,
    additional_instance_extensions_getter: Additional_Instance_Extensions_Getter,
    window_renderer_size_getter:              Window_Render_Size_Getter,
    create_window_surface:                 Window_Surface_Creator,
) -> error: string, Renderer {
    renderer: Renderer;

    renderer.window = window;
    renderer.get_window_render_size = window_renderer_size_getter;

    error:, renderer.instance = create_instance(additional_instance_extensions_getter);
    if error {
        return
            error,
            renderer;
    }

    #if DEBUG {
        renderer.debug_utils_messenger = create_debug_utils_messenger(renderer.instance);
    }

    error, renderer.surface = create_surface(
        renderer.instance,
        renderer.window,
        create_window_surface,
    );
    if error {
        return
            error,
            renderer;
    }

    error, renderer.physical_device = find_physical_device(renderer.instance, renderer.surface);
    if error {
        return
            error,
            renderer;
    }

    error, renderer.graphics_queue_info.family_index = find_graphics_queue_family_index(
        renderer.physical_device,
        renderer.surface,
    );
    if error {
        return
            error,
            renderer;
    }

    error, renderer.device = create_device(renderer.physical_device, .[renderer.graphics_queue_info]);
    if error {
        return
            error,
            renderer;
    }

    renderer.graphics_queue_info.queue = VK.get_device_queue(
        renderer.device,
        renderer.graphics_queue_info.family_index,
        queue_index = 0,
    );

    error, renderer.allocator = create_allocator(
        renderer.instance,
        renderer.physical_device,
        renderer.device,
    );
    if error {
        return
            error,
            renderer;
    }

    error, renderer.timeline_semaphore_info = create_timeline_semaphore(renderer.device);
    if error {
        return
            error,
            renderer;
    }

    error, renderer.swapchain_info = create_swapchain(
        renderer.physical_device,
        renderer.surface,
        renderer.device,
        renderer.window,
        renderer.get_window_render_size,
    );
    if error {
        return
            error,
            renderer;
    }

    error, renderer.depth_image_info = create_depth_image(
        renderer.device,
        renderer.allocator,
        renderer.swapchain_info.config.image_extent.width,
        renderer.swapchain_info.config.image_extent.height,
    );
    if error {
        return
            error,
            renderer;
    }

    return
        "",
        renderer;
}

deinit :: (renderer: *Renderer) {
    VK.device_wait_idle(renderer.device);

    destroy_image(
        renderer.device,
        renderer.allocator,
        *renderer.depth_image_info,
    );
    destroy_swapchain(renderer.device, *renderer.swapchain_info);

    VK.destroy_semaphore(renderer.device, renderer.timeline_semaphore_info.semaphore);

    VMA.destroy_allocator(renderer.allocator);

    VK.destroy_device(renderer.device);

    VK.destroy_surface_khr(renderer.instance, renderer.surface);

    #if DEBUG {
        destroy_debug_utils_messenger(renderer.instance, renderer.debug_utils_messenger);
    }

    VK.destroy_instance(renderer.instance);

    renderer.* = {};
}



#scope_file

VULKAN_API_VERSION :: #run VK.make_version(1, 4, 0);

SURFACE_FORMAT :: VK.Surface_Format_Khr.{
    format      = .B8G8R8A8_SRGB,
    color_space = .SRGB_NONLINEAR_KHR,
};

DEFAULT_PRESENT_MODE :: VK.Present_Mode_Khr.FIFO_KHR;

DEPTH_IMAGE_FORMAT :: VK.Format.D32_SFLOAT;

DEVICE_EXTENSIONS :: *u8.[
    VK.Extension_Names.KHR_SWAPCHAIN,
];

FRAMES_IN_FLIGHT_COUNT :: 2;

#if DEBUG {
    DEBUG_INSTANCE_EXTENSIONS :: *u8.[
        VK.Extension_Names.DEBUG_UTILS
    ];

    DEBUG_LAYERS :: *u8.[
        VK.Layer_Names.VALIDATION,
    ];

    DEBUG_UTILS_MESSENGER_CREATE_INFO := VK.Debug_Utils_Messenger_Create_Info_Ext.{
        message_severity  = .WARNING_EXT | .ERROR_EXT,
        message_type      = .GENERAL_EXT | .VALIDATION_EXT | .PERFORMANCE_EXT,
        pfn_user_callback = debug_utils_messenger_callback,
    };
}

create_timeline_semaphore :: (device: VK.Device) -> error: string, Timeline_Semaphore_Info {
    timeline_semaphore_info: Timeline_Semaphore_Info;

    semaphore_type_create_info :=  VK.Semaphore_Type_Create_Info.{
        semaphore_type = .TIMELINE,
        initial_value  = FRAMES_IN_FLIGHT_COUNT,
    };
    sempaphore_create_info := VK.Semaphore_Create_Info.{
        p_next = *semaphore_type_create_info,
    };

    result:, timeline_semaphore_info.semaphore = VK.create_semaphore(
        device,
        *sempaphore_create_info,
    );
    if result != .SUCCESS {
        return
            tprint("Failed to create timeline semaphore: %", result),
            timeline_semaphore_info;
    }

    timeline_semaphore_info.next_signal_value = semaphore_type_create_info.initial_value + 1;

    return "", timeline_semaphore_info;
}

create_depth_image :: (
    device:    VK.Device,
    allocator: VMA.Allocator,
    width:     u32,
    height:    u32,
) -> error: string, Image_Info {
    error, depth_image_info := create_image(
            device,
            allocator,
            format           = DEPTH_IMAGE_FORMAT,
            width            = width,
            height           = height,
            depth            = 1,
            tiling           = .OPTIMAL,
            usage            = .DEPTH_STENCIL_ATTACHMENT,
            allocation_flags = .DEDICATED_MEMORY,
    );

    return error, depth_image_info;
}

create_swapchain :: (
    physical_device:        VK.Physical_Device,
    surface:                VK.Surface_Khr,
    device:                 VK.Device,
    window:                 Window_Type,
    get_window_render_size: Window_Render_Size_Getter,
) -> error: string, Swapchain_Info {
    swapchain_info: Swapchain_Info;

    { // The swapchain
        result, surface_capabilities := VK.get_physical_device_surface_capabilities_khr(physical_device, surface);
        if result != .SUCCESS {
            return
                tprint("Failed to get surface capabilities: %", result),
                swapchain_info;
        }

        desired_image_count := ifx surface_capabilities.max_image_count > 0
            then clamp(2, surface_capabilities.min_image_count, surface_capabilities.max_image_count)
            else max(2, surface_capabilities.min_image_count);
        if desired_image_count < FRAMES_IN_FLIGHT_COUNT {
            return
                tprint(
                    "The number of swapchain images is less than the number of frames in flight (% vs %)",
                    desired_image_count,
                    FRAMES_IN_FLIGHT_COUNT,
                ),
                swapchain_info;
        }

        image_extent := ifx surface_capabilities.current_extent.width != U32_MAX {
            surface_capabilities.current_extent;
        } else {
            width, height := get_window_render_size(window);

            extent: VK.Extent_2D;
            extent.width = clamp(
                width,
                surface_capabilities.min_image_extent.width,
                surface_capabilities.max_image_extent.width,
            );
            extent.height = clamp(
                height,
                surface_capabilities.min_image_extent.height,
                surface_capabilities.max_image_extent.height,
            );

            extent;
        }

        swapchain_info.config = {
            surface            = surface,
            min_image_count    = cast(u32, desired_image_count),
            image_format       = SURFACE_FORMAT.format,
            image_color_space  = SURFACE_FORMAT.color_space,
            image_extent       = image_extent,
            image_array_layers = 1,
            image_usage        = .COLOR_ATTACHMENT,
            image_sharing_mode = .EXCLUSIVE,
            pre_transform      = surface_capabilities.current_transform,
            composite_alpha    = .OPAQUE_KHR,
            present_mode       = DEFAULT_PRESENT_MODE,
            clipped            = VK.TRUE,
        };

        result, swapchain_info.swapchain = VK.create_swapchain_khr(device, *swapchain_info.config);
        if result != .SUCCESS {
            return
                tprint("Failed to create swapchain: %", result),
                swapchain_info;
        }
    }

    { // Images
        result:, swapchain_info.images = VK.get_swapchain_images_khr(device, swapchain_info.swapchain);
        if result != .SUCCESS {
            return
                tprint("Failed to get swapchain images: %", result),
                swapchain_info;
        }
    }

    // Image views
    for image: swapchain_info.images {
        error, image_view := create_image_view(
            device,
            image,
            swapchain_info.config.image_format,
            .COLOR,
        );
        if error {
            return error, swapchain_info;
        }

        array_add(
            *swapchain_info.image_views,
            image_view,
        );
    }

    // Render complete semaphores
    for swapchain_info.images {
        semaphore_create_info: VK.Semaphore_Create_Info;

        result, semaphore := VK.create_semaphore(device, *semaphore_create_info);
        if result != .SUCCESS {
            return
                tprint("Failed to create semaphore for swapchain: %", result),
                swapchain_info;
        }

        array_add(
            *swapchain_info.render_complete_semaphores,
            semaphore,
        );
    }

    return "", swapchain_info;
}

destroy_swapchain :: (device: VK.Device, swapchain_info: *Swapchain_Info) {
    for semaphore: swapchain_info.render_complete_semaphores {
        VK.destroy_semaphore(device, semaphore);
    }
    array_free(swapchain_info.render_complete_semaphores);

    for image_view: swapchain_info.image_views {
        VK.destroy_image_view(device, image_view);
    }
    array_free(swapchain_info.image_views);

    array_free(swapchain_info.images);

    VK.destroy_swapchain_khr(device, swapchain_info.swapchain);

    swapchain_info.* = {};
}

create_allocator :: (
    instance: VK.Instance,
    physical_device: VK.Physical_Device,
    device: VK.Device,
) -> error: string, VMA.Allocator {
    allocator_create_info := VMA.Allocator_Create_Info.{
        flags              = .BUFFER_DEVICE_ADDRESS,
        physical_device    = physical_device,
        device             = device,
        instance           = instance,
        vulkan_api_version = VULKAN_API_VERSION,
    };

    result, allocator := VMA.create_allocator(*allocator_create_info);
    if result != .SUCCESS {
        return
            tprint("Failed to create VMA allocator: %", result),
            allocator;
    }

    return "", allocator;
}

create_device :: (physical_device: VK.Physical_Device, queues_to_create: []Queue_Info) -> error: string, VK.Device {
    { // Check for features support
        features_14: VK.Physical_Device_Vulkan_1_4_Features;
        features_13  := VK.Physical_Device_Vulkan_1_3_Features.{ p_next = *features_14 };
        features_12  := VK.Physical_Device_Vulkan_1_2_Features.{ p_next = *features_13 };
        features     := VK.Physical_Device_Features_2.{ p_next = *features_12 };
        VK.get_physical_device_features_2(physical_device, *features);

        if (
            !features_13.dynamic_rendering
            || !features_13.synchronization_2
            || !features_12.timeline_semaphore
            || !features_12.buffer_device_address
            || !features_12.descriptor_binding_sampled_image_update_after_bind
            || !features_12.descriptor_binding_partially_bound
            || !features_12.scalar_block_layout
            || !features_12.runtime_descriptor_array
            || !features.features.multi_draw_indirect
            || !features.features.draw_indirect_first_instance
            || !features.features.shader_int64
        ) {
            return
                "Some of the required device features are not supported",
                null;
        };
    }

    required_features_14: VK.Physical_Device_Vulkan_1_4_Features;
    required_features_13 := VK.Physical_Device_Vulkan_1_3_Features.{
        p_next            = *required_features_14,
        synchronization_2 = VK.TRUE,
        dynamic_rendering = VK.TRUE,
    };
    required_features_12 := VK.Physical_Device_Vulkan_1_2_Features.{
        p_next                                             = *required_features_13,
        timeline_semaphore                                 = VK.TRUE,
        buffer_device_address                              = VK.TRUE,
        descriptor_binding_sampled_image_update_after_bind = VK.TRUE,
        descriptor_binding_partially_bound                 = VK.TRUE,
        scalar_block_layout                                = VK.TRUE,
        runtime_descriptor_array                           = VK.TRUE,
    };
    required_features := VK.Physical_Device_Features_2.{
        p_next = *required_features_12,
        features = {
            multi_draw_indirect          = VK.TRUE,
            shader_int64                 = VK.TRUE,
            draw_indirect_first_instance = VK.TRUE,
        }
    };

    device_queue_create_infos: [..]VK.Device_Queue_Create_Info;
    device_queue_create_infos.allocator = temp;
    queue_priorities := float.[1];
    for queue_info: queues_to_create {
        array_add(
            *device_queue_create_infos,
            {
                queue_family_index = queue_info.family_index,
                queue_count        = 1,
                p_queue_priorities = queue_priorities.data,
            },
        );
    }

    extensions: [..]*u8;
    extensions.allocator = temp;
    for extension: DEVICE_EXTENSIONS {
        array_add(*extensions, extension);
    }

    device_create_info := VK.Device_Create_Info.{
        p_next                     = *required_features,
        queue_create_info_count    = cast(u32, device_queue_create_infos.count),
        p_queue_create_infos       = device_queue_create_infos.data,
        enabled_extension_count    = cast(u32, extensions.count),
        pp_enabled_extension_names = extensions.data,
    };

    result, device := VK.create_device(physical_device, *device_create_info);
    if result != .SUCCESS {
        return
            "Failed to create device",
            device;
    }

    return
        "",
        device;
}

find_graphics_queue_family_index :: (physical_device: VK.Physical_Device, surface: VK.Surface_Khr) -> error: string, u32 {
    found: bool;
    graphics_queue_family_index: u32;

    queue_family_properties_list := VK.get_physical_device_queue_family_properties_2(physical_device,, temp);

    for queue_family_properties: queue_family_properties_list {
        result, has_present_support := VK.get_physical_device_surface_support_khr(
            physical_device,
            cast(u32, it_index),
            surface,
        );
        if result != .SUCCESS {
            continue;
        }

        if (
            has_present_support
            && queue_family_properties.queue_family_properties.queue_flags & .GRAPHICS
        ) {
            found = true;
            graphics_queue_family_index = cast(u32, it_index);
            break;
        }
    }

    if !found {
        return
            "No suitable queue family",
            graphics_queue_family_index;
    }

    return
        "",
        graphics_queue_family_index;
}

find_physical_device :: (instance: VK.Instance, surface: VK.Surface_Khr) -> error: string, VK.Physical_Device {
    the_suitable_device: VK.Physical_Device;

    result, physical_devices := VK.enumerate_physical_devices(instance,, temp);
    if result != .SUCCESS {
        return
            tprint("Failed to enumerate physical devices: %", result),
            the_suitable_device;
    }

    for candidate: physical_devices {
        candidate_props := VK.get_physical_device_properties(candidate);

        supports_needed_surface_format: bool;
        {
            result, supported_formats := VK.get_physical_device_surface_formats_khr(candidate, surface,, temp);
            if result != .SUCCESS {
                continue;
            }

            for format: supported_formats {
                if (
                    format.format == SURFACE_FORMAT.format
                    && format.color_space == SURFACE_FORMAT.color_space
                ) {
                    supports_needed_surface_format = true;
                    break;
                }
            }
        }

        supports_default_present_mode: bool;
        {
            result, supported_present_modes := VK.get_physical_device_surface_present_modes_khr(candidate, surface,, temp);
            if result != .SUCCESS {
                continue;
            }

            for supported_present_mode: supported_present_modes {
                if supported_present_mode == DEFAULT_PRESENT_MODE {
                    supports_default_present_mode = true;
                    break;
                }
            }
        }

        if (
            candidate_props.device_type == .DISCRETE_GPU
            && candidate_props.api_version >= VULKAN_API_VERSION
            && supports_needed_surface_format
            && supports_default_present_mode
        ) {
            the_suitable_device = candidate;
            break;
        }
    }
    if !the_suitable_device {
        return
            tprint("No suitable GPUs"),
            the_suitable_device;
    }

    return
        "",
        the_suitable_device;
}

create_surface :: (
    instance: VK.Instance,
    window:   Window_Type,
    create_window_surface: Window_Surface_Creator,
) -> error: string, VK.Surface_Khr {
    surface := create_window_surface(window, instance);
    if !surface {
        return
            "Failed to create surface",
            surface;
    }

    return
        "",
        surface;
}

create_instance :: (get_additional_extensions: Additional_Instance_Extensions_Getter) -> error: string, VK.Instance {
    application_info := VK.Application_Info.{
        p_application_name = APPLICATION_NAME,
        api_version        = VULKAN_API_VERSION,
    };

    extensions: [..]*u8;
    extensions.allocator = temp;
    {
        #if DEBUG {
            for extension: DEBUG_INSTANCE_EXTENSIONS {
                array_add(*extensions, extension);
            }
        }

        additional_extensions := get_additional_extensions(,, temp);
        for extension: additional_extensions {
            array_add(*extensions, extension);
        };
    }

    layers: [..]*u8;
    layers.allocator = temp;
    {
        #if DEBUG {
            for layer: DEBUG_LAYERS {
                array_add(*layers, layer);
            }
        }
    }

    instance_create_info := VK.Instance_Create_Info.{
        p_application_info         = *application_info,
        enabled_layer_count        = cast(u32, layers.count),
        pp_enabled_layer_names     = layers.data,
        enabled_extension_count    = cast(u32, extensions.count),
        pp_enabled_extension_names = extensions.data,
    };
    #if DEBUG {
        instance_create_info.p_next = *DEBUG_UTILS_MESSENGER_CREATE_INFO;
    }

    result, instance := VK.create_instance(*instance_create_info);
    if result != .SUCCESS {
        return
            tprint("Failed to create instance: %", result),
            instance;
    }

    return
        "",
        instance;
}

create_image :: (
    device:           VK.Device,
    allocator:        VMA.Allocator,
    format:           VK.Format,
    width:            u32,
    height:           u32,
    depth:            u32,
    tiling:           VK.Image_Tiling,
    usage:            VK.Image_Usage_Flags,
    allocation_flags: VMA.Allocation_Create_Flags,
) -> error: string, Image_Info {
    image_info: Image_Info;

    image_create_info := VK.Image_Create_Info.{
        image_type = ._2D,
        format     = format,
        extent = {
            width  = width,
            height = height,
            depth  = depth,
        },
        mip_levels     = 1,
        array_layers   = 1,
        samples        = ._1,
        tiling         = tiling,
        usage          = usage,
        initial_layout = .UNDEFINED,
        sharing_mode   = .EXCLUSIVE,
    };

    allocation_create_info := VMA.Allocation_Create_Info.{
        flags = allocation_flags,
        usage = .AUTO,
    };

    result:, image_info.image, image_info.allocation = VMA.create_image(
        allocator,
        *image_create_info,
        *allocation_create_info,
    );
    if result != .SUCCESS {
        return
            tprint("Failed to create image: %", result),
            image_info;
    }

    error:, image_info.image_view = create_image_view(device, image_info.image, format, .DEPTH);
    if error {
        return error, image_info;
    }

    return "", image_info;
}

destroy_image :: (
    device: VK.Device,
    allocator: VMA.Allocator,
    image_info: *Image_Info,
) {
    VK.destroy_image_view(device, image_info.image_view);
    VMA.destroy_image(allocator, image_info.image, image_info.allocation);

    image_info.* = {};
}

create_image_view :: (
    device: VK.Device,
    image: VK.Image,
    format: VK.Format,
    aspect_mask: VK.Image_Aspect_Flags,
) -> error: string, VK.Image_View {
    image_view_create_info := VK.Image_View_Create_Info.{
        image     = image,
        view_type = ._2D,
        format    = format,
        subresource_range = {
            aspect_mask = aspect_mask,
            level_count = 1,
            layer_count = 1,
        },
    };

    result, image_view := VK.create_image_view(device, *image_view_create_info);
    if result != .SUCCESS {
        return
            tprint("Failed to create image view: %", result),
            image_view;
    }

    return "", image_view;
}

#if DEBUG {
    create_debug_utils_messenger :: (instance: VK.Instance) -> VK.Debug_Utils_Messenger_Ext {
        create_debug_utils_messenger_ext: VK.Pfn_Create_Debug_Utils_Messenger_Ext = VK.get_instance_proc_addr(
            instance,
            "vkCreateDebugUtilsMessengerEXT",
        );
        assert(create_debug_utils_messenger_ext != null);

        debug_utils_messenger: VK.Debug_Utils_Messenger_Ext;

        result := create_debug_utils_messenger_ext(instance, *DEBUG_UTILS_MESSENGER_CREATE_INFO, null, *debug_utils_messenger);
        assert(result == .SUCCESS);

        return debug_utils_messenger;
    }

    destroy_debug_utils_messenger :: (
        instance:  VK.Instance,
        messenger: VK.Debug_Utils_Messenger_Ext,
    ) {
        destroy_debug_utils_messenger_ext: VK.Pfn_Destroy_Debug_Utils_Messenger_Ext = VK.get_instance_proc_addr(
            instance,
            "vkDestroyDebugUtilsMessengerEXT",
        );
        assert(destroy_debug_utils_messenger_ext != null);

        destroy_debug_utils_messenger_ext(instance, messenger, null);
    }

    debug_utils_messenger_callback: VK.Pfn_Debug_Utils_Messenger_Callback_Ext : (
        message_severity: VK.Debug_Utils_Message_Severity_Flags_Ext,
        message_types:    VK.Debug_Utils_Message_Type_Flags_Ext,
        p_callback_data:  *VK.Debug_Utils_Messenger_Callback_Data_Ext,
        p_user_data:      *void,
    ) -> VK.Bool #c_call {
        if message_severity >= .WARNING_EXT {
            push_context {
                print(
                    "VK Validation (% - %): %\n",
                    message_severity,
                    message_types,
                    to_string(p_callback_data.p_message),
                );
            }
        }

        return VK.FALSE;
    }
}

#import "Basic";
#import "Math";
VK  :: #import "Jai_Vulkan";
VMA :: #import "Vulkan_Memory_Allocator"(DEBUG = DEBUG);

#if DEBUG {
    #import "Print_Vars";
}
