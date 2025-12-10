{ pkgs, user, lib, ... }:
{
  home.username = user;
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Packages you want on both machines
  home.packages = with pkgs; [
    ripgrep
    fd
    fzf
    eza
    zoxide
    delta
    gh
    lazygit
    starship
    ncdu
    jq
  ];

  # Git config (replaces your git/config file)
  programs.git = {
    enable = true;
    settings = {
      user.name = "David Demaree";
      user.email = "david@demaree.me";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };

    ignores = [
      "**/.claude/settings.local.json"
    ];
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" "toml" "rust" "astro" "html" ];
    userSettings = {
      theme = {
        mode = "system";
        dark = "One Dark";
        light = "One Light";
      };
      hour_format = "hour24";
      vim_mode = true;
    };
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    shortcut = "a";
    mouse = true;
    extraConfig = ''
      # Automatically set window title
      set-window-option -g automatic-rename on
      set-option -g set-titles on

      # Default statusbar color
      set-option -g status-style bg=colour237,fg=colour223

      # Use | and - to split a window
      unbind '"'
      unbind %
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # Move around panes with hjkl
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Switch between panes using alt + arrow
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Use shift + arrow key to move between windows
      bind -n S-Left  previous-window
      bind -n S-Right next-window
    '';
  };

  programs.zoxide.enable = true;
  programs.fzf.enable = true;
  programs.starship.enable = true;
}
