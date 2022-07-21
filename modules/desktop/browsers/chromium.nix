{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.browsers.chromium;
in {
  options.modules.desktop.browsers.chromium = with types; {
    enable = mkBoolOpt true;
  };

  config = mkIf cfg.enable (mkMerge [
    {
      user.packages = with pkgs; [
        chromium
        chromedriver
        (makeDesktopItem {
          name = "chromium-private";
          desktopName = "Chromium (Private)";
          genericName = "Open a private Chromium window";
          icon = "chromium";
          exec = "${chromium}/bin/chromium --incognito";
          categories = ["Network"];
        })
      ];
      env.XDG_DESKTOP_DIR = "$HOME/";
      env.BROWSER = "chromium";
    }
  ]);
}

