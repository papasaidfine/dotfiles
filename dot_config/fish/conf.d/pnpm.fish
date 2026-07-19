# pnpm global packages (installed via `pnpm add -g`, e.g. codex).
# pnpm's global bin dir is $PNPM_HOME/bin (see `pnpm bin -g`); mise only manages
# the pnpm binary itself, not these globals, so we expose them ourselves.
# Guarded so machines without pnpm globals are unaffected.
set -gx PNPM_HOME $HOME/.local/share/pnpm
if test -d $PNPM_HOME/bin
    fish_add_path $PNPM_HOME/bin
end
