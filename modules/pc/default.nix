# -----------------------------------------------
# Settings for all PCs should go here
# -----------------------------------------------
{ config, pkgs, ... }:
let
  passfst = pkgs.callPackage ./scripts/passfst.nix { };
  secrets = import ../../secrets;
in {
  imports = [ ./qutebrowser ./scripts ./sway ./tmux.nix ./x.nix ];

  boot.supportedFilesystems = [ "ntfs" ];

  # Video acceleration
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ libva libvdpau ];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    wlr.settings.screencast.max_fps = 20;
  };

  environment.systemPackages = with pkgs; [
    agenix
    augustus
    brightnessctl
    cmus
    dunst
    (callPackage ../../packages/element-desktop.nix { })
    entr
    feh
    ffmpeg
    google-chrome
    irssi
    julius
    kid3
    libnotify
    libreoffice
    (mpv-with-scripts.override { scripts = [ pkgs.mpvScripts.mpris ]; })
    (callPackage ../../packages/nb.nix { })
    (ncpamixer.overrideAttrs (oldAttrs: {
      src = fetchFromGitHub {
        owner = "fulhax";
        repo = "ncpamixer";
        rev = "a69610aa7dd2fb98a4b9558d0a0f73e14cc16aab";
        sha256 = "sha256-pGUrwYsNeQS7OpwurUXxArdqwCAVJWwKlYio1YOeOA4=";
      };
    }))
    nodejs_latest
    pamixer
    nodePackages.node2nix
    nodePackages.peerflix
    pinentry-curses
    pgformatter
    playerctl
    (callPackage ../../packages/potato.nix { })
    (python3.buildEnv.override {
      extraLibs = with pkgs.python3Packages; [
        black
        ipython
        pyflakes
        pylint
        rope
      ];
    })
    rage
    ripcord
    river
    (rust-bin.selectLatestNightlyWith
      (toolchain: toolchain.default.override { extensions = [ "rust-src" ]; }))
    rust-analyzer
    shfmt
    signal-desktop
    skypeforlinux
    socat # required for qutebrowser script
    termdown
    tomb
    tree-sitter
    zathura
    zoom-us
  ];

  fonts.fonts = with pkgs; [
    font-awesome
    iosevka-bin
    nerdfonts
    noto-fonts-emoji
    roboto
  ];
  fonts.fontconfig.defaultFonts.emoji = [ "Noto Color Emoji" ];
  fonts.fontconfig.defaultFonts.monospace = [ "Iosevka" "Liberation Mono" ];
  fonts.fontconfig.defaultFonts.sansSerif = [ "Roboto" "Liberation Sans" ];

  home-manager.users.bryn.accounts.email.accounts =
    secrets.email { inherit passfst; };
  home-manager.users.bryn.gtk.enable = true;
  home-manager.users.bryn.programs = {
    astroid = {
      enable = true;
      extraConfig.thread_view.preferred_type = "html";
    };
    browserpass.enable = true;
    chromium = {
      enable = true;
      package = (pkgs.callPackage ../../packages/chromium.nix { });
      extensions = [ "naepdomgkenhinolocfifgehidddafch" ];
    };
    firefox = {
      enable = true;
      package =
        pkgs.firefox-wayland.override { cfg.enableTridactylNative = true; };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        adsum-notabs
        browserpass
        darkreader
        old-reddit-redirect
        tridactyl
      ];
      profiles = let
        shared = {
          settings = {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          };
          userChrome = ''
            #tabbrowser-tabs {
              display: none;
            }
          '';
        };
      in {
        personal = shared // {
          id = 0;
          name = "personal";
        };
        work = shared // {
          id = 1;
          name = "work";
        };
      };
    };
    foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = { dpi-aware = "yes"; };
        colors = {
          foreground = "d8d8d8";
          background = "000000";

          regular0 = "000000";
          regular1 = "cb0119";
          regular2 = "86ab3b";
          regular3 = "ed8702";
          regular4 = "3c95be";
          regular5 = "c251ab";
          regular6 = "48b19c";
          regular7 = "d8d8d8";

          bright0 = "b0b090";
          bright1 = "fb0120";
          bright2 = "a1c659";
          bright3 = "fda331";
          bright4 = "6fb3d2";
          bright5 = "d381c3";
          bright6 = "76c7b7";
          bright7 = "ffffff";
        };
      };
    };
    mbsync.enable = true;
    notmuch.enable = true;
    vscode = {
      enable = true;
      package = (pkgs.callPackage ../../packages/vscodium.nix { });
    };
  };
  home-manager.users.bryn.xdg = {
    configFile."tridactyl/tridactylrc".source = ./tridactylrc;
    dataFile."jellyfinmediaplayer/scripts/mpris.so".source =
      "${pkgs.mpvScripts.mpris}/share/mpv/scripts/mpris.so";
    desktopEntries.ncpamixer = {
      name = "ncpamixer";
      genericName = "Volume control";
      exec = "ncpamixer -t o";
      terminal = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
  virtualisation.docker.enable = true;
  users.users.bryn.extraGroups = [ "docker" ];
  age.sshKeyPaths = [ /home/bryn/.ssh/id_ed25519 ];
}
