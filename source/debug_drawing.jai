Debug_Drawing :: struct {
    game: *Game;
}

init_debug_drawing :: (game: *Game) {
    debug_drawing.game = game;
}

deinit_debug_drawing :: () {};

draw_model_bounds :: (
    model:     Renderer.Model_Accessor,
    transform: Matrix4,
    color:     Vector4 = { 0, 1, 0, 1 },
) {
    transformed_aabb := transform_aabb(model.aabb, transform);

    draw_box(
        transformed_aabb.min,
        transformed_aabb.max,
        Matrix4_Identity,
        color,
    );
}



#scope_file

debug_drawing: Debug_Drawing;

draw_box :: (min: Vector3, max: Vector3, transform: Matrix4, color: Vector4) {
    corners: [8]Vector3;
    corners[0] = Vector3.{ min.x, min.y, min.z };
    corners[1] = Vector3.{ max.x, min.y, min.z };
    corners[2] = Vector3.{ max.x, max.y, min.z };
    corners[3] = Vector3.{ min.x, max.y, min.z };
    corners[4] = Vector3.{ min.x, min.y, max.z };
    corners[5] = Vector3.{ max.x, min.y, max.z };
    corners[6] = Vector3.{ max.x, max.y, max.z };
    corners[7] = Vector3.{ min.x, max.y, max.z };

    if transform != Matrix4_Identity {
        for *corner: corners {
            corner.* *= (transform * make_vector4(corner, 1)).xyz;
        }
    }

    Renderer.draw_line(*debug_drawing.game.renderer, { corners[0], corners[1], color });
    Renderer.draw_line(*debug_drawing.game.renderer, { corners[1], corners[2], color });
    Renderer.draw_line(*debug_drawing.game.renderer, { corners[2], corners[3], color });
    Renderer.draw_line(*debug_drawing.game.renderer, { corners[3], corners[0], color });
    Renderer.draw_line(*debug_drawing.game.renderer, { corners[4], corners[5], color });
    Renderer.draw_line(*debug_drawing.game.renderer, { corners[5], corners[6], color });
    Renderer.draw_line(*debug_drawing.game.renderer, { corners[6], corners[7], color });
    Renderer.draw_line(*debug_drawing.game.renderer, { corners[7], corners[4], color });
    Renderer.draw_line(*debug_drawing.game.renderer, { corners[0], corners[4], color });
    Renderer.draw_line(*debug_drawing.game.renderer, { corners[1], corners[5], color });
    Renderer.draw_line(*debug_drawing.game.renderer, { corners[2], corners[6], color });
    Renderer.draw_line(*debug_drawing.game.renderer, { corners[3], corners[7], color });
}

Renderer :: #import "Renderer";
