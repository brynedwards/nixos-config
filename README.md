# NixOS Config

This repo contains configuration for three computers:

1. Two PCs
   1. Desktop (carbide)
   2. laptop (aura)
2. One Server (nuc)

The config uses nix flakes and expects a flake-enabled nix i.e. `nix-shell -p nixFlakes`.

## Shortcuts

`.in` is an [env file](https://github.com/zpm-zsh/autoenv) that provides
shortcuts for some commands I find useful:

### `check`

Runs `nix flake check`, which checks that the config doesn't have errors. See
[here](https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake-check.html)
for more details.

### `rebuild`

Runs `(sudo) nixos-rebuild switch/test --impure` to test the current config.

`--impure` is not always necessary; I need it to [use my SSH key with
`agenix`](https://github.com/brynedwards/nixos-config/blob/a0a6169215f157ed01317fe4966868c042729b49/modules/pc/default.nix#L205).

### `update`

The same as `rebuild` but includes the `--recreate-lock-file` option which
updates the flake inputs, thus updating the package repositories. This would
be the same as running `nix flake update` before `rebuild`.

### `save`

This shortcut does two things. The first is run `sudo nixos-rebuild
switch --impure` which just sets NixOS to use the updated configuration
on startup. The second line does a few things: first, using [command
substitution](https://bash.cyberciti.biz/guide/Command_substitution), we use
`nix flake metadata --json` to print the flake metadata in JSON, then use
`jq` to grab the commit hash of the nixpkgs input in your flake. We pass
this hash to `nix registry add`, which will set the nixpkgs shortcut to
the same commit hash as your flake. What this does in effect is make it so
that any use of `nix` commands such as e.g. `nix shell nixpkgs#<package>`
will use the same nixpkgs version as your system, so those package versions
will be from the same flake as your system, and `nix` commands won't check
for new nixpkgs versions every time you run them.

Photos used as wallpaper:

1. https://pixabay.com/photos/beach-sea-island-summer-vacations-6514331/
2. https://pixabay.com/photos/waterfalls-landscape-trees-forest-1417102/
