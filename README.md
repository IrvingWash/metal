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

## Showcase

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

`source`           - The game
`modules`          - Subprojects and bindings
`modules/vendored` - External dependencies
