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
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland.url = "github:hyprwm/Hyprland";
    vicinae.url = "github:vicinaehq/vicinae";
    polypane.url = "github:mrtrimble/polypane-flake";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ghostty, nixos-hardware, hyprland, vicinae, polypane }:
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
      specialArgs = { inherit inputs user; hostname = "nixon"; };
      modules = [
        ./hosts/nixon
        home-manager.nixosModules.home-manager
        homeManagerConfig
        { home-manager.sharedModules = [ vicinae.homeManagerModules.default ]; }
        { home-manager.extraSpecialArgs = { hostname = "nixon"; }; }
        { home-manager.users.${user} = import ./home/linux.nix; }
      ];
    };

    nixosConfigurations."framewerk" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs user; hostname = "framewerk"; };
      modules = [
        ./hosts/framewerk
        home-manager.nixosModules.home-manager
        homeManagerConfig
        { home-manager.sharedModules = [ vicinae.homeManagerModules.default ]; }
        { home-manager.extraSpecialArgs = { hostname = "framewerk"; }; }
        { home-manager.users.${user} = import ./home/linux.nix; }
      ];
    };

    # Standalone home-manager for WSL
    homeConfigurations."david@wsl" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      extraSpecialArgs = { inherit inputs user; };
      modules = [ ./home/wsl.nix ];
    };
  };
}
