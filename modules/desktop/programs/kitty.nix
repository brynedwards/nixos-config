{ config, lib, ... }: {
  config = lib.mkIf config.bryn.wayland.enable {
    bryn.hm.programs.kitty = {
      enable = true;
      settings = {
        # Use sway background opacity instead
        # background_opacity = "0.9";
        allow_remote_control = true;
        font_size = "8";

        # special
        foreground = "#ffffff";
        background = "#0f0f22";

        # black
        color0 = "#404088";
        color8 = "#7070b0";

        # red
        color1 = "#c30032";
        color9 = "#ff124f";

        # green
        color2 = "#00a000";
        color10 = "#00ff00";

        # yellow
        color3 = "#a0c200";
        color11 = "#defe47";

        # blue
        color4 = "#0098d8";
        color12 = "#00b3fe";

        # magenta
        color5 = "#ce39ce";
        color13 = "#ff2eff";

        # cyan
        color6 = "#00a0a0";
        color14 = "#00ffff";

        # white
        color7 = "#d8d8d8";
        color15 = "#ffffff";
      };
    };
  };
}
