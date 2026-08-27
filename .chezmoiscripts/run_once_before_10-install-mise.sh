#!/bin/sh
# mise installs to ~/.local/bin rather than via Homebrew. conf.d/10-path.fish
# puts that directory on PATH *before* 50-tool-init.fish runs its presence
# checks, so a Homebrew mise would load in the wrong order.
set -eu

[ -x "$HOME/.local/bin/mise" ] && exit 0

echo "==> installing mise into ~/.local/bin"
mkdir -p "$HOME/.local/bin"
curl -fsSL https://mise.run | MISE_INSTALL_PATH="$HOME/.local/bin/mise" sh
