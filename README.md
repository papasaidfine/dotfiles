# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## What's included

- **tmux** — Vi-mode keybindings, true color support, Nord theme, TPM plugin manager
- **Claude Code** — Project-level settings and instructions (`~/.claude/`)

## Quick start

One-liner to bootstrap a fresh machine (installs chezmoi, dotfiles, tpm, lazyvim):

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/papasaidfine/dotfiles/main/scripts/bootstrap.sh)"
```

Each component is optional — the script asks before installing anything.

## Manual usage

```bash
# Install chezmoi and apply dotfiles only
chezmoi init papasaidfine/dotfiles --apply

# Preview changes
chezmoi diff

# Pull and apply latest
chezmoi update
```
