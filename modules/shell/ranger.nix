{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.ranger;
in {
  options.modules.shell.ranger = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      ranger
    ];

    home.configFile = {
      "ranger" = { source = "${configDir}/zsh"; };
    };

  };
}
