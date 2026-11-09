DEPENDENCIES :: Dependency.[
    {
        name    = "SDL",
        git_url = "https://github.com/libsdl-org/SDL.git",
        pin     = "release-3.4.20",
    },
    {
        name    = "Jaison",
        git_url = "https://github.com/rluba/jaison.git",
        pin     = "master",
    },
    {
        name    = "Vulkan-Headers",
        git_url = "https://github.com/KhronosGroup/vulkan-headers.git",
        pin     = "vulkan-sdk-1.4.363.0",
    },
    {
        name    = "VulkanMemoryAllocator",
        git_url = "https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator.git",
        pin     = "v3.5.0",
    },
    {
        name    = "imgui",
        git_url = "https://github.com/ocornut/imgui.git",
        pin     = "v1.93.0",
    },
    {
        name        = "shaderc",
        git_url     = "https://github.com/google/shaderc.git",
        pin         = "v2026.4",
        on_complete = shaderc_on_complete,
    },
    {
        name = "ImGuizmo",
        git_url = "https://github.com/CedricGuillemet/ImGuizmo.git",
        pin = "1.10",
    },
];

shaderc_on_complete :: () -> ok: bool {
    shaderc_path := path_join(VENDORED_PATH, "shaderc",, temp);

    result := run_command(
        "python3",
        path_join(shaderc_path, "utils", "git-sync-deps",, temp),
        working_directory = shaderc_path,
    );

    return result.exit_code != 0;
}
