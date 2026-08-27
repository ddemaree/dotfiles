# David's dotfiles

Personal configuration files, managed with [chezmoi](https://www.chezmoi.io/).

## Set up a new machine

On macOS, install [Homebrew](https://brew.sh/) first so chezmoi can install the
packages and applications listed in `Brewfile`.

Then install chezmoi, clone this repository, and apply it:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply ddemaree
```

Review the changes before applying them if needed:

```sh
chezmoi init ddemaree
chezmoi diff
chezmoi apply
```

## Day-to-day use

Pull and apply the latest changes:

```sh
chezmoi update
```

Add or update a file in the source repository:

```sh
chezmoi add ~/.config/example/config.toml
chezmoi cd
git status
```

Useful checks before applying changes:

```sh
chezmoi diff
chezmoi doctor
```

Machine-specific or secret state should stay out of the repository; see
`.chezmoiignore` for the current exclusions.
