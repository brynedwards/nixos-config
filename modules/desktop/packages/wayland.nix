{ config, lib, pkgs, ... }: {
  bryn.hm.home.packages = with pkgs; [
    clipman
    glpaper
    pass-wayland
    swayidle
    swaylock-effects
    sway-contrib.grimshot
    sway-contrib.inactive-windows-transparency
    wl-clipboard
    ydotool
  ];
}
