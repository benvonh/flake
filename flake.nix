{
  description = "My Home Manager Nix Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim/nixos-23.11";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;

      lib = nixpkgs.lib // home-manager.lib;

      systems = [
        "i686-linux"
        "x86_64-linux"
        "aarch64-linux"

        "x86_64-darwin"
        "aarch64-darwin"
      ];

      pkgsFor = lib.genAttrs systems (system: import nixpkgs { inherit system; });

      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
    in
    {
      homeManagerModules = import ./modules;

      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      homeConfigurations = {
        ben = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./users/ben.nix ];
        };
      };
    };
}
