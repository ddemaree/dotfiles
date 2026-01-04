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
    jetbrains-mono
    inter
    ibm-plex
    nodejs_24
    pnpm_9
    bun
    tmux
    mise
    claude-code
    _1password-gui
    chromium
    google-chrome
    vscode
    code-cursor
    ghostty
    discord
    slack
    geekbench
    wget
    unzip
  ];

  programs.git.enable = true;

  xdg.configFile."git" = {
    source = ../../git;  # path relative to this nix file
    recursive = true;
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
    # extensions = [ "nix" "toml" "rust" "astro" "html" ];
    # userSettings = {
    #   # buffer_font_family = "Berkeley Mono, JetBrains Mono, monospace";
    #   buffer_font_size = 14;
    #   theme = {
    #     mode = "system";
    #     dark = "One Dark";
    #     light = "One Light";
    #   };
    #   hour_format = "hour24";
    #   vim_mode = true;
    # };
  };

  xdg.configFile."zed" = {
    source = ../../zed;  # path relative to this nix file
    recursive = true;
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

  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  programs.zoxide.enable = true;
  programs.fzf.enable = true;
  programs.starship.enable = true;
}
