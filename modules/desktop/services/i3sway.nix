{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.bryn.wayland.enable {
    bryn.hm.systemd.user.services.i3sway-opacity = {
      Unit = {
        Description = "Inactive window transparency for i3/sway";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Install = { WantedBy = [ "graphical-session.target" ]; };

      Service = {
        ExecStart = "/etc/nixos/scripts/i3sway-opacity";
        RestartSec = 3;
        Restart = "always";
      };
    };
  };
}
