{config, pkgs, inputs, lib, nixos-hardware ,...}:
with lib;
{
    imports = [./hardware-configuration.nix
               ./modules.nix
               # nixos-hardware.lenovo-thinkpad-t495
              ];

    networking.hostName = "nixos";

    modules.hardware = {
        ergodox.enable = true;
        nvidia.enable = true;
        audio.enable = true;
    };

    i18n.defaultLocale = "de_DE.UTF-8";
    time.timeZone = "Europe/Berlin";

    location.latitude = 51.473;
    location.longitude = 7.479;
}
