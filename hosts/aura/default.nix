{ config, pkgs, ... }:
let secrets = import ../../secrets;
in {
  imports = [ ../../modules/pc ./hardware-configuration.nix ./sway.nix ];

  boot.kernelModules = [ "tuxedo_keyboard" ];
  boot.extraModulePackages = [ pkgs.linuxPackages_latest.tuxedo-keyboard ];

  networking = {
    hostName = "aura";
    hosts = {
      "127.0.0.1" = [ "aura.local" ];
      "192.168.1.9" = [ "nuc.local" ];
    };
    resolvconf.extraConfig = "name_servers=1.1.1.1";
    wireless = {
      enable = true;
      interfaces = [ "wlo1" ];
      networks = secrets.networks;
      userControlled.enable = true;
    };
  };

  boot.supportedFilesystems = [ "ntfs" ];
  hardware.cpu.amd.updateMicrocode = true;

  environment.systemPackages = with pkgs; [ acpi ];
  environment.variables = {
    FUZZEL_FONT_SIZE = "18";
    TERM_FLOAT_GEOMETRY = "120x24";
    TERM_FLOAT_FONT_SIZE = "12";
  };
  home-manager.users.bryn.programs.foot.settings.main.font = "Iosevka Nerd Font Mono:style=Regular:size=9";

  system.stateVersion = "21.05";
  home-manager.users.bryn.home.stateVersion = "21.05";
}
