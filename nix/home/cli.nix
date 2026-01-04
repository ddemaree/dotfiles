{ pkgs, user, lib, ... }:
{
  home.username = user;
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # CLI packages shared across all platforms (Linux, macOS, WSL)
  home.packages = with pkgs; [
    # Core CLI tools
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
    wget
    unzip

    # Development tools
    nodejs_24
    pnpm_9
    bun
    tmux
    mise
    claude-code

    # Fonts (for terminal use)
    jetbrains-mono
    inter
    ibm-plex
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
