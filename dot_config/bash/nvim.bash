# Neovim shortcuts that don't shadow the real vim/vi/view commands.
# Source this from ~/.bashrc:  source ~/.config/bash/nvim.bash
#
# Guarded so machines without nvim are unaffected.
if command -v nvim >/dev/null 2>&1; then
  alias v=nvim
  alias nview='nvim -R'
fi
