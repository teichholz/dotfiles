{options, config, lib, pkgs, pkgs', ...}:
with lib;
with lib.my;
let cfg = config.modules.desktop.gnome; in
{
  options.modules.desktop.gnome = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };
      # use gnomes builtin night mode
      # redshift = {
      #   enable = true;
      #   temperature.night = 2500;
      # };
    };

    environment.systemPackages = with pkgs; [
      gnome3.gnome-tweaks
      gnomeExtensions.dash-to-dock
    ];
  };
}
