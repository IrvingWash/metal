## How to start working

1. Clone this repo with the `--recurse-submodules` flag:
```bash
git clone --recurse-submodules <repo-url>
```
2. Install tools by running
```bash
jai ./install_tools.jai
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
