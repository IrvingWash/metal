#if OS == .LINUX {
    libimgui :: #library,no_dll "./LINUX/libimgui";
    #load "unix.jai";
} else #if OS == .MACOS {
    libimgui :: #library,no_dll "./MACOS/libimgui";
    #load "unix.jai";
} else #if OS == .WINDOWS {
    libimgui :: #library,no_dll "./WINDOWS/libimgui";
    #load "windows.jai";
}
