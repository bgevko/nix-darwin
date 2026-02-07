{
  description = "nix-darwin + Home Manager config";

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
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{
      self,
      nix-darwin,
      home-manager,
      stylix,
      sops-nix,
      ...
    }:
    let
      host = "Bogdans-MacBook-Pro";
      user = "bgevko";
      system = "x86_64-darwin";
    in
    {
      # Shared HM modules
      home-manager.sharedModules = [
        sops-nix.homeModules.sops
      ];

      darwinConfigurations.${host} = nix-darwin.lib.darwinSystem {
        inherit system;

        modules = [
          ./hosts/macbook/configuration.nix
          stylix.darwinModules.stylix
          home-manager.darwinModules.home-manager

          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              extraSpecialArgs = { inherit inputs; };
              users.${user} = import ./home/${user}-mac.nix;

              backupFileExtension = "backup";
            };
          }
        ];
        specialArgs = { inherit self inputs; };
      };
    };
}
