# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## What's included

- **tmux** — Vi-mode keybindings, true color support, pane navigation/resize keybinds
- **zellij** — Compact layout, hidden pane frames, and Nord theme (`~/.config/zellij/`)
- **Claude Code** — Project-level settings and instructions (`~/.claude/`)
- **fish** — `zj` helper for machine-named zellij sessions (`~/.config/fish/functions/`)

## Quick start

One-liner to bootstrap a fresh machine (installs chezmoi, dotfiles, lazyvim):

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
- [zellij](https://github.com/zellij-org/zellij) — Terminal multiplexer and workspace (tmux alternative)
- [fish](https://github.com/fish-shell/fish-shell) — User-friendly interactive shell

## Terminal tab title

Show `user@host` in the terminal tab. Add the snippet for your shell.

**bash** — add to `~/.bashrc`:

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
