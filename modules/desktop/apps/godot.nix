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

      (writeScriptBin "godot-kotlin-wrapper" ''
        #!${stdenv.shell}
        exec JAVA_HOME=$JAVA_HOME godot-kotlin
      '')

      (makeDesktopItem {
        name = "godot-kotlin";
        desktopName = "Godot (Kotlin)";
        genericName = "Open Godot Kotlin";
        icon = "godot";
        exec = "godot-kotlin-wrapper";
        categories = ["Application"];
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
