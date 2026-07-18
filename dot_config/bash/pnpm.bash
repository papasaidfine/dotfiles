# pnpm global packages (installed via `pnpm add -g`, e.g. codex).
# pnpm keeps its global bin dir in $PNPM_HOME; mise only manages the pnpm
# binary itself, not these globals, so we expose them ourselves.
# Source this from ~/.bashrc:  source ~/.config/bash/pnpm.bash
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
