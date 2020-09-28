{ config, lib, pkgs, ... }: {
  imports = [
    ./games.nix
    ./programs/firefox
    ./programs/kitty.nix
    ./packages
    ./services/gammastep.nix
    ./services/i3sway.nix
    ./services/mpd.nix
    ./wayland
    ./xorg
  ];
}
