{ pkgs, ... }:
let
  kakoune = pkgs.kakoune.override {
    plugins = with pkgs.kakounePlugins; [
      active-window-kak
      auto-pairs-kak
      case-kak
      connect-kak
      kakoune-rainbow
      prelude-kak
      quickscope-kak
    ];
  };
in {
  environment.systemPackages = [ kakoune pkgs.kak-lsp ];

  home-manager.users.bryn.xdg.configFile = {
    "kak/kakrc".source = ./kakrc;
    "kak/autoload/local".source = ./local;
    "kak/autoload/rc".source = "${kakoune}/share/kak/autoload";
    "kak-lsp/kak-lsp.toml".source = ./kak-lsp.toml;
  };
}
