#!/bin/sh
# The small set of macOS preferences that actually differ from stock.
# Everything not listed here is deliberately left at Apple's default.
set -eu
[ "$(uname)" = Darwin ] || exit 0

echo "==> macOS defaults"

# appearance
defaults write -g AppleInterfaceStyle -string Dark
defaults write com.apple.dock autohide -bool true

# finder: list view, status bar, new windows open on Recents
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder NewWindowTarget -string PfAF

# menu bar clock: weekday + AM/PM, no date
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
defaults write com.apple.menuextra.clock ShowAMPM -bool true
defaults write com.apple.menuextra.clock ShowDate -int 0

# Laptop-only settings the Mac mini never needed. Uncomment deliberately.
# defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
# defaults write -g InitialKeyRepeat -int 15
# defaults write -g KeyRepeat -int 2

# Running apps rewrite their prefs on quit, so restart the ones we touched.
killall Finder Dock SystemUIServer 2>/dev/null || true
