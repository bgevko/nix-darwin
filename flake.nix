{
  description = "nix-darwin + Home Manager config";
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
      user = "bgevko";
      system = "x86_64-darwin";
      mkDarwinHost =
        host: hostModulePath: homeModulePath:
        nix-darwin.lib.darwinSystem {
          inherit system;

          modules = [
            hostModulePath
            stylix.darwinModules.stylix
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = false;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.${user} = import homeModulePath;
                backupFileExtension = "backup";
              };
            }
          ];

          specialArgs = { inherit self inputs; };
        };
    in
    {
      # Shared HM modules
      home-manager.sharedModules = [
        sops-nix.homeModules.sops
      ];

      # Hosts
      darwinConfigurations = {
        "macbook-home" =
          mkDarwinHost "macbook-home" ./hosts/macbook-home/configuration.nix
            ./home/macbook-home.nix;
        "macbook-work" =
          mkDarwinHost "macbook-work" ./hosts/macbook-work/configuration.nix
            ./home/macbook-work.nix;
      };
    };
}
