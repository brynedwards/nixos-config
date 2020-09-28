{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.bryn.wayland.enable {
    bryn.hm.services.redshift = {
      enable = true;
      temperature.night = 1900;
      latitude = "53.3";
      longitude = "6.3";
      package = pkgs.redshift-wlr;
      extraOptions = [ "-m wayland" ];
    };
  };
}
