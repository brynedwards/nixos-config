{ config, pkgs, ... }: {
  home-manager.users.bryn.programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    dotDir = ".config/zsh";
    shellAliases.rm = "echo \"use trash-put instead, or prefix with backslash.\"; false";
    shellAliases.wlsunset = "echo \"use the systemd user service.\"; false";
    initExtra = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
      bindkey -es "^[e" ' hx\n'
      bindkey -es "^[E" ' kak\n'
      bindkey -es "^[g" ' gitui\n'
      bindkey -es "^[o" ' jcd\n'
      bindkey -es "^[p" ' lfcd\n'
      bindkey -es "^[z" ' zi\n'
      if [ "$(tty)" = "/dev/tty1" ]; then
      	XCURSOR_SIZE=48 exec dbus-run-session sway
      fi

      _urlencode() {
      	local length="''${#1}"
      	for (( i = 0; i < length; i++ )); do
      		local c="''${1:$i:1}"
      		case $c in
      			%) printf '%%%02X' "'$c" ;;
      			*) printf "%s" "$c" ;;
      		esac
      	done
      }

      osc7_cwd() {
      	printf '\e]7;file://%s%s\e\\' "$HOSTNAME" "$(_urlencode "$PWD")"
      }

      autoload -Uz add-zsh-hook
      add-zsh-hook -Uz chpwd osc7_cwd
    '';
    initExtraBeforeCompInit = ''
      fpath+="$HOME/.nix-profile/share/zsh/site-functions"
    '';
    localVariables.WORDCHARS = "*?[]~&;!$%^(){}<>";
    plugins = [
      {
        name = "custom";
        file = "init.zsh";
        src = ./custom;
      }
      {
        name = "zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "0.31.0";
          sha256 = "0rw23m8cqxhcb4yjhbzb9lir60zn1xjy7hn3zv1fzz700f0i6fyk";
        };
      }
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "0c36bdcf6a80ec009280897f07f56969f94d377e";
          sha256 = "sha256-LcbLYVqCcA9eQAAjN61GlI5XmLpbKjnMSn1SCfxMt3o=";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.8.0-alpha1-pre-redrawhook";
          sha256 = "1gv7cl4kyqyjgyn3i6dx9jr5qsvr7dx1vckwv5xg97h81hg884rn";
        };
      }
      {
        name = "autoenv";
        src = pkgs.fetchFromGitHub {
          owner = "zpm-zsh";
          repo = "autoenv";
          rev = "7c43e79affb8e41a6d34036ce44489910e7b5510";
          sha256 = "sha256-ZuzAvgUYP4JMOScYdhyo1ilvjT4ttsctLCbSCklb9KM=";
        };
      }
    ];
  };
  environment.pathsToLink = [ "/share/zsh" ];
}
