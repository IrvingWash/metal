#scope_file

#import "Basic";
#import "Compiler";
#import "BuildCpp";
#import "File";

// ./modules/Vulkan_Memory_Allocator/Vulkan-Headers/include
VULKAN_INCLUDE_PATH :: #run tprint("%Vulkan-Headers/include", #filepath);

// ./modules/Vulkan_Memory_Allocator/VulkanMemoryAllocator/include/vk_mem_alloc.h
SRC_PATH :: #run tprint("%VulkanMemoryAllocator/include/vk_mem_alloc.h", #filepath);

#run {
    set_build_options_dc({ do_output = false });

    error := build_vma();
    if error {
        log_error("Failed to build VMA: %", error);
        compiler_set_workspace_status(.FAILED);
        return;
    }
}

build_vma :: () -> error: string {
    optimized_relative_path := tprint("%/libvma", OS);
    debug_relative_path := tprint("%/libvma_debug", OS);

    #if OS == {
        case .LINUX;
            ok := make_directiory_for_binaries();
            if !ok return "Failed to create build directory";

            extras: [..]string;
            extras.allocator = temp;
            array_add(
                *extras,
                "-I",
                VULKAN_INCLUDE_PATH,
                "-DVMA_IMPLEMENTATION",
                "-x",
                "c++",
                "-std=c++17",
                "-fno-exceptions",
                "-fno-rtti",
            );

            { // Debug
                ok := build_cpp_static_lib(
                    debug_relative_path,
                    SRC_PATH,
                    extra = extras,
                    debug = true,
                    working_directory = #filepath,
                );
                if !ok {
                    return "Failed to build static library (debug)";
                }
            }

            { // Optimized
                array_add(*extras, "-DNDEBUG");

                ok := build_cpp_static_lib(
                    optimized_relative_path,
                    SRC_PATH,
                    extra = extras,
                    debug = false,
                    working_directory = #filepath,
                );
                if !ok {
                    return "Failed to build static library (optimized)";
                }
            }
        case .WINDOWS;
            ok := make_directiory_for_binaries();
            if !ok return "Failed to create build directory";

            extras: [..]string;
            extras.allocator = temp;
            array_add(
                *extras,
                "/I",
                VULKAN_INCLUDE_PATH,
                "/DVMA_IMPLEMENTATION",
                "/DVMA_CALL_PRE=__declspec(dllexport)",
                "/TP",
            );

            { // Debug
                ok = build_cpp_static_lib(
                    debug_relative_path,
                    SRC_PATH,
                    extra = extras,
                    debug = true,
                    working_directory = #filepath,
                );
                if !ok {
                    return "Failed to build static library (debug)";
                }
            }

            { // Optimized
                array_add(*extras, "/DNDEBUG");

                ok := build_cpp_static_lib(
                    optimized_relative_path,
                    SRC_PATH,
                    extra = extras,
                    debug = false,
                    working_directory = #filepath,
                );
                if !ok {
                    return "Failed to build static library (optimized)";
                }
            }
        case;
            assert(false, "Unsupported OS: '%'", OS);
    }

    return "";
}

make_directiory_for_binaries :: () -> bool {
    // ./modules/Vulkan_Memory_Allocator/<OS>
    return make_directory_if_it_does_not_exist(tprint("%%", #filepath, OS));
}
