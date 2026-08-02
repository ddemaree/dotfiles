# Multi-platform Homebrew initialization (Apple Silicon, Linuxbrew, Intel Mac).
#
# This lives in conf.d — which fish sources *before* config.fish — and is
# numbered early so that brew-installed tools are on PATH before the tool
# loaders in 50-tool-init.fish run their presence checks. zoxide, for one,
# is currently a Homebrew package.
for brew_binary in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew /usr/local/bin/brew
    if test -x $brew_binary
        $brew_binary shellenv | source
        break # Stop once we find a valid Homebrew install
    end
end
