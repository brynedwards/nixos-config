{ config, pkgs, ... }: {
  imports =
    [ ./hardware-configuration.nix ./nginx.nix ./scripts.nix ./tmux.nix ];

  hardware.cpu.intel.updateMicrocode = true;

  home-manager.users.bryn.programs = {
    beets = {
      enable = true;
      settings = {
        directory = "/home/bryn/Music";
        import = {
          move = true;
          quiet_fallback = "asis";
        };
        plugins = [ "fetchart" ];
      };
      package = (pkgs.beets.override { enableSonosUpdate = false; });
    };
  };

  networking = {
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 4533 ];  # navidrome
    hostName = "nuc";
  };

  environment.systemPackages = with pkgs; [ id3v2 pinentry-curses ];
  services = {
    avahi.publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };

    navidrome = {
      enable = true;
      settings = {
        Address = "0.0.0.0";
        BaseUrl = "/navidrome";
        MusicFolder = "/mnt/media/media/music";
      };
    };

    openssh = {
      enable = true;
      passwordAuthentication = false;
    };
  };

  system.stateVersion = "20.09";
  home-manager.users.bryn.home.stateVersion = "20.09";
}
