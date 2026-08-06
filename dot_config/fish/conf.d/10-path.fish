# User-local binaries.
#
# This has to happen in conf.d (sourced before config.fish) and after
# Homebrew, so that tools installed outside a package manager — mise, for one,
# which installs to ~/.local/bin — are on PATH before 50-tool-init.fish runs
# its presence checks.
#
# --global rather than the fish_add_path default of a universal variable: the
# universal one is machine state living outside this repo, so it makes a fresh
# checkout behave differently from an established machine. Rebuilding PATH from
# config every session is reproducible. fish_add_path is a no-op if the
# directory is already there, so this stays idempotent.
fish_add_path --global ~/.local/bin
