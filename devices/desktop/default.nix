{ config, pkgs, ... }:

{
  imports = [ ./hardware.nix ];

  # Video acceleration
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      libva
      libvdpau
    ];
  };
  hardware.cpu.intel.updateMicrocode = true;
  hardware.uinput.enable = true;

  bryn.games.enable = true;
  bryn.langSupport.enable = true;
  bryn.wayland.enable = true;
  bryn.xorg.enable = true;

  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;

  programs.adb.enable = true;
  users.users.bryn.extraGroups = ["adbusers"];
}
