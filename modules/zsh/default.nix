{ config, pkgs, ... }: {
  bryn.hm = {
    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      dotDir = ".config/zsh";
      initExtra = ''
        any-nix-shell zsh --info-right | source /dev/stdin
        bindkey -es "^[z" 'zi\n'
        bindkey -es "^[o" 'n\n'
      '';
      plugins = [{
        name = "nnn";
        file = "init.zsh";
        src = ./nnn;
      }];
    };
    programs.starship.enable = true;
  };
  environment.pathsToLink = ["/share/zsh"];
}

