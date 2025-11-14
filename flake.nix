{
  description = "Example nix-darwin system flake";
  nixConfig = {
    extra-substituters = [
      "https://cache.soopy.moe"
    ];
    extra-trusted-public-keys = [ "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo=" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      stylix,
      home-manager,
      ...
    }:
    {
      home-manager.sharedModules = [
        inputs.sops-nix.homeModules.sops
      ];
      darwinConfigurations."Bogdans-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./hosts/macbook/configuration.nix
          stylix.darwinModules.stylix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = false;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.bgevko = import ./home/bgevko-mac.nix;
              backupFileExtension = "backup";
            };
          }
        ];
        specialArgs = { inherit self inputs; };
      };
    };
}
