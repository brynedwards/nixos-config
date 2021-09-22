{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [ (writeScriptBin "beetimp" (builtins.readFile ./bin/beetimp)) ];
}

