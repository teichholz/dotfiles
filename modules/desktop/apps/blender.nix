{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.blender;
in {
  options.modules.desktop.apps.blender = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      blender
      (makeDesktopItem {
        name = "Blender";
        desktopName = "Blender";
        genericName = "Open Blender";
        icon = "blender";
        exec = "blender";
        categories = ["Graphics"];
      })
    ];
  };
}
