# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## What's included

- **tmux** — Vi-mode keybindings, true color support, Nord theme, TPM plugin manager
- **zellij** — Compact layout, hidden pane frames, and Nord theme (`~/.config/zellij/`)
- **Claude Code** — Project-level settings and instructions (`~/.claude/`)
- **oh-my-posh** — Nordtron prompt theme (`~/.cache/oh-my-posh/themes/`)

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

**fish** — add to `~/.config/fish/config.fish`:

```fish
# Terminal tab title → user@host
function fish_title
    echo "$USER@"(prompt_hostname)
end
```

For a friendly name on cloud VMs (e.g. `ip-172-31-19-84`), replace `${HOSTNAME%%.*}` / `(prompt_hostname)` with a literal string.

**Inside a multiplexer:** this only sets the title for a bare shell. Inside tmux it isn't forwarded to the outer tab (no `set-titles`). Inside zellij with `pane_frames false` (this repo's default) it isn't shown either — enable pane frames if you want it there.

## Manual usage

```bash
# Install chezmoi and apply dotfiles only
chezmoi init papasaidfine/dotfiles --apply

# Preview changes
chezmoi diff

# Pull and apply latest
chezmoi update
```
