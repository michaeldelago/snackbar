# snackbar

## Usage

1. Build with `earthly` or `make`

- `make build`
- `earthly +build`

## Installation

1. Move executable from `build/snackbar` to `~/.config/sway/snackbar`

    `$ mv ./build/snackbar ~/.config/sway/snackbar`

2. Configure sway

    `~/.config/sway/config`:

    ```
    bar {
        position top
        status_command while ~/.config/sway/snackbar; do sleep 1; done

        colors {
            statusline #ffffff
            background #323232
            inactive_workspace #32323200 #32323200 #5c5c5c
        }
    }
    ```

3. Reload sway (default $mod+shift+c)

## Questions

### What does it look like

```
avail: 26.9G used: 10.9% | /: 4% | 🔈 85% | bat0 77.4% 🔋⚡ | bat1 16.5% 🔋⬇️ | Tue, Jul 12 2022 4:40 pm 
```

For context, I'm using a thinkpad t480 with 2 batteries.

### Why write your own bar when there's so many available?

It felt like it'd be fun to do, and I wanted a somewhat practical project for common lisp.

There's a previous iteration of this project, written in python

### Do you accept contributions to this project?

Probably not

### Will this work with x?

I don't know

### Can you add feature y?

Probably not
