#!/bin/bash
set -e

info() { printf "\033[1;34m==>\033[0m %s\n" "$1"; }
ok()   { printf "\033[1;32m OK:\033[0m %s\n" "$1"; }

# chezmoi installs to ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"

if command -v chezmoi >/dev/null 2>&1; then
  ok "chezmoi already installed"
else
  info "Installing chezmoi to ~/.local/bin ..."
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
fi

info "Applying dotfiles ..."
chezmoi init papasaidfine/dotfiles --apply
ok "Dotfiles applied"

info "Next: pick apps to install with"
printf "    bash ~/.local/share/chezmoi/scripts/install_apps.sh\n"
