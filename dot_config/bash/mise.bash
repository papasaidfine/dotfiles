# Expose mise-managed tools (installed by scripts/install_apps.sh).
# Mirrors dot_config/fish/conf.d/mise.fish. Guarded so machines without
# mise are unaffected.
# Source this from ~/.bashrc:  source ~/.config/bash/mise.bash
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate bash)"
fi
