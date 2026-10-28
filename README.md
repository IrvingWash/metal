## How to start working

1. Clone this repo with the `--recurse-submodules` flag:

```bash
git clone --recurse-submodules <repo-url>
```

2. Install tools by running

```bash
jai ./install_tools.jai
```

3. Build and generate modules for the first time

```bash
jai ./build.jai - --very-debug --generate-modules
```

Currently the "tools" are only a pre-commit hook which:

- Builds the program every on every commit
- Checks for "@ no_commit" (there should not be a space between "@" and "n") occurances in current diff

## Building

To build and run a debug version:

```bash
jai ./build.jai - --very-debug +Autorun
```

To check other options:

```bash
jai ./build.jai - --help
```

The build artefacts are placed into `./bin/<OPTIMIZATION_TYPE>` directory

## Structure

`source` - The game and our own modules
`modules` - External dependencies and bindings
`test_gltf.jai` - Tests for `source/Gltf`
