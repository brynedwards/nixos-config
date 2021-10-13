# -----------------------------------------------
# Settings for every host should go here
# -----------------------------------------------
{ config, lib, options, pkgs, ... }: {
  imports = [ ./kakoune ./tmux ./vpn.nix ./zsh ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.trustedUsers = [ "root" "bryn" ];
  i18n.defaultLocale = "en_IE.UTF-8";
  time.timeZone = "Europe/Dublin";

  environment.shells = [ pkgs.zsh ];
  environment.sessionVariables = {
    EDITOR = "kak";
    LESS = "-R";
    MANPAGER = "less";
    PATH = "$HOME/.local/bin:$PATH";
    XCURSOR_SIZE = "48";
  };

  programs.less = {
    enable = true;
    envVariables.LESS = "-R";
    lessopen = ''
      | p() { ${pkgs.chroma}/bin/chroma --fail \"\$1\" || cat \"\$1\"; }; p \"%s\"'';
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.bryn = {
    isNormalUser = true;
    # uinput is for ydotool
    extraGroups = [ "uinput" "wheel" ];
  };
  security.sudo.extraConfig = "bryn ALL=(ALL) NOPASSWD:ALL";

  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  services.earlyoom.enable = true;
  services.earlyoom.freeMemThreshold = 5;

  environment.systemPackages = with pkgs; [
    bat
    bottom
    curl
    fd
    file
    foot
    git
    gitui
    git-crypt
    gnumake
    highlight
    htop
    jq
    ldns
    lf
    lsof
    ncdu
    neofetch
    nixfmt
    nmap
    p7zip
    pwgen
    ripgrep
    shfmt
    sshfs
    tmux
    trash-cli
    tree
    unzip
    usbutils
    xmlformat
    youtube-dl
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = false;
    users.bryn.programs = {
      direnv.enable = true;
      direnv.nix-direnv = {
        enable = true;
        enableFlakes = true;
      };
      exa.enable = true;
      exa.enableAliases = true;
      fzf.enable = true;
      fzf.changeDirWidgetCommand = "fd -t d -H";
      gpg.enable = true;
      nix-index.enable = true;
      password-store.enable = true;
      starship = {
        enable = true;
        package = pkgs.starship.overrideAttrs (oldAttrs: rec {
          patches = [ ../packages/starship-altjobs.patch ];
          doCheck = false;
        });
        settings = let format = "[┃ $symbol($version)]($style) ";
        in {
          aws.disabled = true;
          custom.djangodb = {
            command = "printf %s \${DBNAME:-selectapp} ";
            directories = [ "selectproject" ];
            format = ''

              [$symbol ($output)]($style)'';
            symbol = "";
          };
          directory = {
            truncation_length = 8;
            truncate_to_repo = false;
          };
          git_branch.format = "[┃ $symbol$branch]($style) ";
          git_status = {
            format = "([$all_status$ahead_behind]($style)) ";
            style = "bold #ff57dd";
          };
          jobs = {
            format = "[$symbol( \${number}x)]($style) ";
            symbol = "🏃";
          };
          nix_shell.format = "[┃ $symbol]($style) ";
          nodejs.format = format;
          python.format = format;
          rust.format = format;
          rust.version_format = "$major.$minor.$patch";
        };
      };
      zoxide.enable = true;
      lf = {
        enable = true;
        keybindings = {
          gz = ''$lf -remote "send $id cd $(zoxide query -l | fzf)"'';
        };
      };
    };
    users.bryn.services.gpg-agent.enable = true;
    users.bryn.xdg.configFile = {
      "helix/themes".source = ./helix/themes;
      "helix/config.toml".source = ./helix/config.toml;
      "helix/languages.toml.toml".source = ./helix/languages.toml;
    };
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  nix.binaryCachePublicKeys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];
  nix.binaryCaches = [ "https://nix-community.cachix.org" ];
}
