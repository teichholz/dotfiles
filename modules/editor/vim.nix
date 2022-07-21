{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.my;
let cfg = config.modules.editors.vim;
in {

  options.modules.editors.vim = {
    enable = mkBoolOpt true;
  };

  config = mkIf cfg.enable {
  environment.systemPackages = with pkgs; [
    neovim
  ];
    # home.configFile = {
    #   "nvim" = { source = "${configDir}/nvim"; recursive = true; };
    # };
  };
}
