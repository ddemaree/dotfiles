{ pkgs, user, ... }:
{
  system.primaryUser = user;
  nix.enable = false;
  documentation.enable = false;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    nodejs_24
    pnpm_9
    fzf
    zoxide
    ripgrep
    eza
    delta
    bun
    nodenv
    gh
    lazygit
    starship
    ncdu
    tmux
    fd
    mise
    claude-code
  ];

  security.pam.services.sudo_local.touchIdAuth = true;

  homebrew = {
    enable = true;
    brews = [];
    casks = [
      "1password"
      "raycast"
      "ghostty"
      "google-chrome"
      "google-drive"
      "zed"
      "slack"
      "figma"
      "zoom"
      "cleanshot"
      "mimestream"
      "superhuman"
      "claude"
      "granola"
      "notion"
    ];
    masApps = {
      "Acorn" = 6737921844;
      "Things 3" = 904280696;
    };
  };

  system.defaults = {
    dock = {
      autohide = true;
      show-recents = false;
      persistent-apps = [
        { app = "/Applications/Google Chrome.app"; }
        { app = "/Applications/Ghostty.app"; }
        { app = "/Applications/Zed.app"; }
        { app = "/Applications/Things3.app"; }
      ];
    };
    NSGlobalDomain = {
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.trackpad.scaling" = 1.5;
    };
  };

  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
