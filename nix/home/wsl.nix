{ pkgs, lib, ... }:
{
  imports = [ ./cli.nix ];

  home.homeDirectory = lib.mkForce /home/david;

  # ZSH config for WSL
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
      ignoreDups = true;
      ignoreAllDups = true;
    };

    shellAliases = {
      ll = "eza -l";
      la = "eza -la";
      update = "home-manager switch --flake ~/Code/dotfiles/nix#david@wsl";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };
  };
}
