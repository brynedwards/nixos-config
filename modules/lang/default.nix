{ config, lib, pkgs, ... }:
let
  cfg = config.bryn.langSupport;
in
with lib; {
  imports = [
    ./c.nix
    ./python.nix
    ./rust.nix
    ./zig.nix
  ];

  options = {
    bryn.langSupport = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = ''
          Wildcard for language support.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    bryn.languages = {
      c.enable = true;
      python.enable = true;
      rust.enable = true;
      zig.enable = true;
    };
  };
}
