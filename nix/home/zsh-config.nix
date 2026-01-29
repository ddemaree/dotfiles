{ updateCommand, ... }:
{
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
      update = updateCommand;
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };
  };
}
