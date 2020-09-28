{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.bryn.wayland.enable {
    bryn.hm.services = {
      mpd = {
        enable = true;
        extraConfig = ''
          restore_paused "yes"
        '';
        musicDirectory = "/home/bryn/Music";
      };
      mpdris2.enable = true;
      mpdris2.notifications = true;
    };
  };
}
