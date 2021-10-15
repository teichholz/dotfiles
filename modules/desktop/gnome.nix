{options, config, lib, pkgs, ...}:
with lib;
with lib.my;
let cfg = config.modules.desktop.gnome; in
{
  options.modules.desktop.gnome = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm = {
      enable = true;
    };
    services.xserver.desktopManager.gnome.enable = true;
  };
}
