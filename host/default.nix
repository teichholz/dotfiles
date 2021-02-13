{config, pkgs, inputs, lib, ...}:
with lib;
let pathMnt = /mnt/etc/nixos/hardware-configuration.nix; 
    pathRoot = /etc/nixos/hardware-configuration.nix; in 
{
    imports = [(if (lib.pathExists pathMnt) then pathMnt else if (lib.pathExists pathRoot) then pathRoot else ./hardware-configuration.nix)];
    networking.hostName = "tim-pc";
    i18n.defaultLocale = mkDefault "de_DE.UTF-8";
    time.timeZone = mkDefault "Germany/Berlin";

    # moonlander / ergodox / planck
    hardware.keyboard.zsa.enable = true;
    user.packages = with pkgs; [wally-cli];

    boot.loader.systemd-boot.enable = true; # (for UEFI systems only)
}
