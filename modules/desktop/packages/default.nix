{ config, lib, pkgs, ... }: {
  imports = [ ./wayland.nix ./xorg.nix ];
  config = lib.mkIf (config.bryn.wayland.enable || config.bryn.xorg.enable) {
    bryn.hm.home.packages = with pkgs; [
      bemenu
      bibata-cursors
      bibata-cursors-translucent
      bibata-extra-cursors
      (bitwig-studio3.overrideAttrs (oldAttrs: rec {
        name = "bitwig-studio-${version}";
        version = "3.2.4";
        src = fetchurl {
          url =
            "https://downloads.bitwig.com/stable/${version}/bitwig-studio-${version}.deb";
          sha256 = "11ilcsah79p8v9bpz2r6mk3c6glrwm3idx8n2k4cwvldsg2yvifl";
        };
      }))
      capitaine-cursors
      discord
      gnome3.gnome-tweaks
      imv
      kid3
      libreoffice
      mpv
      ncmpcpp
      ncpamixer
      numix-cursor-theme
      pamixer
      pavucontrol
      playerctl
      postman
      qbittorrent
      qpdfview
      scrot
      soulseekqt
      spotify
      ungoogled-chromium
      vanilla-dmz
    ];
    bryn.hm.home.sessionVariables = { BEMENU_OPTS = "-m 1 -fn Roboto"; };
  };
}
