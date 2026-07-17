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

COUNT=${#APPS[@]}
cur=$REQUIRED  # start on the first toggleable item

menu() {
  local i name desc mark
  printf '\033[1;34m==>\033[0m %s\033[K\n' "The editor's collection — pick apps to install"
  for ((i = 0; i < COUNT; i++)); do
    IFS='|' read -r name _ desc <<< "${APPS[$i]}"
    [ "$i" -lt "$REQUIRED" ] && desc="$desc (required)"
    [ "${SEL[$i]}" = 1 ] && mark="[x]" || mark="[ ]"
    if [ "$i" -eq "$cur" ]; then
      printf '  \033[7m%s %-8s %s\033[0m\033[K\n' "$mark" "$name" "$desc"
    else
      printf '  %s %-8s %s\033[K\n' "$mark" "$name" "$desc"
    fi
  done
  printf '  ↑/↓/j/k move · space toggle · a all · enter install · q quit\033[K\n'
}

printf '\033[?25l'
trap 'printf "\033[?25h"' EXIT

menu
while true; do
  if ! IFS= read -rsn1 key; then key=q; fi
  if [ "$key" = $'\x1b' ]; then
    IFS= read -rsn2 -t 1 seq || seq=
    case "$seq" in
      '[A') key=k ;;
      '[B') key=j ;;
      *)    key= ;;
    esac
  fi
  case "$key" in
    k) [ "$cur" -gt 0 ] && cur=$((cur - 1)) ;;
    j) [ "$cur" -lt $((COUNT - 1)) ] && cur=$((cur + 1)) ;;
    ' ')
      if [ "$cur" -ge "$REQUIRED" ]; then
        [ "${SEL[$cur]}" = 1 ] && SEL[cur]=0 || SEL[cur]=1
      fi
      ;;
    a) for ((i = 0; i < COUNT; i++)); do SEL[i]=1; done ;;
    '') break ;;
    q) info "Aborted — nothing installed"; exit 0 ;;
  esac
  printf '\033[%dA' "$((COUNT + 2))"
  menu
done
printf '\033[?25h'

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
