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

## Recommended tools

These are not installed by the bootstrap script but are useful to have:

- [fnm](https://github.com/Schniz/fnm) — Fast Node.js version manager
- [uv](https://github.com/astral-sh/uv) — Fast Python package manager
- [pnpm](https://github.com/pnpm/pnpm) — Efficient Node.js package manager
- [Claude Code](https://github.com/anthropics/claude-code) — Anthropic's CLI for Claude
- [glow](https://github.com/charmbracelet/glow) — Render markdown in the terminal
- [yazi](https://github.com/sxyazi/yazi) — Terminal file manager
- [jq](https://github.com/jqlang/jq) — JSON processor for the command line
- [ripgrep](https://github.com/BurntSushi/ripgrep) — Fast grep alternative, used by neovim Telescope

## Manual usage

```bash
# Install chezmoi and apply dotfiles only
chezmoi init papasaidfine/dotfiles --apply

# Preview changes
chezmoi diff

# Pull and apply latest
chezmoi update
```
