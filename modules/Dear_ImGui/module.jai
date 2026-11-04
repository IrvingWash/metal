ImVec2      :: Vector2;
ImVec4      :: Vector4;
ImColor     :: Vector4;

ImVector :: struct (T: Type) {
    Size: s32;
    Capacity: s32;
    Data: *T;
}

ImDrawCallback :: #type (parent_list: *ImDrawList, cmd: *ImDrawCmd) #c_call;

#if OS == .LINUX {
    libimgui :: #library,no_dll "./LINUX/libimgui";
    #load "./MANUAL_LINUX.jai";
}



#scope_file

#import "Math";
