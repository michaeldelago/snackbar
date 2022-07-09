# Statusbar

## Usage

1. Build with `earthly` or `make`

- `make build`
- `earthly +build`

## Installation

1. Move executable from `build/statusbar` to `~/.config/sway/statusbar`

`$ mv ./build/statusbar ~/.config/sway/statusbar`

2. Configure sway

    `~/.config/sway/config`:

    ```
    bar {
        position top
        status_command while ~/.config/sway/statusbar; do sleep 1; done

        colors {
            statusline #ffffff
            background #323232
            inactive_workspace #32323200 #32323200 #5c5c5c
        }
    }
    ```

3. Reload sway (default $mod+shift+c)

## Questions

### Why write your own bar when there's so many available?

It felt like it'd be fun to do, and I wanted a practical project for common lisp.

### Do you accept contributions to this project?

Probably not

### Will this work with x?

I don't know

### Can you add feature y?

Probably not