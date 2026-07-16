# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## What's included

- **tmux** — Vi-mode keybindings, true color support, Nord theme, TPM plugin manager
- **zellij** — Compact layout, hidden pane frames, and Nord theme (`~/.config/zellij/`)
- **Claude Code** — Project-level settings and instructions (`~/.claude/`)
- **oh-my-posh** — Nordtron theme with terminal tab title (`~/.cache/oh-my-posh/themes/`)

## Quick start

One-liner to bootstrap a fresh machine (installs chezmoi, dotfiles, tpm, lazyvim):

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/papasaidfine/dotfiles/main/scripts/bootstrap.sh)"
```

Each component is optional — the script asks before installing anything.

## Recommended tools

These are not installed by the bootstrap script but are useful to have:

- [oh-my-posh](https://ohmyposh.dev) — Shell prompt theme engine (see setup below)
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
- [zellij](https://github.com/zellij-org/zellij) — Terminal multiplexer and workspace (tmux alternative)
- [fish](https://github.com/fish-shell/fish-shell) — User-friendly interactive shell

## oh-my-posh setup

Install the binary:

```bash
curl -s https://ohmyposh.dev/install.sh | bash -s
```

The nordtron theme is managed by chezmoi and will land at `~/.cache/oh-my-posh/themes/nordtron.omp.json` after `chezmoi apply`. It includes a `console_title_template` so the terminal tab shows `user@host` automatically. On first `chezmoi init` (including when run by the bootstrap script), chezmoi asks for a friendly name for this machine's terminal tab title — useful on cloud VMs named like `ip-172-31-19-84`. The answer is saved to `~/.config/chezmoi/chezmoi.toml`:

```toml
[data]
    hostAlias = "risk-ranger"
```

Leave the prompt empty to keep showing the real hostname. To change it later, edit that file and re-run `chezmoi apply`.

Add to `~/.bashrc`:

```bash
eval "$("$HOME/.local/bin/oh-my-posh" init bash --config ~/.cache/oh-my-posh/themes/nordtron.omp.json)"
```

## Zellij configuration

The configuration is managed by chezmoi and will land at `~/.config/zellij/config.kdl` after `chezmoi apply`.

Key preference settings:
1. **Compact Layout**: Enabled by default (`default_layout "compact"`)
2. **Hide Frames**: Pane frames are disabled (`pane_frames false`)
3. **Theme**: Nord theme (`theme "nord"`)

## Manual usage

```bash
# Install chezmoi and apply dotfiles only
chezmoi init papasaidfine/dotfiles --apply

# Preview changes
chezmoi diff

# Pull and apply latest
chezmoi update
```
