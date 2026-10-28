Compiler :: #type *Compiler_T;

initialize :: () -> Compiler #foreign libshaderc "shaderc_compiler_initialize";

release :: (compiler: Compiler) -> void #foreign libshaderc "shaderc_compiler_initialize";



#scope_file

Compiler_T :: struct {};

#if OS == {
    case .LINUX;
        libshaderc :: #library,no_static_library "./LINUX/libshaderc_shared";
    case;
        #assert false, "Unsupported OS";
}
