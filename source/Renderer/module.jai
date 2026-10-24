#module_parameters()(Window_Type: Type, APPLICATION_NAME: string, DEBUG: bool = false);

Additional_Instance_Extensions_Getter :: #type () -> [..]*u8;
Window_Pixel_Size_Getter              :: #type (window: Window_Type) -> width: u32, height: u32;
Window_Surface_Creator :: #type (
    window: Window_Type,
    instance: VK.Instance,
    allocator: *VK.Allocation_Callbacks = null,
) -> VK.Surface_Khr;

Renderer :: struct {
    window:                Window_Type;
    get_window_pixel_size: Window_Pixel_Size_Getter;

    instance:            VK.Instance;
    surface:             VK.Surface_Khr;
    physical_device:     VK.Physical_Device;
    graphics_queue_info: Queue_Info;
    device:              VK.Device;
    allocator:           VMA.Allocator;

    #if DEBUG {
        debug_utils_messenger: VK.Debug_Utils_Messenger_Ext;
    }
}

Queue_Info :: struct {
    family_index: u32;
    queue:        VK.Queue;
}

init :: (
    window:                                Window_Type,
    additional_instance_extensions_getter: Additional_Instance_Extensions_Getter,
    window_pixel_size_getter:              Window_Pixel_Size_Getter,
    create_window_surface:                 Window_Surface_Creator,
) -> error: string, Renderer {
    renderer: Renderer;

    renderer.window = window;
    renderer.get_window_pixel_size = window_pixel_size_getter;

    error:, renderer.instance = create_instance(additional_instance_extensions_getter);
    if error {
        return
            error,
            renderer;
    }

    #if DEBUG {
        renderer.debug_utils_messenger = create_debug_utils_messenger(renderer.instance);
    }

    error, renderer.physical_device = find_physical_device(renderer.instance);
    if error {
        return
            error,
            renderer;
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

    return
        "",
        renderer;
}

deinit :: (renderer: *Renderer) {
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

DEVICE_EXTENSIONS :: *u8.[
    VK.Extension_Names.KHR_SWAPCHAIN,
];

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

find_physical_device :: (instance: VK.Instance) -> error: string, VK.Physical_Device {
    the_suitable_device: VK.Physical_Device;

    result, physical_devices := VK.enumerate_physical_devices(instance,, temp);
    if result != .SUCCESS {
        return
            tprint("Failed to enumerate physical devices: %", result),
            the_suitable_device;
    }

    for candidate: physical_devices {
        candidate_props := VK.get_physical_device_properties(candidate);

        if (
            candidate_props.device_type == .DISCRETE_GPU
            && candidate_props.api_version >= VULKAN_API_VERSION
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
    window: Window_Type,
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
VK  :: #import "Jai_Vulkan";
VMA :: #import "Vulkan_Memory_Allocator"(DEBUG = DEBUG);

#if DEBUG {
    #import "Print_Vars";
}
