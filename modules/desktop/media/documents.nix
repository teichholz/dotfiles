# modules/desktop/media/docs.nix

{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.media.documents;
in {
  options.modules.desktop.media.documents = {
    enable = mkBoolOpt true;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      calibre
      evince
      zathura
      (makeDesktopItem {
        name = "evince";
        desktopName = "Evince";
        icon = "evince";
        exec = "${pkgs.evince}/bin/evince";
      })
    ];

    home.configFile."zathura".source = "${configDir}/zathura";
  };
}
