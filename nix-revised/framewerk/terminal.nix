{ pkgs, ... }:

{
  programs.fish.enable = true;

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
      set -g mouse on

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

  environment.systemPackages = with pkgs; [
    cool-retro-term

    eza
    helix
    ripgrep
    ncdu
    jq
    chafa
    wget
    unzip
    xclip
    xsel

    # moreutils
    # file
    # upx

    # mermaid-cli
    # posting
    # xh
    # process-compose

    # zellij
    # progress
    # noti
    # topgrade
    # nix-ai-tools.ck
    # rewrk
    # wrk2
    # procs
    # tealdeer

    # monolith
    # # taskwarrior3
    # asciinema
    # asciinema-agg
    # aria2
    # # wormhole-william
    # magic-wormhole-rs
    # rage
    # age-plugin-fido2-hmac
    # age-plugin-sss
    # ragenix
    # croc
    # # macchina #neofetch alternative in rust
    # yt-dlp
    # doggo
    # sd
    # ouch
    # duf
    # dust
    fd
    # trash-cli
    # tokei
    # bat
    # hexyl
    # mdcat
    # pandoc
    # lsd
    # lsof
    # gping
    # viu
    # tre-command
    # yazi
    # jrnl
    # python313Packages.faker

    # cmatrix
    # pipes-rs
    # rsclock
    # cava
    # figlet
    # lolcat
    # cbonsai
  ];
}
