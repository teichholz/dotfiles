{ config, options, lib, pkgs, pkgs', ... }:

with lib;
with lib.my;
let cfg = config.modules.dev.java;
in {
  options.modules.dev.java = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      jdk11
      pkgs'.maven
      gradle
    ];
  };
}
