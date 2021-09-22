{ pkgs, ... }:
let playerctlPath = "~/.local/share/playerctl-current";
in {
  myplayerctl = pkgs.writeScriptBin "myplayerctl" ''
    #!${pkgs.stdenv.shell}
    playerctl -p $(cat ${playerctlPath}) $@
  '';
  myplayerctl-set = pkgs.writeScriptBin "myplayerctl-set" ''
    #!${pkgs.stdenv.shell}
    playerctl -l | fuzzel -d > ${playerctlPath}
  '';
}
