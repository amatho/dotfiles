{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    inputs@{ nix-darwin, home-manager, ... }:
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Amandus-sin-MacBook-Pro-2
      darwinConfigurations."Amandus-sin-MacBook-Pro-2" = nix-darwin.lib.darwinSystem rec {
        specialArgs = { inherit inputs; };
        modules = [
          ./nix/hosts/darwin
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.amatho = ./nix/home;
            home-manager.extraSpecialArgs = specialArgs;
          }
        ];
      };
    };
}
