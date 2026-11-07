Debug_Drawing :: struct {
    renderer: *Renderer.Renderer;
}

init_debug_drawing :: (renderer: *Renderer.Renderer) {
    debug_drawing.renderer = renderer;
}

deinit_debug_drawing :: () {};

draw_model_bounds :: (
    model:     Renderer.Model_Accessor,
    transform: Matrix4,
    color:     Vector4 = DEFAULT_LINE_COLOR,
) {
    transformed_aabb := transform_aabb(model.aabb, transform);

    draw_box(
        transformed_aabb.min,
        transformed_aabb.max,
        Matrix4_Identity,
        color,
    );
}

draw_line :: (a: Vector3, b: Vector3, color: Vector4 = DEFAULT_LINE_COLOR) {
    Renderer.draw_line(debug_drawing.renderer, { a, b, color });
}

draw_circle :: (
    center:        Vector3,
    axis_u:        Vector3,
    axis_v:        Vector3,
    radius:        float,
    segment_count: u32,
    color:         Vector4 = DEFAULT_LINE_COLOR,
) {
    // https://siegelord.net/circle_draw

    assert(segment_count >= 3, "Insufficient segments: %", segment_count);

    theta := TAU / cast(float, segment_count);

    tangential_factor := tan(theta);
    radial_factor     := cos(theta);

    x: float = radius;
    y: float = 0;

    first    := center + axis_u * x + axis_v * y;
    previous := first;

    for 1 .. segment_count - 1 {
        tx := -y;
        ty :=  x;
        x += tx * tangential_factor;
        y += ty * tangential_factor;

        x *= radial_factor;
        y *= radial_factor;

        point := center + axis_u * x + axis_v * y;

        Renderer.draw_line(
            debug_drawing.renderer,
            .{
                a = previous,
                b = point,
                color = color,
            },
        );

        previous = point;
    }

    // Close the circle
    Renderer.draw_line(
        debug_drawing.renderer,
        .{
            a = previous,
            b = first,
            color = color,
        },
    );
}

draw_sphere :: (
    center:        Vector3,
    radius:        float,
    color:         Vector4 = DEFAULT_LINE_COLOR,
    segment_count: u32     = 32,
) {
    draw_circle(center, { 1, 0, 0 }, { 0, 1, 0 }, radius, segment_count, color);
    draw_circle(center, { 0, 1, 0 }, { 0, 0, 1 }, radius, segment_count, color);
    draw_circle(center, { 0, 0, 1 }, { 1, 0, 0 }, radius, segment_count, color);
}

draw_box :: (
    min:       Vector3,
    max:       Vector3,
    transform: Matrix4,
    color:     Vector4 = DEFAULT_LINE_COLOR,
) {
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

    Renderer.draw_line(debug_drawing.renderer, { corners[0], corners[1], color });
    Renderer.draw_line(debug_drawing.renderer, { corners[1], corners[2], color });
    Renderer.draw_line(debug_drawing.renderer, { corners[2], corners[3], color });
    Renderer.draw_line(debug_drawing.renderer, { corners[3], corners[0], color });
    Renderer.draw_line(debug_drawing.renderer, { corners[4], corners[5], color });
    Renderer.draw_line(debug_drawing.renderer, { corners[5], corners[6], color });
    Renderer.draw_line(debug_drawing.renderer, { corners[6], corners[7], color });
    Renderer.draw_line(debug_drawing.renderer, { corners[7], corners[4], color });
    Renderer.draw_line(debug_drawing.renderer, { corners[0], corners[4], color });
    Renderer.draw_line(debug_drawing.renderer, { corners[1], corners[5], color });
    Renderer.draw_line(debug_drawing.renderer, { corners[2], corners[6], color });
    Renderer.draw_line(debug_drawing.renderer, { corners[3], corners[7], color });
}



#scope_file

DEFAULT_LINE_COLOR :: Vector4.{ 0, 1, 0, 1 };

debug_drawing: Debug_Drawing;

Renderer :: #import "Renderer";
