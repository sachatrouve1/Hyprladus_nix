{

  description = "My flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs"; 
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
	    modules = [
          modules/configuration.nix
          modules/greetd.nix
          modules/blueman.nix
        ];
      };
    };
    homeConfigurations = {
      sacha = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	    modules = [
          home-modules/home.nix
          home-modules/zsh.nix
          home-modules/vscode.nix
          home-modules/thunar.nix
          home-modules/librewoldf.nix
        ];
      }; 
    };
  };

}
