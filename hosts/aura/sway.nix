{ config, lib, pkgs, ... }:
let
  waybarSettings = import ../../modules/pc/sway/waybar.nix;
  myWaybar = pkgs.waybar.override {
    pulseSupport = true;
    traySupport = true;
  };
in {
  home-manager.users.bryn = {
    wayland.windowManager.sway.config = {
      input."type:touchpad" = {
        natural_scroll = "enabled";
        tap = "enabled";
      };
      output.eDP-1.background = "/etc/nixos/assets/beach-blurred.jpg fill";
    };
    wayland.windowManager.sway.extraConfig = ''
      exec_always ${pkgs.batsignal}/bin/batsignal
    '';
    programs.waybar = {
      settings = [waybarSettings];
    };
  };
}

