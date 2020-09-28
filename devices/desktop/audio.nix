{ pkgs, ... }:
{
  imports = [ <musnix> ];

  musnix = {
    enable = true;
    kernel.packages = [ pkgs.linuxPackages_latest_rt ];
  };
  users.users.bryn.extraGroups = [ "audio" "jackaudio" ];

  boot.kernelModules = [ "snd-seq" "snd-rawmidi" ];
  # hardware.pulseaudio.package = pkgs.pulseaudio.override { jackaudioSupport = true; };
  services.jack = {
    jackd.enable = true;
    alsa.enable = false;
    loopback = {
      enable = true;
    };
  };
}
