#!/bin/sh
# Rebuilds the Dock from scratch. Order here is the order on screen.
set -eu
[ "$(uname)" = Darwin ] || exit 0
command -v dockutil >/dev/null 2>&1 || { echo "dockutil not found — skipping Dock" >&2; exit 0; }

echo "==> rebuilding Dock"
dockutil --no-restart --remove all

for app in \
    "Ghostty" "Zed" "Google Chrome" "Polypane" "1Password" \
    "Claude" "ChatGPT" "Cursor" "Grok Bot" \
    "Mimestream" "Superhuman" "Figma" "Discord" "Granola" "Slack" "Notion"
do
    if [ -d "/Applications/$app.app" ]; then
        dockutil --no-restart --add "/Applications/$app.app"
    else
        echo "   skipped (not installed): $app" >&2
    fi
done

# Apple's own apps live under /System/Applications.
for app in "Messages" "Photos" "Notes" "Music"; do
    [ -d "/System/Applications/$app.app" ] && \
        dockutil --no-restart --add "/System/Applications/$app.app"
done

dockutil --no-restart --add "$HOME/Downloads" \
    --view fan --display stack --sort dateadded

killall Dock
