# Expose mise-managed tools (installed by scripts/install_apps.sh).
# Mirrors dot_config/fish/conf.d/mise.fish. Guarded so machines without
# mise are unaffected.
# Source this from ~/.bashrc:  source ~/.config/bash/mise.bash

# mise itself installs to ~/.local/bin. Login shells pick that up from
# ~/.profile, but ~/.bashrc is also read by non-login shells that never
# sourced it, so don't assume it's there.
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) PATH="$HOME/.local/bin:$PATH" ;;
esac

# Shims work in every context, including programs launched outside a shell,
# which never run the activation hook below. Added first so `mise activate`
# prepends the real tool paths ahead of them.
if [ -d "$HOME/.local/share/mise/shims" ]; then
  case ":$PATH:" in
    *":$HOME/.local/share/mise/shims:"*) ;;
    *) PATH="$HOME/.local/share/mise/shims:$PATH" ;;
  esac
fi
export PATH

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate bash)"
fi
