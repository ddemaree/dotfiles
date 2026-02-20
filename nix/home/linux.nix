{ pkgs, lib, hostname, inputs, ... }:
{
  imports = [
    ./cli.nix
    ./linux-gui.nix
    ./hyprland.nix
    (import ./zsh-config.nix {
      updateCommand = "sudo nixos-rebuild switch --flake ~/Code/dotfiles/nix#${hostname}";
    })
    (import ./fish-config.nix {
      updateCommand = "sudo nixos-rebuild switch --flake ~/Code/dotfiles/nix#${hostname}";
    })
  ];
}
