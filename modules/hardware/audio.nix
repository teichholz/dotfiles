{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.audio;
in {
  options.modules.hardware.audio = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {

    user.packages = with pkgs; [pavucontrol];

    sound.enable = true;
    hardware.pulseaudio.enable = true;
    hardware.bluetooth.enable = true;

    user.extraGroups = [ "audio" ];
  };
}
