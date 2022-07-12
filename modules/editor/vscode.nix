{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.my;
let cfg = config.modules.editors.vscode;
in {

  options.modules.editors.vscode = {
    enable = mkBoolOpt true;
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vscode
      vscode-extensions.ms-vscode.cpptools
    ];

  };
}
