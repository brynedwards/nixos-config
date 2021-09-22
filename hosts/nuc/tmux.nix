{ pkgs, ... }: {
  home-manager.users.bryn.programs.tmux.extraConfig =
    (import ../../modules/tmux/extraConfig.nix) + ''
      set -g status-style bg=blue,fg=black
      set -g window-status-current-style fg=white
    '';
}
