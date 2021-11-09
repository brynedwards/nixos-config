# -----------------------------------------------
# Simple X session (Xfce)
# -----------------------------------------------
{ config, lib, pkgs, ... }: {
  services.xserver = {
    enable = true;
    layout = "ie";
    xkbOptions = "ctrl:swapcaps";
    displayManager.startx.enable = true;
    libinput.enable = true;
    libinput.touchpad.naturalScrolling = true;
    windowManager.openbox.enable = true;
  };
  home-manager.users.bryn = {
    xsession.pointerCursor = {
      package = pkgs.bibata-cursors;
      defaultCursor = "left_ptr";
      name = "Bibata_Amber";
    };
    xdg.configFile = {
      "openbox".source = ./openbox;
    };
  };

  environment.systemPackages = with pkgs; [
    alacritty
    bemenu
    pinta
    sxiv
    tint2
    wxcam
    xorg.xdpyinfo
    xorg.xrandr
    xorg.xrdb
    xsel
    xdotool
  ];
}

