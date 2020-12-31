{config, pkgs, inputs, lib, ...}:
let path = /mnt/etc/nixos/hardware-configuration.nix; in 
{
    inherit system;
    imports = [(if (lib.pathExists path) then path else ./hardware-configuration.nix)];

    networking.hostName = "tim-pc";
    i18n.defaultLocale = mkDefault "de_DE.UTF-8";
    time.timeZone = mkDefault "Germany/Berlin";
}
