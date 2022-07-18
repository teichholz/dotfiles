{ config, options, lib, pkgs', ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.discord;
in {
  options.modules.desktop.apps.discord = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      # If not installed from the bleeding edge, Discord will sometimes
      # soft-lock itself on a "there's an update for discord" screen.
      discord
    ];

    home.configFile = {
        "discord/settings.json".text = ''
        {
          "BACKGROUND_COLOR": "#202225",
          "SKIP_HOST_UPDATE": true,
          "IS_MAXIMIZED": false,
          "IS_MINIMIZED": false,
          "WINDOW_BOUNDS": {
            "x": 2921,
            "y": 122,
            "width": 2124,
            "height": 1169
          }
        }
        '';
    };
  };


}
