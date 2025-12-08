{
  description = "My system configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
        url = "github:LnL7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ghostty }:
  let
    configuration = { pkgs, ... }: {
      system.primaryUser = "david";
      nix.enable = false;

      documentation.enable = false;
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
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

      # Enable Touch ID for sudo
      security.pam.services.sudo_local.touchIdAuth = true;

      # Homebrew integration (for casks and GUI apps)
      homebrew.enable = true;
      homebrew.brews = [
      ];
      homebrew.casks = [
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
      homebrew.masApps = {
        "Acorn" = 6737921844;
        "Things 3" = 904280696;
      };

      system.defaults.dock.autohide = true;

      system.defaults.dock.persistent-apps = [
        {
          app = "/Applications/Google Chrome.app";
        }
        {
          app = "/Applications/Ghostty.app";
        }
        {
          app = "/Applications/Zed.app";
        }
        {
          app = "/Applications/Things3.app";
        }
      ];

      system.defaults.dock.show-recents = false;

      system.defaults.NSGlobalDomain = {
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.trackpad.scaling" = 1.5;
      };

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
    homeconfig = {pkgs, lib, ...}: {
      # this is internal compatibility configuration
      # for home-manager, don't change this!
      # home.stateVersion = "23.05";
      home.stateVersion = "24.11";

      # Let home-manager install and manage itself.
      programs.home-manager.enable = true;

      home.packages = with pkgs; [];

      home.sessionVariables = {
        EDITOR = "nvim";
      };

      home.username = "david";
      home.homeDirectory = lib.mkForce /Users/david;

      programs.neovim = {
        enable = true;
        defaultEditor = true;
        vimAlias = true;
      };

      programs.tmux = {
        enable = true;
        keyMode = "vi";
        shortcut = "a";
        extraConfig = ''
          # Enable mouse mode
          set -g mouse on

          # Automatically set window title
          set-window-option -g automatic-rename on
          set-option -g set-titles on

          # Default statusbar color
          set-option -g status-style bg=colour237,fg=colour223 # bg=bg1, fg=fg1

          # Use | and - to split a window vertically and horizontally instead of " and % respoectively
          unbind '"'
          unbind %
          bind | split-window -h -c "#{pane_current_path}"
          bind - split-window -v -c "#{pane_current_path}"

          # Move around panes with hjkl, as one would in vim after pressing ctrl + w
          bind h select-pane -L
          bind j select-pane -D
          bind k select-pane -U
          bind l select-pane -R

          # Switch betewen panes using alt + arrow
          bind -n M-Left select-pane -L
          bind -n M-Right select-pane -R
          bind -n M-Up select-pane -U
          bind -n M-Down select-pane -D

          # Use shift + arrow key to move between windows in a session
          bind -n S-Left  previous-window
          bind -n S-Right next-window
        '';
      };
    };
  in
  {
    darwinConfigurations."Davids-MacBook-Air" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        home-manager.darwinModules.home-manager {
          home-manager.backupFileExtension = "backup";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.verbose = true;
          home-manager.users.david = homeconfig;
        }
      ];
    };
  };
}
