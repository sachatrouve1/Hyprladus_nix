{

  description = "My flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };

  outputs = { self, nixpkgs, home-manager, nix-cachyos-kernel, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        modules = [
          (
            { pkgs, ... }:
            {
              nixpkgs.overlays = [
# Use the exact kernel versions as defined in this repo.
# Guarantees you have binary cache.
              nix-cachyos-kernel.overlays.pinned

# Alternatively, build the kernels on top of nixpkgs version in your flake.
# This might cause version mismatch/build failures!
              # nix-cachyos-kernel.overlays.default

# Only use one of the two overlays!
              ];
            }
          )
          ./configuration.nix
          ./modules/virtual_profiles.nix
          home-manager.nixosModules.home-manager {
# home-manager.useGlobalPkgs = true;
# home-manager.useUserPackages = true;
            home-manager.users.sacha = import ./home.nix;
          }
        ];
      };
    };
    # homeConfigurations = {
    #   sacha = home-manager.lib.homeManagerConfiguration {
    #     inherit pkgs;
    #     modules = [ 
    #         ./home.nix 
    #     ];
    #   }; 
    # };
  };

}
