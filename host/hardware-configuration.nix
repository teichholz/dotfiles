{modulesPath, ...}:
{
    imports = ["${modulesPath}/installer/scan/not-detected.nix"];

    boot.loader.systemd-boot.enable = true; # (for UEFI systems only)
    fileSystems."/".device = "/dev/disk/by-label/nixos";
}