{ config, lib, options, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ./devices/desktop ./modules ];

  nix.trustedUsers = [ "root" "bryn" ];
  i18n.defaultLocale = "en_IE.UTF-8";
  time.timeZone = "Europe/Dublin";

  environment.shells = with pkgs; [ nushell zsh ];
  users.users.bryn = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball
        "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
    };
    # This is required for waybar to compile with pulseaudio support
    pulseaudio = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    users.bryn = lib.mkAliasDefinitions options.bryn.hm;
  };

  nixpkgs.overlays = import ./packages;
  system.stateVersion = "20.03";
}
