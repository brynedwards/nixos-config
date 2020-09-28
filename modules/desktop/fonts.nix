{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.bryn.hm.wayland.windowManager.sway.enable {
    fonts.fonts = with pkgs; [
      comfortaa
      fira-code
      google-fonts
      iosevka
      (iosevka.override {
        set = "custom";
        privateBuildPlan = {
          family = "Iosevka Term";
          design = [ "sp-fixed" "v-l-tailed" "v-one-nobase" ];
        };
      })
      joypixels
      league-of-moveable-type
    ];
    fonts.fontconfig.defaultFonts.emoji = [ "JoyPixels" ];
    fonts.fontconfig.defaultFonts.monospace =
      [ "Iosevka Term" "Inconsolata" "Liberation Mono" ];
    fonts.fontconfig.defaultFonts.sansSerif =
      [ "Roboto" "Molengo" "Liberation Sans" ];
  };
}
