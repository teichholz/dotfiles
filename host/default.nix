{config, pkgs, inputs, lib, ...}:
with lib;
{
    imports = [./hardware-configuration.nix ./modules.nix];
    networking.hostName = "nixos";

    i18n.defaultLocale = "de_DE.UTF-8";
    time.timeZone = "Germany/Berlin";

    # moonlander / ergodox / planck
    hardware.keyboard.zsa.enable = true;
    user.packages = with pkgs; [wally-cli];
}
