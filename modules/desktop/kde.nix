{options, config, lib, pkgs, ...}:
with lib;
with lib.my;
let cfg = config.modules.desktop.kde; in
{
  options.modules.desktop.kde = {
    enable = mkBoolOpt true;
  };

  config = mkIf cfg.enable {
    services.xserver.displayManager.sddm = {
      enable = true;
      enableHidpi = true;
    };
    services.xserver.desktopManager.plasma5.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];
  };
}