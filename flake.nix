{
  inputs = 
    {
      # Core dependencies.
      # Two inputs so I can track them separately at different rates.
      nixpkgs.url          = "github:nixos/nixpkgs/nixos-unstable";
      nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
      home-manager.url   = "github:nix-community/home-manager";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";

      # Extras
      emacs-overlay.url  = "github:nix-community/emacs-overlay";
      nixos-hardware.url = "github:nixos/nixos-hardware";
    };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware , ... }:
    let lib = nixpkgs.lib.extend (self: super: { my = import ./lib { inherit pkgs inputs; lib = self; }; });
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; overlays = (lib.my.mapModules' ./overlays import) ; config.allowUnfree=true;};
        pkgs' = import nixpkgs-unstable { inherit system ; config.allowUnfree=true;};
    in
      {
        #origLib = lib;
        #lib = lib.my;  # for debugging with builtin.getFlake

        nixosConfigurations."nixos" =
          lib.nixosSystem {
            inherit system;
            modules = [
              home-manager.nixosModules.home-manager
              ./.
              ./host
            ] ++ (lib.my.mapModulesRec' (toString ./modules) import);
            specialArgs = { inherit inputs pkgs pkgs' lib home-manager nixos-hardware;};
          };
      };
}
