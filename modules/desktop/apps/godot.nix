{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.godot;
in {
  options.modules.desktop.apps.godot = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      godot
      godot-mono

      (makeDesktopItem {
        name = "godot-mono";
        desktopName = "Godot (Mono)";
        genericName = "Open Godot Mono";
        icon = "godot";
        exec = "godot-mono";
      })
    ];
  };
}
