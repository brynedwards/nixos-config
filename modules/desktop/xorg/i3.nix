{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.bryn.xorg.enable {
    bryn.hm.xsession.windowManager.i3 = {
      enable = true;
      # TODO reuse common attributes present in sway config
      config = rec {
        terminal = "kitty";
        menu = "bemenu-run";
        gaps = {
          inner = 8;
          smartBorders = "on";
          smartGaps = true;
        };
        keybindings = lib.mkOptionDefault {
          "XF86AudioPrev" = "exec playerctl previous";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioMute" = "exec pamixer -t";
          "XF86AudioLowerVolume" = "exec pamixer -d 4";
          "XF86AudioRaiseVolume" = "exec pamixer -i 4";
          "${modifier}+Tab" = "focus output right";
          "${modifier}+Shift+Tab" = "move window to output right";
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus up";
          "${modifier}+k" = "focus down";
          "${modifier}+l" = "focus right";
          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move up";
          "${modifier}+Shift+k" = "move down";
          "${modifier}+Shift+l" = "move right";
        };
        modifier = "Mod4";
      };
    };
  };
}

