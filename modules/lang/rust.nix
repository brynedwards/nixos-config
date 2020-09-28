{ config, lib, pkgs, ... }:
let cfg = config.bryn.languages.rust;
in with lib; {
  options = {
    bryn.languages.rust = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = ''
          Tools for the Rust programming language.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    bryn.hm.home = {
      # perl and socat required by kakoune-gdb
      packages = with pkgs; [ cargo perl rls rustc rustfmt socat ];
    };
  };
}

