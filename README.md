# metal

This project contains all the rendering/math and OS layer code that I've written for a game I'm working on.
This is a Vulkan 3D renderer with:
- PBR support (normal, metallic, roughnes, ao maps, material system, etc)
- GLTF loading
- Indirect drawing and instancing
- Frustum culling
- Various light and shadow map types
- Bindles descriptors
- And a lot more!

The renderer has a nice API. Everything was written from scratch, except:
- Input/Windowing (handled by SDL3)
- Level editor (handled by ImGui)

The most interesting code lives in `modules`:
- `Renderer` - all the rendering is done here
- `More_Math` - additional math procedures on top of Jai's built in math module
- `Gltf` - GLTF loading

## Very quick showcase with bad quality (thank you OBS + Wayland)

(Click for video)<br>
[![Showcase](https://img.youtube.com/vi/HzTERWgZcb4/0.jpg)](https://www.youtube.com/watch?v=HzTERWgZcb4)

The showcase contains sample models from Khronos' gltf assets.

## Initializing the project

1. Clone this repo

```bash
git clone <repo-url>
```

2. Init the project (install dependencies, build binaries, install git hooks, etc)
This "script" will clone a couple of repos on which the project depends (VMA, VulkanHeaders, Shaderc, etc) and build the binaries. It will take time.

```bash
jai ./init.jai
```

## Building

To build and run a debug version:

```bash
jai ./build.jai - --very-debug -developer +Autorun
```

There's help
```bash
jai ./build.jai - --help
```

The build artefacts are placed into `./bin/<OPTIMIZATION_TYPE>` directory

## Structure

`source`           - The "game". It is a high-level app, I didn't think a lot on the code here, because it's just a demo.

`modules\Renderer`  - the renderer. Has a very small api:
- `init`
- `deinit`
- `start_drawing`
- `finish_drawing`
- `draw_model`
- `draw_line`
- `draw_xxx_light`
- Texture and geometry uploaders
- A couple of unnecessary setters (`set_directional_light`, etc)
`start_drawing` resets the per-frame state
`draw_xxx` adds models, lights, etc into lists to be drawn this frame
`finish_drawing` executes this frame's command buffer and presents.

Currently there are 4 "passes":
- Model Pass
- Shadow Pass
- Tonemap Pass
- Primitive Pass

Flow:
1. Model Pass records indirect commands which can later be used by other passes.
1. Shadow Pass draws all the geometry it needs and creates shadow maps for each light which needs shadows
1. Model Pass draws all the geometry and samples shadow maps
1. Optionally, Primitive Pass draws lines
1. Tonemap Pass does it's tonemapping job (hdr -> normalized and very subtle tonemapping)

`modules\Gltf`      - Gltf loader written from scratch. Can load both `.gltf` and `.glb` files. Almost doesn't copy anything, so is quite fast and efficient. I didn't test it properly, but it should cover the whole GLTF2 spec (no extensions, though).
`modules\More_Math` - Math functions which are absent from Jai's standard module - frustums, raycasting, bounding boxes, etc.
`modules\Input`     - "OS layer" for input. Currently uses SDL, but completetly hides it. In the future will be rewritten to use native APIs.
`modules\Option`    - Rust-like `Option(T)` type. Used only when absolutely needed. Jai zero-initializes everything, so sometimes you either have this, or a sentinel value like `-1`, which is easy to forget about.

`modules\Jai_Vulkan`    - hand written bindings for Vulkan.
`modules\Glsl_Compiler` - a metaprogram which uses Shaderc to precompile `.glsl` shaders. Nothing fancy.
`modules\Dear_ImGui`    - hand written bindings for imgui. Used only in the demo

`modules/vendored` - External dependencies
