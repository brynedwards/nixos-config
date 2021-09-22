{ config, lib, pkgs, ... }:
let waybarSettings = import ../../modules/pc/sway/waybar.nix;
in {
  home-manager.users.bryn = {
    wayland.windowManager.sway = {
      config.output = {
        DP-1 = {
          position = "0 0";
          scale = "2";
          background = "/etc/nixos/assets/beach-blurred.jpg fit";
        };
        DP-2 = {
          position = "1920 0";
          scale = "1.5";
          background = "/etc/nixos/assets/waterfalls-blurred.jpg fit";
        };
      };
    };

    programs.waybar.settings = [
      (waybarSettings // { output = [ "DP-1" ]; })
      (waybarSettings // {
        modules-center = [ ];
        modules-right = [ ];
        output = [ "DP-2" ];
        # Suppresses a warning
        modules = {};
      })
    ];
  };
}
