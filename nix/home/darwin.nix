{ pkgs, lib, ... }:
{
  imports = [ ./cli.nix ];

  home.homeDirectory = lib.mkForce /Users/david;

  # ZSH config for Mac
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
      update = "darwin-rebuild switch --flake ~/dotfiles#Davids-MacBook-Air";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };
  };
}
