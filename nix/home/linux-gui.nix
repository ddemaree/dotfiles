{ pkgs, inputs, ... }:
{
  # Vicinae service (Linux GUI only)
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

  # GUI packages for Linux desktop environments
  home.packages = with pkgs; [
    # Browsers
    chromium
    google-chrome

    # Development tools
    vscode
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

    # External flake packages
    inputs.polypane.packages.x86_64-linux.polypane
  ];
}
