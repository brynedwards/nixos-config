# -----------------------------------------------
# Simple X session (Xfce)
# -----------------------------------------------
{ config, lib, pkgs, ... }: {
  services.xserver = {
    enable = true;
    layout = "ie";
    xkbOptions = "ctrl:swapcaps";
    displayManager.startx.enable = true;
    desktopManager.xfce.enable = true;
  };
  home-manager.users.bryn = {
    xsession.pointerCursor = {
      package = pkgs.bibata-cursors;
      defaultCursor = "left_ptr";
      name = "Bibata_Amber";
    };
  };

  environment.systemPackages = with pkgs; [
    pinta
    sxiv
    pinta
    wxcam
    xorg.xdpyinfo
    xorg.xrandr
    xorg.xrdb
    xsel
    xdotool
  ];
}

