{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.browsers.firefox;
in {
  options.modules.desktop.browsers.firefox = with types; {
    enable = mkBoolOpt true;
    profileName = mkOpt types.str config.user.name;

    settings = mkOpt' (attrsOf (oneOf [ bool int str ])) {} ''
      Firefox preferences to set in <filename>user.js</filename>
    '';
  };

  config = mkIf cfg.enable (mkMerge [
    {
      user.packages = with pkgs; [
        firefox-bin
        # (makeDesktopItem {
        #   name = "firefox-private";
        #   desktopName = "Firefox (Private)";
        #   genericName = "Open a private Firefox window";
        #   icon = "firefox";
        #   exec = "${firefox-bin}/bin/firefox --private-window";
        #   categories = "Network";
        # })
      ];

      # Prevent auto-creation of ~/Desktop. The trailing slash is necessary; see
      # https://bugzilla.mozilla.org/show_bug.cgi?id=1082717
      env.XDG_DESKTOP_DIR = "$HOME/";

      modules.desktop.browsers.firefox.settings = {
        "devtools.theme" = "dark";
        # Enable userContent.css and userChrome.css for our theme modules
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        # Stop creating ~/Downloads!
        "browser.download.dir" = "${homeDir}/dl";
      };

    }
  ]);
}

