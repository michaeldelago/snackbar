# snackbar

## Usage

1. Build with `earthly`, `guix`, or `make`

- `earthly +build`
- `make build`
- `guix package -f guix.scm`

## Installation

If using `guix`:

1. Install package

    ```
    $ guix install snackbar
    ```

If using `guix` and artifacts from most recent CI run:

1. Authorize the signing key of the build server

    ```
    $ sudo guix archive --authorize < etc/guix/signing-key.pub
    ```

1. Install downloaded nar file

    ```
    $ guix archive --import < home/runner/work/snackbar/snackbar/snackbar.nar
    ```

Else:

1. Move executable from `_build/snackbar` to `~/bin/snackbar` with `make install`

2. Configure sway

    `~/.config/sway/config`:

    ```
    bar {
        position top
        status_command while ~/bin/snackbar; do sleep 1; done

        colors {
            statusline #ffffff
            background #323232
            inactive_workspace #32323200 #32323200 #5c5c5c
        }
    }
    ```

3. Reload sway (default $mod+shift+c)


## Configuration

Configuration is pretty basic; I add features as they become useful to me. 

You can put a config file in these locations:

1. A location specified by the env variable $SNACKBAR_CONFIG
2. $XDG_CONFIG_HOME/snackbar/config (defaults to ~/.config/snackbar/config)
3. $XDG_CONFIG_HOME/sway/snackbar (defaults to ~/.config/sway/snackbar)
4. $XDG_CONFIG_HOME/i3/snackbar (defaults to ~/.config/i3/snackbar)
5. /etc/snackbar/config

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
