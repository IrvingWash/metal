#import "Compiler";

Gltf :: #import,file "module.jai";

#run {
    set_build_options_dc({ do_output = false });

    Gltf.parse_gltf("test.gltf", .[]);
    Gltf.parse_glb(.[]);
    Gltf.load_gltf("test.gltf");
    Gltf.load_glb("test.glb");
}
