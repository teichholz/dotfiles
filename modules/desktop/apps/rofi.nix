{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.rofi;
in {
  options.modules.desktop.apps.rofi = {
    enable = mkBoolOpt true;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      (writeScriptBin "rofi" ''
        #!${stdenv.shell}
        exec ${pkgs.rofi}/bin/rofi -terminal kitty -m -1 "$@"
      '')
      pkgs.rofi

      # Fake rofi dmenu entries
      (makeDesktopItem {
        name = "rofi-bookmarkmenu";
        desktopName = "Open Bookmark in Browser";
        icon = "bookmark-new-symbolic";
        exec = "${binDir}/rofi/bookmarkmenu";
      })
      (makeDesktopItem {
        name = "rofi-filemenu";
        desktopName = "Open Application";
        icon = "folder";
        exec = "${binDir}/rofi/appmenu";
      })
      (makeDesktopItem {
        name = "rofi-filemenu";
        desktopName = "Open Directory in Terminal";
        icon = "folder";
        exec = "${binDir}/rofi/filemenu";
      })
      (makeDesktopItem {
        name = "rofi-systemmenu";
        desktopName = "Open Directory in Terminal";
        icon = "folder";
        exec = "${binDir}/rofi/powermenu";
      })
      (makeDesktopItem {
        name = "rofi-filemenu-scratch";
        desktopName = "Open Directory in Scratch Terminal";
        icon = "folder";
        exec = "${binDir}/rofi/filemenu -x";
      })
    ];
  };
}
