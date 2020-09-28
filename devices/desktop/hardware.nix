{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # consider amdgpu.gpu_recovery = 1
  boot.extraModprobeConfig = "options amdgpu.dpm=0 amdgpu.aspm=0 amdgpu.runpm=0 amdgpu.bapm=0 amdgpu.dc=0 amdgpu.audio=0";

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/668876bd-e1a6-4215-8f1e-834cb5e7546a";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/6B39-01B1";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/afc4fcea-5154-4bbd-9e50-541a5c8f5d7b";
      fsType = "ext4";
    };

  networking.interfaces.enp0s31f6.useDHCP = true;

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
