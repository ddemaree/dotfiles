{ pkgs, lib, ... }:
{
  imports = [
    ./cli.nix
    (import ./zsh-config.nix {
      updateCommand = "darwin-rebuild switch --flake ~/dotfiles#Davids-MacBook-Air";
    })
  ];

  home.homeDirectory = lib.mkForce /Users/david;
}
