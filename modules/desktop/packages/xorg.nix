{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.bryn.xorg.enable {
    bryn.hm.home.packages = with pkgs; [
      bemenu
      # cool-retro-term
      # gimp
      hsetroot
      inkscape
      mimeo
      pinta
      scrot
      sxiv
      xorg.xdpyinfo
      xorg.xrandr
      xorg.xrdb
      xsel
      zoom-us
    ];
  };
}
