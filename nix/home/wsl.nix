{ pkgs, lib, ... }:
{
  imports = [
    ./cli.nix
    (import ./zsh-config.nix {
      updateCommand = "home-manager switch --flake ~/Code/dotfiles/nix#david@wsl";
    })
  ];

  home.homeDirectory = lib.mkForce /home/david;
}
