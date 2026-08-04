{ updateCommand, ... }:
{
  programs.fish = {
    enable = true;

    shellAliases = {
      ll = "eza -l";
      la = "eza -la";
      update = updateCommand;
    };
  };
}
