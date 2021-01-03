{options, config, lib, pkgs, ...}:
with lib;
with lib.my;
with pkgs;
let cfg = config.modules.desktop.xmonad; in
{
  options.modules.desktop.xmonad = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      dunst
      libnotify
      xmobar
      (polybar.override {
        pulseSupport = true;
        nlSupport = true;
      })
    ];

    services = {
      xserver = {
        enable = true;
        displayManager = {
          defaultSession = "none+xmonad";
          lightdm.enable = true;
          lightdm.greeters.mini.enable = true;
        };
        windowManager.xmonad.enable = true;
        windowManager.xmonad.enableContribAndExtras = true;
      };
    };

    systemd.user.services."dunst" = {
      enable = true;
      description = "";
      wantedBy = [ "default.target" ];
      serviceConfig.Restart = "always";
      serviceConfig.RestartSec = 2;
      serviceConfig.ExecStart = "${pkgs.dunst}/bin/dunst";
    };


    env.XMONAD_CONFIG_DIR = "${XDG_CONFIG_HOME}/xmonad/xmonad.hs";

    home.configFile = {
      "sxhkd".source = "${configDir}/sxhkd";
      "xmonad" = {
        source = "${configDir}/xmonad";
        recursive = true;
      };
      "xmobar".source = "${configDir}/xmobar";
    };
  };
}