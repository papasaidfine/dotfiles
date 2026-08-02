# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## What's included

- **zellij** — Compact layout, hidden pane frames, and Nord theme (`~/.config/zellij/`)
- **Claude Code** — Project-level settings and instructions (`~/.claude/`)
- **fish** — `zj` helper + PATH setup + mise activation (`~/.config/fish/conf.d/`)
- **bash** — the same, mirrored (`~/.config/bash/`)

### Shell snippets

Both shells load a directory of small snippets — mise activation, PATH, the
nvim aliases, the `zj` helper — kept in sync between `~/.config/fish/conf.d/`
and `~/.config/bash/`.

fish sources `conf.d/` on its own. bash has no equivalent, so `~/.bashrc` gets
one line appended, sourcing `~/.config/bash/init.bash`, which loads the rest.
chezmoi does that through `modify_dot_bashrc`, which appends the block and
leaves the rest of the file alone — it never replaces the `~/.bashrc` your
distro shipped. Nothing to wire up by hand.

Both directories load in sorted order, and `mise` sorts first on purpose: every
other snippet guards on a tool that only exists once mise has put it on PATH.

### How mise tools get on PATH

`mise use -g <tool>` doesn't put anything on PATH by itself — the shell has to
be told about it, in one of two ways, and the configs here set up both:

- **`mise activate`** puts the real install paths on PATH and refreshes them as
  you move between projects, so per-project tool versions are respected. It
  only applies to shells that source the config, and within a session it won't
  notice a tool you just installed.
- **shims** (`~/.local/share/mise/shims`) are small wrappers mise writes at
  install time. They cost a little startup overhead per call, but they work
  everywhere — non-interactive shells, and programs launched outside a shell
  that never run the activation hook — and a newly installed tool is usable
  right away without restarting the shell.

Shims go on PATH first so activation can prepend the real paths ahead of them;
that way activation wins where it applies and shims cover everything else.

Both shells set this up via the snippets above, so `mise use -g <tool>` is all
you need to run.

## Quick start

Bootstrap a fresh machine — installs chezmoi and applies the dotfiles:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/papasaidfine/dotfiles/main/scripts/bootstrap.sh)"
```

Install apps from the checklist (multi-select, mise/pnpm/uv are required) — independent of bootstrap, run it on any machine:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/papasaidfine/dotfiles/main/scripts/install_apps.sh)"
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
- [zoxide](https://github.com/ajeetdsouza/zoxide) — smarter cd, jumps to frecent directories
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

Put that **below** the `chezmoi:bash snippets` block. fish is installed by mise,
so it isn't on PATH until that block has run, and above it the `command -v fish`
test silently fails and you stay in bash.

## Machine identity in zellij

`zj` attaches to — or creates — a zellij session named `user@<alias>`, so the machine is identifiable in zellij's status bar (and the outer terminal title). It's shell-independent — zellij owns the session name — so both shells provide the same `zj` command:

Both get it automatically from the shell snippets — just run `zj`.

`<alias>` is the first line of `~/.config/host-alias` (a friendly name you write per machine, e.g. `risk-ranger`); without that file it falls back to the short hostname. chezmoi does not manage `~/.config/host-alias`.

Session resurrection is disabled (`session_serialization false` in `config.kdl`), so closing all tabs ends the session for good — re-running `zj` starts fresh rather than restoring the old tabs, cwds, and commands. A **detached** session (still running, just disconnected) still reattaches as usual.

## Manual usage

```bash
# Install chezmoi and apply dotfiles only
chezmoi init papasaidfine/dotfiles --apply

# Preview changes
chezmoi diff

# Pull and apply latest
chezmoi update
```
