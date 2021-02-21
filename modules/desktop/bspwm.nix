{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.bspwm;
in {
  options.modules.desktop.bspwm = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    modules.theme.onReload.bspwm = ''
      ${pkgs.bspwm}/bin/bspc wm -r
      source $XDG_CONFIG_HOME/bspwm/bspwmrc
    '';

    environment.systemPackages = with pkgs; [
      lightdm
      dunst
      libnotify
      (polybar.override {
        pulseSupport = true;
        nlSupport = true;
      })
    ];

    services = {
      picom.enable = true;
      redshift.enable = true;
      xserver = {
        enable = true;
        displayManager = {
          defaultSession = "none+bspwm";
          lightdm.enable = true;
          lightdm.greeters.mini.enable = true;
        };
        windowManager.bspwm = {
          enable = true;
        };
      };
    };

    home-manager = {
      users.${config.user.name} = {
        services.sxhkd.enable = true;
        xsession.enable = true;
        xsession.windowManager.bspwm.enable = true;
        xsession.windowManager.bspwm.extraConfig = builtins.readFile (builtins.toPath "${configDir}/bspwm/bspwmrc");
        services.sxhkd.extraConfig = builtins.readFile (builtins.toPath "${configDir}/sxhkd/sxhkdrc");
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

    # link recursively so other modules can link files in their folders
    # home.configFile = {
    #   # "sxhkd".source = "${configDir}/sxhkd";
    #   "bspwm" = {
    #     source = "${configDir}/bspwm";
    #     recursive = true;
    #   };
    # };
  };
}
