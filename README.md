# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## What's included

- **tmux** — Vi-mode keybindings, true color support, Nord theme, TPM plugin manager
- **Claude Code** — Project-level settings and instructions (`~/.claude/`)

## Usage

```bash
# Install chezmoi and apply dotfiles
chezmoi init papasaidfine/dotfiles
chezmoi apply

# Preview changes
chezmoi diff

# Pull and apply latest
chezmoi update
```
