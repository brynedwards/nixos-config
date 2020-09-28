{ options, config, lib, pkgs, ... }: {
  imports = [ ./desktop ./fonts.nix ./lang ./zsh ];

  options = {
    bryn.hm =
      lib.mkOption { type = options.home-manager.users.type.functor.wrapped; };
  };

  config = {
    bryn.hm = {
      # let home-manager manage itself
      programs.home-manager.enable = true;

      home.file.".local/bin".source = ./bin;
      home.sessionVariables = {
        EDITOR = "kak";
        LESS = "-FR";
        LESSOPEN = "|pygmentize %s";
        MANPAGER = "less";
        NNN_BMS = "c:~/.config;n:/etc/nixos";
        NNN_PLUG = "r:_less \$nnn*";
        NNN_TRASH = "1";
        PATH = "$HOME/.local/bin:$PATH";

        BEMENU_OPTS = "-m 1 -fn Roboto";
      };

      home.packages = with pkgs; [
        any-nix-shell
        broot
        brotli
        cmus
        curl
        exa
        fd
        ffmpeg
        file
        fuseiso
        git
        gitAndTools.tig
        gnumake
        heroku
        highlight
        htop
        httpie
        jq
        kak-lsp
        kakoune
        manpages
        mercurial
        mpc_cli
        ncdu
        neofetch
        niv
        nixfmt
        nmap
        (nnn.override { conf = builtins.readFile ./nnn.h; })
        nodePackages.peerflix
        ormolu
        p7zip
        pinentry-curses
        pwgen
        python3Packages.pygments
        ripgrep
        sshfs
        termdown
        tree
        unrar
        unzip
        usbutils
        xmlformat
        youtube-dl
        nodejs_latest
        trash-cli
      ];

      programs = {
        beets = {
          enable = true;
          settings = {
            directory = "/home/bryn/Music";
            import = { move = "yes"; };
          };
        };
        direnv = {
          enable = true;
          enableNixDirenvIntegration = true;
        };
        fzf.enable = true;
        fzf.changeDirWidgetCommand = "fd -t d -H";
        gpg.enable = true;
        kakoune = import ./kakoune.nix;
        nushell.enable = true;
        zoxide.enable = true;
      };
      xdg.configFile."kak/autoload/rc".source =
        "${pkgs.kakoune-unwrapped}/share/kak/rc";
      services.gpg-agent = {
        enable = true;
        pinentryFlavor = "gtk2";
      };
      services.lorri.enable = true;
      home.stateVersion = "20.03";
    };
  };
}
