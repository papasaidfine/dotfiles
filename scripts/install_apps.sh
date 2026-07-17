#!/bin/bash
set -e

info() { printf "\033[1;34m==>\033[0m %s\n" "$1"; }
warn() { printf "\033[1;33mWARN:\033[0m %s\n" "$1"; }
ok()   { printf "\033[1;32m OK:\033[0m %s\n" "$1"; }

# mise installs to ~/.local/bin; tools it manages are exposed via shims
export PATH="$HOME/.local/bin:$HOME/.local/share/mise/shims:$PATH"
# pnpm global bin dir (for codex)
export PNPM_HOME="${PNPM_HOME:-$HOME/.local/share/pnpm}"
export PATH="$PNPM_HOME:$PATH"

# name|binary|description — first REQUIRED entries are always installed
APPS=(
  "mise|mise|polyglot tool version manager"
  "pnpm|pnpm|Node.js package manager"
  "uv|uv|Python package manager"
  "neovim|nvim|the editor"
  "claude|claude|Claude Code, Anthropic's coding agent"
  "glow|glow|markdown renderer"
  "yazi|yazi|terminal file manager"
  "jq|jq|JSON processor"
  "ripgrep|rg|fast grep, used by neovim Telescope"
  "lazygit|lazygit|git TUI"
  "lazyport|lazyport|ports/processes TUI"
  "zellij|zellij|terminal multiplexer"
  "fish|fish|friendly interactive shell"
  "codex|codex|OpenAI's coding agent (pnpm)"
  "agy|agy|Google's Antigravity CLI"
)
REQUIRED=3

SEL=()
for i in "${!APPS[@]}"; do
  [ "$i" -lt "$REQUIRED" ] && SEL[i]=1 || SEL[i]=0
done

menu() {
  echo
  info "The editor's collection — pick apps to install"
  for i in "${!APPS[@]}"; do
    IFS='|' read -r name _ desc <<< "${APPS[$i]}"
    if [ "$i" -lt "$REQUIRED" ]; then
      mark="[x]"; desc="$desc (required)"
    elif [ "${SEL[$i]}" = 1 ]; then
      mark="[x]"
    else
      mark="[ ]"
    fi
    printf "  %2d %s %-8s %s\n" "$((i+1))" "$mark" "$name" "$desc"
  done
  echo
}

while true; do
  menu
  printf "Toggle by number (space-separated), 'a' = all, Enter = install: "
  read -r input
  [ -z "$input" ] && break
  if [ "$input" = "a" ]; then
    for i in "${!APPS[@]}"; do SEL[i]=1; done
    continue
  fi
  for n in $input; do
    case "$n" in *[!0-9]*|"") warn "not a number: $n"; continue ;; esac
    i=$((n - 1))
    if [ "$i" -lt 0 ] || [ "$i" -ge "${#APPS[@]}" ]; then
      warn "out of range: $n"
    elif [ "$i" -lt "$REQUIRED" ]; then
      warn "${APPS[$i]%%|*} is required"
    elif [ "${SEL[$i]}" = 1 ]; then
      SEL[i]=0
    else
      SEL[i]=1
    fi
  done
done

install_one() {
  case "$1" in
    mise)     curl -fsSL https://mise.run | sh ;;
    claude)   curl -fsSL https://claude.ai/install.sh | bash ;;
    codex)    pnpm add -g @openai/codex ;;
    agy)      mise use -g antigravity-cli ;;
    lazyport) mise use -g ubi:papasaidfine/lazyport ;;
    fish)
      if [ "$(uname -s)" = "Darwin" ]; then
        warn "fish has no static macOS build — use 'brew install fish'"
      else
        mise use -g 'ubi:fish-shell/fish-shell[exe=fish]'
      fi
      ;;
    *)        mise use -g "$1" ;;
  esac
}

for i in "${!APPS[@]}"; do
  [ "${SEL[$i]}" = 1 ] || continue
  IFS='|' read -r name bin _ <<< "${APPS[$i]}"
  if command -v "$bin" >/dev/null 2>&1; then
    ok "$name already installed"
  elif install_one "$name"; then
    ok "$name installed"
  else
    warn "$name failed"
  fi
done

info "Done! Restart your shell to pick up new tools."
