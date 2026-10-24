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

    instance: VK.Instance;
    surface:  VK.Surface_Khr;

    #if DEBUG {
        debug_utils_messenger: VK.Debug_Utils_Messenger_Ext;
    }
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
        return error, renderer;
    }

    #if DEBUG {
        renderer.debug_utils_messenger = create_debug_utils_messenger(renderer.instance);
    }

    error, renderer.surface = create_surface(renderer.instance, renderer.window, create_window_surface);
    if error {
        return error, renderer;
    }

    return "", renderer;
}

deinit :: (renderer: *Renderer) {
    VK.destroy_surface_khr(renderer.instance, renderer.surface);

    #if DEBUG {
        destroy_debug_utils_messenger(renderer.instance, renderer.debug_utils_messenger);
    }

    VK.destroy_instance(renderer.instance);

    renderer.* = {};
}



#scope_file

VULKAN_API_VERSION :: #run VK.make_version(1, 4, 350);

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

create_surface :: (
    instance: VK.Instance,
    window: Window_Type,
    create_window_surface: Window_Surface_Creator,
) -> error: string, VK.Surface_Khr {
    surface := create_window_surface(window, instance);
    if !surface {
        return "Failed to create surface", surface;
    }

    return "", surface;
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

    return "",instance;
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
