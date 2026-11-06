## How to start working

1. Clone this repo

```bash
git clone <repo-url>
```

2. Init the project (install dependencies, build binaries, install git hooks, etc)

```bash
jai ./init.jai
```

## Building

To build and run a debug version:

```bash
jai ./build.jai - --very-debug +Autorun
```

There's help
```bash
jai ./build.jai - --help
```

The build artefacts are placed into `./bin/<OPTIMIZATION_TYPE>` directory

## Structure

`source`           - The game
`modules`          - Sub projects
`modules/vendored` - External modules
