{ pkgs, lib, hostname, inputs, ... }:
{
  imports = [ ./shared.nix ];

  services.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
      environment = {
        USE_LAYER_SHELL = 1;
      };
    };
  };

  # ZSH config (moved from system level for consistency with Mac)
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
      update = "sudo nixos-rebuild switch --flake ~/Code/dotfiles#${hostname}";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      # theme handled by starship instead
    };
  };

  # Linux-specific packages (if any CLI tools are linux-only)
  home.packages = with pkgs; [
    # linux-specific CLI tools
    obsidian
    inputs.polypane.packages.x86_64-linux.polypane
  ];
}
