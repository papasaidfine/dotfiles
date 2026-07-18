# pnpm global packages (installed via `pnpm add -g`, e.g. codex).
# pnpm keeps its global bin dir in $PNPM_HOME; mise only manages the pnpm
# binary itself, not these globals, so we expose them ourselves.
# Guarded so machines without pnpm globals are unaffected.
set -gx PNPM_HOME $HOME/.local/share/pnpm
if test -d $PNPM_HOME
    fish_add_path $PNPM_HOME
end
