# pnpm global packages (installed via `pnpm add -g`, e.g. codex).
# pnpm's global bin dir is $PNPM_HOME/bin (see `pnpm bin -g`); mise only manages
# the pnpm binary itself, not these globals, so we expose them ourselves.
# Source this from ~/.bashrc:  source ~/.config/bash/pnpm.bash
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
