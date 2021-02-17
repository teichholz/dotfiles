# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "ahci" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  modules.hardware = {
    ergodox.enable = true;
    nvidia.enable = true;
  };

  # Displays
  # services.xserver = {
  #   # This must be done manually to ensure my screen spaces are arranged exactly
  #   # as I need them to be *and* the correct monitor is "primary". Using
  #   # xrandrHeads does not work.
  #   monitorSection = ''
  #     VendorName  "Unknown"
  #     ModelName   "DELL U2515H"
  #     HorizSync   30.0 - 113.0
  #     VertRefresh 56.0 - 86.0
  #     Option      "DPMS"
  #   '';
  #   screenSection = ''
  #     Option "metamodes" "HDMI-0: nvidia-auto-select +1920+0, DVI-I-1: nvidia-auto-select +0+180, DVI-D-0: nvidia-auto-select +4480+180"
  #     Option "SLI" "Off"
  #     Option "MultiGPU" "Off"
  #     Option "BaseMosaic" "off"
  #     Option "Stereo" "0"
  #     Option "nvidiaXineramaInfoOrder" "DFP-1"
  #   '';
  # };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/aaaaafd2-49de-41ff-bcc0-25cee5a0d852";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/E4E2-E454";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/ed90811f-49a3-41cf-aa42-4e30edc1dd21";
      fsType = "ext4";
    };

  swapDevices = [ ];

  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
}
