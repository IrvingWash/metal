Spot_Light :: struct {
    #as using base: Entity;

    params: Renderer.Spot_Light_Params;

    model_path = "../../Models/cube.glb";

    position = { -1.170, 1.023, 4.206 };

    params.direction = { -0.6, -1, 0 };
    params.intensity = 5;
    params.color = { 1, 1, 1 };
    params.range = 10;
    params.outer_cutoff_half_angle = 1;
    params.inner_cutoff_half_angle = 0.4;

    flags = .INVISIBLE;
}



#scope_file

Renderer :: #import "Renderer";
