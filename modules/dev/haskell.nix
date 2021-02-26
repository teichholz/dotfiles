# modules/dev/cc.nix --- C & C++
#
# I love C. I tolerate C++. I adore C with a few choice C++ features tacked on.
# Liking C/C++ seems to be an unpopular opinion. It's my guilty secret, so don't
# tell anyone pls.

{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.dev.haskell;
in {
  options.modules.dev.haskell = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      stack
      hlint # linter
      ormolu # formatting
      haskell-language-server
    ];

  };
}
