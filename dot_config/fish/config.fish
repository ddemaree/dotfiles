# ~/.config/fish/config.fish

# =============================================================================
# CACHYOS DEFAULT CONFIG
# =============================================================================
# CachyOS stores its excellent default shell tweaks here.
# We source it only if it exists (Linux), ignoring it completely on macOS.
if test -f /usr/share/cachyos-fish-config/cachyos-config.fish
    source /usr/share/cachyos-fish-config/cachyos-config.fish
end

# PATH and the per-tool shell integrations (starship, mise, zoxide, fzf,
# direnv, tv) live in conf.d/, which fish sources before this file — see
# 00-homebrew.fish, 10-path.fish and 50-tool-init.fish.

set -g fish_greeting
set -gx EDITOR nvim

if status is-interactive
    alias la='eza -la'
    alias ll='eza -l'
    alias moi='chezmoi'
end
