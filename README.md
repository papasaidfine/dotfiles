# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## What's included

- **tmux** — Vi-mode keybindings, true color support, Nord theme, TPM plugin manager
- **zellij** — Compact layout, hidden pane frames, and Nord theme (`~/.config/zellij/`)
- **Claude Code** — Project-level settings and instructions (`~/.claude/`)
- **oh-my-posh** — Nordtron prompt theme (`~/.cache/oh-my-posh/themes/`)
- **fish** — `zj` helper for machine-named zellij sessions (`~/.config/fish/functions/`)

## Quick start

One-liner to bootstrap a fresh machine (installs chezmoi, then tpm/neovim/lazyvim on request):

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/papasaidfine/dotfiles/main/scripts/bootstrap.sh)"
```

Each step is optional — the script asks first. After pulling the dotfiles source, a menu lets you apply one config at a time (tmux, zellij, fish, Claude Code, oh-my-posh) or **Apply all** at once.

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

The nordtron theme is managed by chezmoi and lands at `~/.cache/oh-my-posh/themes/nordtron.omp.json` after `chezmoi apply`.

Add to `~/.bashrc`:

```bash
eval "$("$HOME/.local/bin/oh-my-posh" init bash --config ~/.cache/oh-my-posh/themes/nordtron.omp.json)"
```

## Terminal tab title

Show `user@host` in the terminal tab, independent of oh-my-posh. Add the snippet for your shell.

**bash** — add to `~/.bashrc` (after the oh-my-posh line, if you use it):

```bash
# Terminal tab title → user@host
__set_tab_title() { printf '\033]0;%s@%s\007' "$USER" "${HOSTNAME%%.*}"; }
case "$PROMPT_COMMAND" in
  *__set_tab_title*) ;;
  *) PROMPT_COMMAND="__set_tab_title${PROMPT_COMMAND:+; $PROMPT_COMMAND}" ;;
esac
```

For a friendly name on cloud VMs (e.g. `ip-172-31-19-84`), replace `${HOSTNAME%%.*}` with a literal string, or write a `~/.config/host-alias` file (see below).

**fish** doesn't need this snippet — machine identity comes from the `zj` helper below (the zellij session name).

**Inside a multiplexer** the bare-shell title behaves differently:
- **tmux** — not forwarded to the outer tab (default `set-titles off`).
- **zellij** — the shell's title becomes the focused pane title, which zellij forwards to the outer terminal as `<session> | user@host`. The format (session-name prefix included) is not configurable, and is independent of `pane_frames`.

## Machine identity in zellij (fish)

fish ships a chezmoi-managed `zj` function (`~/.config/fish/functions/`). Run `zj` to attach to — or create — a zellij session named `user@<alias>`, so the machine shows in zellij's status bar and as the session-name half of the outer terminal title:

```fish
zj
```

The `<alias>` comes from `~/.config/host-alias` — a single friendly line (e.g. `risk-ranger`) you write yourself, **per machine**. chezmoi does not manage this file; without it, `zj` falls back to the short hostname.

## Manual usage

```bash
# Install chezmoi and apply dotfiles only
chezmoi init papasaidfine/dotfiles --apply

# Preview changes
chezmoi diff

# Pull and apply latest
chezmoi update
```
