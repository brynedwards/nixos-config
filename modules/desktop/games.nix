{ config, lib, pkgs, ... }:
let cfg = config.bryn.games;
in with lib; {

  options = {
    bryn.games = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = ''
          Add some games and game-related libs, settings.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.config = { retroarch = { enableBsnesMercury = true; }; };

    bryn.hm.home.packages = with pkgs; [
      quake3e
      retroarch
      steam
      steam-run
      wineWowPackages.stable
    ];
  };
}

