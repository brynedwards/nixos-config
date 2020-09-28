{ config, lib, pkgs, ... }:
let cfg = config.bryn.languages.c;
in with lib; {
  options = {
    bryn.languages.c = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = ''
          Tools for the C and C++ programming languages.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    bryn.hm.home = {
      packages = with pkgs; [ ccls clang gdb meson ];

      sessionVariables = {
        "CC" = "clang";
        "CXX" = "clang++";
      };
    };
  };
}
