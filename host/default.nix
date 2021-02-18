{config, pkgs, inputs, lib, ...}:
with lib;
{
    imports = [./hardware-configuration.nix ./modules.nix];
    networking.hostName = "nixos";

    i18n.defaultLocale = "de_DE.UTF-8";
    time.timeZone = "Germany/Berlin";

    location.latitude = 51.473;
    location.longitude = 7.479;
}
