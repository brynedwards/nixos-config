{ config, lib, pkgs, ... }:
let
  myWaybar = pkgs.waybar.override {
    pulseSupport = true;
    traySupport = true;
  };
  myplayerctl-pkgs = pkgs.callPackage ./scripts/myplayerctl.nix {};
  myplayerctl = "${myplayerctl-pkgs.myplayerctl}/bin/myplayerctl";
  myplayerctl-set = "${myplayerctl-pkgs.myplayerctl-set}/bin/myplayerctl-set";
  swayfade = pkgs.callPackage ./swayfade.nix { };
  swaySessionCommands = ''
    export XDG_CURRENT_DESKTOP=sway
    export SDL_VIDEODRIVER=wayland
    # needs qt5.qtwayland in systemPackages
    export QT_QPA_PLATFORM=wayland
    export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
    # Fix for some Java AWT applications (e.g. Android Studio),
    # use this if they aren't displayed properly:
    export _JAVA_AWT_WM_NONREPARENTING=1
    # cursor
    export XCURSOR_PATH="${pkgs.bibata-cursors}/share/icons:$XCURSOR_PATH"
    # export TERM_FLOAT_GEOMETRY=140x36
  '';
in {
  programs.sway = {
    enable = true;
    extraSessionCommands = swaySessionCommands;
    wrapperFeatures.base = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      dconf
      grim
      imv
      slurp
      swayidle
      swaylock
      wl-clipboard
      xwayland
      ydotool
    ];
  };

  home-manager.users.bryn = {
    wayland.windowManager.sway = {
      enable = true;
      config = rec {
        terminal = "${pkgs.foot}/bin/footclient";
        menu = "fuzzel";
        input."type:keyboard" = {
          xkb_layout = "ie";
          xkb_options = "ctrl:swapcaps";
        };
        window.commands = [
          {
            command = "floating enable";
            criteria = {
              app_id = "zoom";
              title = "Zoom Meeting";
            };
          }
          {
            command = "floating enable";
            criteria = {
              app_id = "zoom";
              title = "Choose ONE of the audio conference options";
            };
          }

        ];
        bars = [{ command = "${myWaybar}/bin/waybar"; }];
        seat = {
          "*" = {
            hide_cursor = "when-typing enable";
            xcursor_theme = "Bibata_Amber 32";
          };
        };
        window.border = 2;
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
            border = "#22bf79";
            text = "#22bf79";
            childBorder = "#22bf79";
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
        fonts = {
          names = [ "sans" ];
          size = 11.0;
        };
        focus.followMouse = false;
        gaps = {
          inner = 8;
          smartBorders = "on";
          smartGaps = true;
        };
        keybindings = lib.mkOptionDefault {
          "XF86MonBrightnessUp" = "exec brightnessctl s 10%+";
          "XF86MonBrightnessDown" = "exec brightnessctl s 10%-";

          "XF86AudioPrev" = "exec ${myplayerctl} previous";
          "XF86AudioPlay" = "exec ${myplayerctl} play-pause";
          "XF86AudioNext" = "exec ${myplayerctl} next";
          "XF86AudioMute" = "exec pamixer -t";
          "XF86AudioLowerVolume" = "exec pamixer -d 4";
          "XF86AudioRaiseVolume" = "exec pamixer -i 4";

          "${modifier}+Control+h" = "exec ${myplayerctl} previous";
          "${modifier}+Control+i" = "exec ${myplayerctl} play-pause";
          "${modifier}+Control+l" = "exec ${myplayerctl} next";
          "${modifier}+Control+m" = "exec pamixer -t";
          "${modifier}+Control+j" = "exec pamixer -d 4";
          "${modifier}+Control+k" = "exec pamixer -i 4";
          "${modifier}+Control+p" = "exec ${myplayerctl-set}";
          "${modifier}+Control+u" = "exec ${myplayerctl} position 5-";
          "${modifier}+Control+o" = "exec ${myplayerctl} position 5+";

          "${modifier}+Shift+a" = "focus child";
          "${modifier}+Tab" = "focus output right";
          "${modifier}+Shift+Tab" = "move window to output right";
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";
          "${modifier}+Shift+Return" = "exec term-float";
        };
        modifier = "Mod4";
        modes = {
          resize = {
            h = "resize shrink width 10 px or 5ppt";
            j = "resize grow height 10 px or 5ppt";
            k = "resize shrink height 10 px or 5ppt";
            l = "resize grow width 10 px or 5ppt";
            Escape = "mode default";
            Return = "mode default";
          };
        };
        floating.criteria = [
          { app_id = "zoom"; }
          {
            app_id = "zoom";
            title = "Choose ONE of the audio conference options";
          }
          {
            app_id = "zoom";
            title = "zoom";
          }
          { app_id = "foot-floating"; }
        ];
      };
      extraConfig = ''
        hide_edge_borders --i3 smart
        exec systemctl --user start graphical-session.target
        # TODO make these services
        exec_always "pkill swayfade; ${swayfade}/bin/swayfade"
        exec_always ${pkgs.mako}/bin/mako
        exec swayidle -w \
          timeout 300 'swaylock -f -c 000000' \
          timeout 600 'swaymsg "output * dpms off"' \
               resume 'swaymsg "output * dpms on"' \
          before-sleep 'swaylock -f -c 000000'
      '';
      extraSessionCommands = swaySessionCommands;
    };
    programs.waybar = {
      enable = true;
      package = myWaybar;
      style = builtins.readFile ./waybar.css;
    };

    gtk = {
      enable = true;
      iconTheme.name = "Papirus-Dark";
      iconTheme.package = pkgs.papirus-icon-theme;
    };
    programs.password-store = {
      package = pkgs.pass-wayland;
      settings = {
        PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
        PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
      };
    };
    services.wlsunset = {
      enable = true;
      latitude = "53.3";
      longitude = "6.3";
      temperature.night = 2400;
    };
  };
}
