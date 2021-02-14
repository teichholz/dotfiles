{
  inputs = 
    {
      # Core dependencies.
      # Two inputs so I can track them separately at different rates.
      nixpkgs.url          = "nixpkgs/nixos-unstable";

      home-manager.url   = "github:rycee/home-manager/master";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";

      # Extras
      emacs-overlay.url  = "github:nix-community/emacs-overlay";
      nixos-hardware.url = "github:nixos/nixos-hardware";
    };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
  let lib = nixpkgs.lib.extend (self: super: { my = import ./lib { inherit pkgs inputs; lib = self; }; });
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; overlays = [ inputs.emacs-overlay.overlay ] ; config.allowUnfree=true;};
  in
    {
      origLib = lib;
      lib = lib.my;  # for debugging with builtin.getFlake
      nixosConfigurations."nixos" =
      lib.nixosSystem {
        inherit system;
        modules = [
          home-manager.nixosModules.home-manager
          ./.
          ./host
        ] ++ (lib.my.mapModulesRec' (toString ./modules) import);
        specialArgs = { inherit inputs pkgs lib home-manager;};
      };
    };
}
