{ pkgs, stdenv, lib, ... }:
let localNodePackages = import ./node-packages { inherit pkgs; };
in {
  imports =
    [ ../../modules/pc ./hardware-configuration.nix ./scripts.nix ./sway.nix ];

  networking = {
    hostName = "carbide";
    hosts = {
      "127.0.0.1" = [ "carbide.local" ];
      # browsers don't reliably resolve this with just mdns 🤷
      "192.168.1.9" = [ "nuc.local" ];
    };
    interfaces.enp34s0.useDHCP = true;
  };

  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelModules = [ "kvm-amd" "v4l2loopback" ];

  console = {
    earlySetup = true;
    font = "ter-v32n";
    keyMap = "uk";
    packages = [ pkgs.terminus_font ];
  };

  hardware.cpu.amd.updateMicrocode = true;
  hardware.uinput.enable = true;
  hardware.pulseaudio.extraConfig = ''
    set-default-sink "alsa_output.pci-0000_2a_00.4.analog-stereo"
  '';

  # ???
  hardware.opengl.extraPackages = with pkgs; [ amdvlk ];
  hardware.opengl.extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];

  environment.systemPackages = with pkgs; [
    audacity
    (bitwig-studio3.overrideAttrs (oldAttrs: rec {
      name = "bitwig-studio-${version}";
      version = "3.2.8";
      src = fetchurl {
        url =
          "https://downloads.bitwig.com/stable/${version}/bitwig-studio-${version}.deb";
        sha256 = "sha256-8kInzjUOpyXzaRzSyuOlainirpwIIcgqWS+us219jaI=";
      };
    }))
    cm-rgb
    discord
    gnome3.gnome-tweaks
    inkscape
    jellyfin-media-player
    qbittorrent
    qjackctl
    rpcs3
    skypeforlinux
    soulseekqt
    steamcmd
    steam-tui
    unrar
    (winetricks.override { wine = wineWowPackages.staging; })
    wineWowPackages.staging

    # Web development
    localNodePackages.svelte-language-server
    nodePackages.typescript-language-server
  ];

  environment.variables.TERM_FLOAT_GEOMETRY = "140x36";
  programs.steam.enable = true;

  home-manager.users.bryn.programs.foot.settings.main.font = "Iosevka Nerd Font Mono:style=Regular:size=12.5";

  system.stateVersion = "20.09";
  home-manager.users.bryn.home.stateVersion = "20.09";
}
