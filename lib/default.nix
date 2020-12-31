{lib}:
with lib;
let libs = [(import ./paths.nix) (import ./options.nix {inherit lib;})]; in
foldr (a: b: a // b) {} libs
     