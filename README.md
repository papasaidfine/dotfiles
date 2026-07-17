# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## What's included

- **zellij** — Compact layout, hidden pane frames, and Nord theme (`~/.config/zellij/`)
- **Claude Code** — Project-level settings and instructions (`~/.claude/`)
- **fish** — `zj` helper + PATH setup + mise activation (`~/.config/fish/`)
- **bash** — `zj` helper (`~/.config/bash/zj.bash`)

## Quick start

Bootstrap a fresh machine — installs chezmoi and applies the dotfiles:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/papasaidfine/dotfiles/main/scripts/bootstrap.sh)"
```

Then pick apps from the checklist (multi-select, mise/pnpm/uv are required):

```bash
bash ~/.local/share/chezmoi/scripts/install_apps.sh
```

## The editor's collection

What `install_apps.sh` offers — everything installs through mise unless noted:

- [mise](https://github.com/jdx/mise) — polyglot tool version manager (required)
- [pnpm](https://github.com/pnpm/pnpm) — Node.js package manager (required)
- [uv](https://github.com/astral-sh/uv) — Python package manager (required)
- [neovim](https://neovim.io/) — the editor
- [Claude Code](https://github.com/anthropics/claude-code) — Anthropic's coding agent (official installer)
- [glow](https://github.com/charmbracelet/glow) — markdown renderer
- [yazi](https://github.com/sxyazi/yazi) — terminal file manager
- [jq](https://github.com/jqlang/jq) — JSON processor
- [ripgrep](https://github.com/BurntSushi/ripgrep) — fast grep, used by neovim Telescope
- [lazygit](https://github.com/jesseduffield/lazygit) — git TUI
- [lazyport](https://github.com/papasaidfine/lazyport) — ports/processes TUI
- [zellij](https://github.com/zellij-org/zellij) — terminal multiplexer
- [fish](https://github.com/fish-shell/fish-shell) — friendly interactive shell
- [codex](https://github.com/openai/codex) — OpenAI's coding agent (pnpm)
- [agy](https://github.com/google-antigravity/antigravity-cli) — Google's Antigravity CLI

## Special instructions

### LazyVim

Custom setup for neovim — clone my config:

```bash
git clone https://github.com/papasaidfine/lazyvim.git ~/.config/nvim
```

### fish as default shell

```bash
command -v fish | sudo tee -a /etc/shells
chsh -s "$(command -v fish)"
```

Or add to `~/.bashrc`:

```bash
if [[ $- == *i* ]] && command -v fish &> /dev/null; then
    exec fish
fi
```

## Machine identity in zellij

`zj` attaches to — or creates — a zellij session named `user@<alias>`, so the machine is identifiable in zellij's status bar (and the outer terminal title). It's shell-independent — zellij owns the session name — so both shells provide the same `zj` command:

- **fish** — provided automatically (chezmoi-managed function); just run `zj`.
- **bash** — add `source ~/.config/bash/zj.bash` to `~/.bashrc`, then run `zj`.

`<alias>` is the first line of `~/.config/host-alias` (a friendly name you write per machine, e.g. `risk-ranger`); without that file it falls back to the short hostname. chezmoi does not manage `~/.config/host-alias`.

## Manual usage

```bash
# Install chezmoi and apply dotfiles only
chezmoi init papasaidfine/dotfiles --apply

# Preview changes
chezmoi diff

# Pull and apply latest
chezmoi update
```
