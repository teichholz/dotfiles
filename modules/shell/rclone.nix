{ config, options, pkgs, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.shell.rclone;
in {
  options.modules.shell.rclone = {
    enable = true;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      rclone
      rclone-browser
    ];
  };
}
