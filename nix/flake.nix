{
  description = "David's machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ghostty }:
  let
    user = "david";

    homeManagerConfig = {
      home-manager.backupFileExtension = "backup";
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit inputs user; };
    };
  in
  {
    darwinConfigurations."Davids-MacBook-Air" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = { inherit inputs user; };
      modules = [
        ./hosts/macbook-air
        home-manager.darwinModules.home-manager
        homeManagerConfig
        { home-manager.users.${user} = import ./home/darwin.nix; }
      ];
    };

    nixosConfigurations."nixon" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs user; };
      modules = [
        ./hosts/nixon
        home-manager.nixosModules.home-manager
        homeManagerConfig
        { home-manager.users.${user} = import ./home/linux.nix; }
      ];
    };

    nixosConfigurations."framewerk" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs user; };
      modules = [
        ./hosts/framewerk
        home-manager.nixosModules.home-manager
        homeManagerConfig
        { home-manager.users.${user} = import ./home/linux.nix; }
      ];
    };
  };
}
