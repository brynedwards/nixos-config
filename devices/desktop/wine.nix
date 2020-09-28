{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    # autorun = false;
    videoDrivers = [ "amdgpu" ];
    layout = "ie";
    xkbOptions = "ctrl:swapcaps";
    displayManager.gdm.enable = true;
    desktopManager.gnome3.enable = true;
    windowManager.openbox.enable = true;
  };
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;
  users.users.bryn.extraGroups = [ "input" ];
}

