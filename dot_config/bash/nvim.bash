# Neovim shortcuts that don't shadow the real vim/vi/view commands.
# Guarded so machines without nvim are unaffected.
if command -v nvim >/dev/null 2>&1; then
  alias v=nvim
  alias nv='nvim -R'
fi
