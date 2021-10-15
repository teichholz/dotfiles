{ config, options, lib, pkgs, my, ... }:

with lib;
with lib.my;
let cfg = config.modules.dev.tex;
in {
  options.modules.dev.tex = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      texlab
      texlive.combined.scheme-full
      python38Packages.pygments # used for minted
    ];
  };
}
