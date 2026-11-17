#if OS == .LINUX {
    libminiaudio :: #library,no_dll "./LINUX/libminiaudio";
    #library,system,link_always "m";
    #library,system,link_always "pthread";
    #load "GENERATED_LINUX.jai";
    #import "POSIX";
} else {
    #assert false "Unsupported OS";
}

#import "Math";
