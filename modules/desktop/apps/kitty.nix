{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.kitty;
in {
  options.modules.desktop.apps.kitty = {
    enable = mkBoolOpt true;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      kitty
    ];


    home.configFile = {
      "kitty" = { source = "${configDir}/kitty"; recursive = true; };
    };
  };
}