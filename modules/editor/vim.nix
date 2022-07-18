{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.my;
let cfg = config.modules.editors.vim;
in {

  options.modules.editors.vim = {
    enable = mkBoolOpt true;
  };

  config = mkIf cfg.enable {
    programs.neovim.enable = true;
    # programs.neovim.coc.enable = true;
    # programs.neovim.vialias = true;

    home.configFile = {
      "nvim" = { source = "${configDir}/nvim"; recursive = true; };
    };
  };
}
