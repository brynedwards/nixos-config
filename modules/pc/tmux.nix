{ pkgs, ... }: {
  home-manager.users.bryn.programs.tmux.extraConfig =
    (import ../tmux/extraConfig.nix) + ''
      set -g status-style bg=black,fg=blue
      set -g window-status-current-style fg=white
    '';
}
