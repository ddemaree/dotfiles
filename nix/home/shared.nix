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
    userName = "David Demaree";
    userEmail = "david@demaree.me";

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };

    delta.enable = true;  # you already have delta installed

    ignores = [
      "**/.claude/settings.local.json"
    ];
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
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
