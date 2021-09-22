{ config, pkgs, ... }:
let chromium = pkgs.callPackage ../../packages/chromium.nix { };
in {
  environment.systemPackages = with pkgs; [
    (writeScriptBin "beetimp" (builtins.readFile ./bin/beetimp))
    (writeScriptBin "chromium-work" ''
      ${chromium} --user-data-dir=$HOME/.config/chromium-work
    '')
  ];
}

