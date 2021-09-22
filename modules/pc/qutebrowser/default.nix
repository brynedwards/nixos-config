{ config, lib, pkgs, ... }: {
  home-manager.users.bryn = {
    programs.qutebrowser = let
      duckduckgo = "https://lite.duckduckgo.com/lite";
      duckduckgoSearch = "${duckduckgo}?q={}";
    in {
      enable = true;
      package = pkgs.qutebrowser;

      keyBindings = {
        normal = {
          "w" = "scroll up";
          "s" = "scroll down";
          "d" = "scroll-page 0 0.5";
          "e" = "scroll-page 0 -0.5";
          "b" = "scroll-page 0 -1";
          "<Space>" = "scroll-page 0 1";
          "S" = "back";
          "D" = "forward";
          "q" = "tab-close";
          "u" = "undo --window";

          "O" = "set-cmd-text -s :open -w";

          ",c" = "spawn -u clone {url}";
          ",p" = "spawn -u qute-pass -U secret -u '^user:\\\\s+(.+)'";
          ",r" = "spawn -u readability {url}";
          ",v" = "spawn -d mpv {url}";

          ";c" = "hint links spawn -u clone {hint-url}";
          ";r" = "hint links spawn -u readability {hint-url}";
          ";v" = "hint links spawn -d mpv {hint-url}";
        };
      };

      searchEngines = {
        DEFAULT = duckduckgoSearch;
        d = duckduckgoSearch;
        w =
          "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
        aw = "https://wiki.archlinux.org/?search={}";
        nw = "https://nixos.wiki/index.php?search={}";
        ggl = "https://encrypted.google.com/search?hl=en&q={}";
      };
      settings = {
        colors.webpage.bg = "black";
        colors.webpage.darkmode.enabled = true;

        content.headers.user_agent =
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}";
        content.javascript.enabled = false;
        editor.command = [ "term-float" "kak" "{file}" ];
        fonts.default_family = "Sans";
        new_instance_open_target = "window";
        qt.highdpi = true;
        tabs.show = "multiple";
        tabs.tabs_are_windows = true;
        url.default_page = duckduckgo;
        url.start_pages = [ duckduckgo ];
      };

      extraConfig = ''
        try:
            from qutebrowser.api import message
            config.source("redirectors.py")

        except ImportError:
            pass

        config.load_autoconfig()
      '';
    };
    xdg.configFile."qutebrowser/redirectors.py".source = ./config/redirectors.py;
    xdg.dataFile."qutebrowser/userscripts".source = ./userscripts;
  };
}
