{ config, lib, pkgs, ... }: {
  imports = [ ./sway.nix ./waybar.nix ];
  options = {
    bryn.wayland = {
      enable = lib.mkOption {
        default = false;
        type = with lib.types; bool;
        description = ''
          Enable an Wayland-based graphical session, and related apps.
        '';
      };
    };
  };

  config = lib.mkIf config.bryn.wayland.enable {
    # Required for setting GTK3 fonts
    programs.dconf.enable = true;

    # This does not remove old keys
    # https://github.com/nix-community/home-manager/issues/1444
    bryn.hm.dconf.settings = {
      "org/gnome/desktop/interface" = {
        font-name = "Sans 11";
        document-font-name = "Sans 11";
        monospace-font-name = "Mono 11";
        cursor-theme = "Bibata_Amber";
        cursor-size = "48";
      };
    };
  };
}

