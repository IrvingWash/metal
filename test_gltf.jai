#import "Compiler";
#import "Basic";

Gltf :: #import,dir "source/Gltf";

#run {
    set_build_options_dc({ do_output = false });
    options := get_build_options();

    Gltf.parse_gltf("test.gltf", .[]);
    Gltf.parse_glb(.[]);
    Gltf.load_gltf("test.gltf");
    Gltf.load_glb("test.glb");
}
