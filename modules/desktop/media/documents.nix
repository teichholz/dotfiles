# modules/desktop/media/docs.nix

{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.media.documents;
in {
  options.modules.desktop.media.documents = {
    enable = mkBoolOpt true;
    pdf.enable = mkBoolOpt true;
    ebook.enable = mkBoolOpt true;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      (mkIf cfg.ebook.enable calibre)
      (mkIf cfg.pdf.enable evince)
      (mkIf cfg.pdf.enable zathura)
    ];

    home.configFile."zathura".source = mkIf cfg.pdf.enable "${configDir}/zathura";
  };
}
