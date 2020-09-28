{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.bryn.wayland.enable {
    bryn.hm = {
      programs.firefox = {
        enable = true;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          browserpass
          darkreader
          decentraleyes
          google-search-link-fix
          tridactyl
          ublock-origin
          umatrix
        ];
        profiles = let
          defaultSettings = {
            "app.update.auto" = false;
            "browser.startup.homepage" = "about:newtab";
          };
        in {
          home = {
            id = 0;
            settings = defaultSettings // {
              "browser.urlbar.placeholderName" = "DuckDuckGo";
            };
          };
          work = {
            id = 1;
            settings = defaultSettings;
          };
        };
        # Should use standard package if xorg is enabled
        package = pkgs.firefox-wayland;
      };
      programs.browserpass = {
        enable = true;
        browsers = [ "firefox" "chromium" ];
      };

      xdg.configFile."tridactyl/tridactylrc".source = ./tridactylrc;
    };
  };
}

