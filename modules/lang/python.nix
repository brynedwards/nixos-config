{ config, lib, pkgs, ... }:
let cfg = config.bryn.languages.python;
in with lib; {
  options = {
    bryn.languages.python = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = ''
          Support for the Python programming language and Jupyter Notebook.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    bryn.hm = {
      home.packages = with pkgs;
        let
          my-python-packages = ps: with ps; [ i3ipc ];
          python-with-my-packages = python3.withPackages my-python-packages;
        in [
          python-with-my-packages
          python3Packages.python-language-server
          mypy
        ];
    };
  };
}
