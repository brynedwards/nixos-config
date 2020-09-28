{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.bryn.wayland.enable {
    bryn.hm.wayland.windowManager.sway = {
      enable = true;
      config = rec {
        colors = {
          focused = {
            background = "#000000";
            border = "#fdd300";
            text = "#fdd300";
            childBorder = "#fdd300";
            indicator = "#cf00ff";
          };
          focusedInactive = {
            background = "#000000";
            border = "#5f676a";
            text = "#5f676a";
            childBorder = "#5f676a";
            indicator = "#808080";
          };
          unfocused = {
            background = "#000000";
            border = "#303030";
            text = "#888888";
            childBorder = "#303030";
            indicator = "#606060";
          };
        };
        fonts = [ "sans 10" ];
        terminal = "kitty";
        menu = "bemenu-run";
        bars = [{ command = "waybar"; }];
        focus.followMouse = "no";
        gaps = {
          inner = 8;
          smartBorders = "on";
          smartGaps = true;
        };
        window.border = 1;
        keybindings = lib.mkOptionDefault {
          "XF86AudioPrev" = "exec playerctl previous";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioMute" = "exec pamixer -t";
          "XF86AudioLowerVolume" = "exec pamixer -d 4";
          "XF86AudioRaiseVolume" = "exec pamixer -i 4";
          "${modifier}+p" = "exec passmenu --type";
          "${modifier}+Tab" = "focus output right";
          "${modifier}+Shift+Tab" = "move window to output right";
        };

        modes = {
          resize = {
            Escape = "mode default";
            Return = "mode default";
            Up = "resize shrink height";
            h = "resize shrink width";
            j = "resize grow height";
            k = "resize shrink height";
            l = "resize grow width";
          };
        };

        output = {
          "DP-2" = {
            scale = "2";
            pos = "0 0 res 3840x2160";
            bg = "/etc/nixos/assets/wallpaper.png fill";
          };
          "DP-3" = {
            scale = "2";
            pos = "1920 0 res 3440x1440";
            bg = "/etc/nixos/assets/wallpaper.png fill";
          };
        };

        input = {
          "type:keyboard" = {
            xkb_layout = "ie";
            xkb_options = "ctrl:swapcaps";
          };
        };
        modifier = "Mod4";
      };
      extraConfig =
        ''
        hide_edge_borders --i3 none
        seat seat0 xcursor_theme Bibata_Amber 24
        exec swayidle -w \
          timeout 300 'swaylock -f' \
          timeout 600 'swaymsg "output * dpms off"' \
          resume 'swaymsg "output * dpms on"' \
          before-sleep 'swaylock -f'
      '';
      wrapperFeatures = {
        base = true;
        gtk = true;
      };
      extraSessionCommands = ''
        export SDL_VIDEODRIVER=wayland
        # needs qt5.qtwayland in systemPackages
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        # Fix for some Java AWT applications (e.g. Android Studio),
        # use this if they aren't displayed properly:
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';
    };

    security.pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
  };
}

