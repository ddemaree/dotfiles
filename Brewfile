# Brewfile — the top-level Homebrew install, nothing more.
# Applied by .chezmoiscripts/run_onchange_after_20-brew-bundle.sh.tmpl
#
# Dependencies are deliberately not listed: php arrives with composer,
# node and ripgrep arrive with opencode. Listing them would pin packages
# we don't actually have an opinion about.

tap "ddev/ddev"
tap "steipete/tap"

# ---------- shell ----------
brew "fish"
brew "starship"
brew "zoxide"
brew "fzf"
brew "direnv"
brew "television"          # provides `tv`
brew "eza"                 # config.fish aliases la/ll to this
brew "tmux"

# ---------- git ----------
brew "git"
brew "git-delta"
brew "gh"
brew "lazygit"

# ---------- editing + dotfiles ----------
brew "neovim"
brew "chezmoi"

# ---------- web / PHP ----------
brew "composer"            # pulls php
brew "ddev/ddev/ddev"
brew "mkcert"
brew "dnsmasq"

# ---------- media + misc ----------
brew "ffmpeg"
brew "imagemagick"
brew "sevenzip"
brew "wget"
brew "opencode"            # pulls node + ripgrep
brew "steipete/tap/imsg"
brew "dockutil"            # drives the Dock script

# Deliberately absent: tailscale. The Mac app ships its own CLI, so the
# formula duplicates it; it's there for headless Linux.
# Deliberately absent: nvm. mise owns Node.

# ---------- casks ----------
cask "1password"
cask "1password-cli"
cask "raycast"
cask "ghostty"
cask "betterdisplay"

cask "zed"
cask "cursor"
cask "orbstack"
cask "linear-linear"

cask "google-chrome"
cask "firefox@developer-edition"
cask "polypane"

cask "cleanshot"
cask "screen-studio"
cask "loom"
cask "figma"

cask "slack"
cask "discord"
cask "zoom"
cask "granola"
cask "mimestream"
cask "superhuman"
cask "fantastical"

cask "notion"
cask "obsidian"
cask "google-drive"

cask "elgato-control-center"
cask "elgato-stream-deck"
cask "elgato-camera-hub"
cask "elgato-wave-link"
