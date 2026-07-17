# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## What's included

- **zellij** — Compact layout, hidden pane frames, and Nord theme (`~/.config/zellij/`)
- **Claude Code** — Project-level settings and instructions (`~/.claude/`)
- **fish** — `zj` helper + PATH setup (`~/.config/fish/`)
- **bash** — `zj` helper (`~/.config/bash/zj.bash`)

## Quick start

One-liner to bootstrap a fresh machine (installs chezmoi, applies dotfiles, then optionally neovim + LazyVim):

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
- [lazygit](https://github.com/jesseduffield/lazygit) — Terminal UI for git commands
- [lazyport](https://github.com/papasaidfine/lazyport) — Terminal UI for managing local ports/processes
- [zellij](https://github.com/zellij-org/zellij) — Terminal multiplexer and workspace
- [fish](https://github.com/fish-shell/fish-shell) — User-friendly interactive shell

## Machine identity in zellij

`zj` attaches to — or creates — a zellij session named `user@<alias>`, so the machine is identifiable in zellij's status bar (and the outer terminal title). It's shell-independent — zellij owns the session name — so both shells provide the same `zj` command:

- **fish** — provided automatically (chezmoi-managed function); just run `zj`.
- **bash** — add `source ~/.config/bash/zj.bash` to `~/.bashrc`, then run `zj`.

```fish
zj
```

`<alias>` is the first line of `~/.config/host-alias` (a friendly name you write per machine, e.g. `risk-ranger`); without that file it falls back to the short hostname. chezmoi does not manage `~/.config/host-alias`.

## Fish as default shell

```bash
command -v fish | sudo tee -a /etc/shells
chsh -s "$(command -v fish)"
```

No password for chsh? `sudo chsh -s "$(command -v fish)" "$USER"`, or add to `~/.bashrc`:

```bash
# Safely switch to fish if it exists and the shell is interactive
if [[ $- == *i* ]] && command -v fish &> /dev/null; then
    exec fish
fi
```

## Manual usage

```bash
# Install chezmoi and apply dotfiles only
chezmoi init papasaidfine/dotfiles --apply

# Preview changes
chezmoi diff

# Pull and apply latest
chezmoi update
```
