{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.bryn.wayland.enable {
    bryn.hm.programs.waybar = {
      enable = true;
      settings = [
        {
          layer = "bottom";
          position = "top";
          height = 30;
          modules-left = [ "sway/workspaces" "sway/mode" "sway/window" ];
          modules-center = [ ];
          modules-right = [
            "cpu"
            "memory"
            "temperature"
            "network"
            "mpd"
            "pulseaudio"
            "tray"
            "clock"
          ];
          output = [ "DP-2" ];
          modules = {
            "sway/workspaces" = { all-outputs = true; };
            clock = { format = "{:%A %d %B, %H:%M}"; };
            cpu = {
              format = " {usage}%";
              interval = "1";
            };
            memory = { format = " {used:0.1f} GB"; };
            network = {
              format = " ⬇{bandwidthDownBits} ⬆{bandwidthUpBits}";
              interval = "1";
            };
            temperature = {
              format = "{icon} {temperatureC} °C";
              format-icons = [ "" "" ];
            };
            mpd = {
              format-disconnected = " ";
              format = " {icon} {album} - {artist} - {title}";
              state-icons = {
                playing = "";
                paused = "";
              };
            };
            pulseaudio = {
              format = "{icon} {volume}%";
              format-muted = " {volume}%";
              format-icons = {
                default = [ "" "" ];
                headphones = "";
              };
            };
            tray = {
              icon-size = 21;
              spacing = 10;
            };
          };
        }
        {
          height = 20;
          layer = "bottom";
          modules-left = [ "sway/workspaces" "sway/mode" "sway/window" ];
          modules-center = [ ];
          modules-right = [ ];
          output = [ "DP-3" ];
          position = "top";
          modules = { "sway/workspaces" = { all-outputs = true; }; };
        }
      ];
      style = (builtins.readFile ./waybar.css);
    };
    bryn.hm.home.packages = [ pkgs.font-awesome_5 ];
  };
}

