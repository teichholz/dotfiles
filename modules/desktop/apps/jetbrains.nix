{ config, options, lib, pkgs, ... }:

with lib;

with lib.my;
let cfg = config.modules.desktop.apps.jetbrains;
in {
  options.modules.desktop.apps.jetbrains = {
    enable = mkBoolOpt true;
  };

  config = {
    user.packages = with pkgs; [
      jetbrains.idea-ultimate
      jetbrains.clion
    ];
  };
}
