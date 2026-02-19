# ~/.config/fish/config.fish

if status is-interactive
  starship init fish | source
  zoxide init fish | source
  ~/.local/bin/mise activate fish | source
  tv init fish | source
end
