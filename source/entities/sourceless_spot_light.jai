Sourceless_Spot_Light :: struct {
    #as using base: Entity;

    name = "Sourceless Spot Light";

    params: Renderer.Spot_Light_Params;

    flags = .INVISIBLE;
}



#scope_file

Renderer :: #import "Renderer";
