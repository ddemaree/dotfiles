{
  description = "David's machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nix-darwin = {
    #   url = "github:LnL7/nix-darwin";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty.url = "github:ghostty-org/ghostty";
    hyprland.url = "github:hyprwm/Hyprland";
    polypane.url = "github:mrtrimble/polypane-flake";
    llm-agents.url = "github:numtide/llm-agents.nix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    { nixpkgs, ... }@inputs:
    {
      nixosConfigurations."framewerk" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          user = {
            name = "david";
            email = "david@demaree.me";
          };
          hostname = "framewerk";
        };
        modules = [
          inputs.nixos-hardware.nixosModules.framework-16-amd-ai-300-series-nvidia
          ./framewerk
          # ./framewerk/hardware-configuration.nix
          # ./framewerk/nvidia.nix
          # ./framewerk/sound.nix
          # ./framewerk/usb.nix
          # ./framewerk/keyboard.nix
          # ./framewerk/time.nix
          # ./framewerk/zram-swap.nix
          # ./framewerk/bootloader.nix
          # ./framewerk/nix-settings.nix?
          # ./framewerk/nixpkgs.nix
          ./framewerk/theme.nix
          ./framewerk/i18n.nix
          ./framewerk/fonts.nix
          ./framewerk/security.nix
          ./framewerk/services.nix
          ./framewerk/power.nix
          # ./framewerk/gnome.nix
          ./framewerk/hyprland.nix
          # ./framewerk/bluetooth.nix # I think the hardware module covers this?
          ./framewerk/networking.nix
          ./framewerk/vpn.nix
          ./framewerk/openssh.nix
          ./framewerk/users.nix
          ./framewerk/virtualisation.nix
          ./framewerk/dev-tools.nix
          ./framewerk/system-info.nix
          ./framewerk/llms.nix
        ];
      };
    };
}
