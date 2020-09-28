{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.bryn.wayland.enable {
    bryn.hm.systemd.user.services.gammastep = {
      Unit = {
        Description = "Gammastep colour temperature adjuster";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Install = { WantedBy = [ "graphical-session.target" ]; };

      Service = {
        ExecStart = "${pkgs.gammastep}/bin/gammastep -m wayland -l 53.3:6.3 -t 6500:2400";
        RestartSec = 3;
        Restart = "always";
      };
    };
  };
}

