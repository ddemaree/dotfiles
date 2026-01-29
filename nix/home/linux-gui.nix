{ pkgs, inputs, ... }:
{
  programs.zed-editor = {
    enable = true;
  };

  xdg.configFile."zed" = {
    source = ../../zed; # path relative to this nix file
    recursive = true;
  };

  # GUI packages for Linux desktop environments
  home.packages = with pkgs; [
    # Browsers
    google-chrome
    firefox-devedition
    warp-terminal

    # Development tools
    # vscode
    code-cursor
    ghostty

    # Communication
    discord
    slack

    # Productivity
    _1password-gui
    obsidian

    # Utilities
    geekbench
    davinci-resolve

    # External flake packages
    inputs.polypane.packages.x86_64-linux.polypane
  ];
}
