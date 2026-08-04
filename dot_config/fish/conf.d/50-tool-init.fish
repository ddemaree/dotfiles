# Shell integrations for optional CLI tools.
#
# Each tool is loaded only if its command is present, so a machine that is
# missing one (or provides it under a different package manager) starts
# cleanly instead of erroring — and a skipped tool prints a one-line note so
# it's obvious the integration didn't load. The command name is just the
# first word of each entry.
#
# Interactive sessions only: these are prompts, completions and keybindings,
# not needed in scripts.
if status is-interactive
    for integration in \
        "starship init fish" \
        "mise activate fish" \
        "zoxide init fish" \
        "fzf --fish" \
        "direnv hook fish" \
        "tv init fish"
        set -l tool (string split --field=1 ' ' -- $integration)
        if command --query $tool
            eval "$integration | source"
        else
            echo "fish: $tool not installed — skipping its shell integration" >&2
        end
    end

    # OpenClaw
    test -f "~/.openclaw/completions/openclaw.fish"; and source "~/.openclaw/completions/openclaw.fish"

    # LM Studio CLI
    if test -f "~/.lmstudio/bin"
        set -gx PATH $PATH ~/.lmstudio/bin
    end

    # OrbStack
    if test -f ~/.orbstack/shell/init2.fish
        source ~/.orbstack/shell/init2.fish 2>/dev/null || :
    end

end
