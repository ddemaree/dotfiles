# ~/.config/fish/config.fish

set -g fish_greeting
set -gx EDITOR nvim

if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx PNPM_HOME "$HOME/.local/share/pnpm"
    fish_add_path $PNPM_HOME
    fish_add_path ~/.local/bin

    alias la='eza -la'
    alias ll='eza -l'
    alias moi='chezmoi'

    starship init fish | source
    mise activate fish | source
    zoxide init fish | source
    fzf --fish | source
    direnv hook fish | source
    tv init fish | source
end
