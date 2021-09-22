{ pkgs, ... }: {
  home-manager.users.bryn.programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    shortcut = "'\\'";
    terminal = "tmux-256color";
  };
}
