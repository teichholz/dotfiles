# modules/dev/lua.nix --- https://www.lua.org/

{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.dev.nix;
in {
  options.modules.dev.nix = {
    enable = mkBoolOpt true;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      rnix-lsp
    ];
  };
}
