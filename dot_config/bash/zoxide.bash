# zoxide — smarter cd that jumps to frecent directories (`z <query>`, `zi <query>`).
# Mirrors dot_config/fish/conf.d/zoxide.fish. Guarded so machines without
# zoxide are unaffected.
# Source this from ~/.bashrc:  source ~/.config/bash/zoxide.bash
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi
