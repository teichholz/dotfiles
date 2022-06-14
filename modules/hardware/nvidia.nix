
{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.nvidia;
in {
  options.modules.hardware.nvidia = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {

    hardware.opengl.enable = true;
    # hardware.opengl.extraPackages = with pkgs; [ mesa ];
    services.xserver.videoDrivers = [ "nvidia" ];

    environment.systemPackages = with pkgs; [
      # Respect XDG conventions, damn it!
      mesa
      libGLU
      xorg.libX11
      libGL
      xorg.libXi
      xorg.libXmu
      freeglut
      glew
      xorg.libXrandr
      xorg.libXinerama
      xorg.libXcursor
      (writeScriptBin "nvidia-settings" ''
        #!${stdenv.shell}
        mkdir -p "$XDG_CONFIG_HOME/nvidia"
        exec ${config.boot.kernelPackages.nvidia_x11.settings}/bin/nvidia-settings --config="$XDG_CONFIG_HOME/nvidia/settings"
      '')
    ];
  };
}
