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
      godot-kotlin

      (makeDesktopItem {
        name = "godot-kotlin";
        desktopName = "Godot (Kotlin)";
        genericName = "Open Godot Kotlin";
        icon = "godot";
        exec = "godot-kotlin";
      })

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
