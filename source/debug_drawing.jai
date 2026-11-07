Debug_Drawing :: struct {
    game: *Game;
}

init_debug_drawing :: (game: *Game) {
    debug_drawing.game = game;
}

deinit_debug_drawing :: () {};

draw_model_bounds :: (
    model_handle: Model_Handle,
    transform: Matrix4,
    color: Vector4 = { 0, 1, 0, 1 },
) {
    model := asset_manager_get_model(debug_drawing.game.asset_manager, model_handle);

    draw_box(model.min, model.max, transform, color);
}

draw_model_mesh_bounds :: (
    model_handle: Model_Handle,
    transform: Matrix4,
    color: Vector4 = { 0, 1, 0, 1 },
) {
    model := asset_manager_get_model(debug_drawing.game.asset_manager, model_handle);

    draw_node :: (nodes: []Renderer.Node, node: Renderer.Node, parent_transform: Matrix4, color: Vector4) {
        world := parent_transform * node.local_transform;

        for mesh: node.meshes {
            draw_box(mesh.min, mesh.max, world, color);
        }

        for child: node.children_ids {
            draw_node(nodes, nodes[child], world, color);
        }
    }

   for node: model.nodes {
        if node.parent_index.kind != .NONE {
            continue;
        }

        draw_node(model.nodes, node, transform, color);
    }
}

draw_box :: (min: Vector3, max: Vector3, transform: Matrix4, color: Vector4) {
    corners: [8]Vector3;
    corners[0] = (transform * Vector4.{ min.x, min.y, min.z, 1 }).xyz;
    corners[1] = (transform * Vector4.{ max.x, min.y, min.z, 1 }).xyz;
    corners[2] = (transform * Vector4.{ max.x, max.y, min.z, 1 }).xyz;
    corners[3] = (transform * Vector4.{ min.x, max.y, min.z, 1 }).xyz;
    corners[4] = (transform * Vector4.{ min.x, min.y, max.z, 1 }).xyz;
    corners[5] = (transform * Vector4.{ max.x, min.y, max.z, 1 }).xyz;
    corners[6] = (transform * Vector4.{ max.x, max.y, max.z, 1 }).xyz;
    corners[7] = (transform * Vector4.{ min.x, max.y, max.z, 1 }).xyz;

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



#scope_file

debug_drawing: Debug_Drawing;

Renderer :: #import "Renderer";
