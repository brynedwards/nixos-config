{ config, lib, pkgs, ... }: {
  imports = [ ./i3.nix ];

  options = {
    bryn.xorg = {
      enable = lib.mkOption {
        default = false;
        type = with lib.types; bool;
        description = ''
          Enable an Xorg-based graphical session, and related apps.
        '';
      };
    };
  };

  config = lib.mkIf config.bryn.xorg.enable {
    services.xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      layout = "ie";
      xkbOptions = "ctrl:swapcaps";
      desktopManager.xterm.enable = false;
      desktopManager.session = [{
        name = "i3";
        start = ''
          ${pkgs.runtimeShell} $HOME/.xsession &
          waitPID=$!
        '';
      }];

      displayManager.startx.enable = true;
    };
    bryn.hm = {
      home.file.".xinitrc".source = ./xinitrc;
      xresources.properties."Xft.dpi" = 192;
    };
  };
}

