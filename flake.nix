{
  inputs = 
    {
      # Core dependencies.
      # Two inputs so I can track them separately at different rates.
      nixpkgs.url          = "github:nixos/nixpkgs/nixos-unstable";

      home-manager.url   = "github:rycee/home-manager/master";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";

      # Extras
      emacs-overlay.url  = "github:nix-community/emacs-overlay";
      nixos-hardware.url = "github:nixos/nixos-hardware";
    };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
  let lib = nixpkgs.lib // (import ./lib {lib = nixpkgs.lib;});
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; overlays = [ inputs.emacs-overlay.overlay ] ; config.allowUnfree=true;};
  in
    {

      nixosConfigurations."nixos" =
      lib.nixosSystem {
        inherit system;
        modules = [
          home-manager.nixosModules.home-manager
          ./default.nix
          ./host/hardware-configuration.nix
          ./host/modules.nix
          ./modules/desktop.nix
          ./modules/options.nix
          ./modules/emacs.nix 
          ./modules/xdg.nix
          ./modules/zsh.nix
        ];
        specialArgs = { inherit inputs pkgs lib home-manager;};
      };
    };
}