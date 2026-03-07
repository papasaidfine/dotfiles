#!/bin/bash
set -e

ask() {
  printf "%s [y/N] " "$1"
  read -r answer
  case "$answer" in
    [yY]|[yY][eE][sS]) return 0 ;;
    *) return 1 ;;
  esac
}

info() { printf "\033[1;34m==>\033[0m %s\n" "$1"; }
warn() { printf "\033[1;33mWARN:\033[0m %s\n" "$1"; }
ok()   { printf "\033[1;32m OK:\033[0m %s\n" "$1"; }
fail() { printf "\033[1;31mERR:\033[0m %s\n" "$1"; }

# --- chezmoi ---
if ask "Install chezmoi and apply dotfiles?"; then
  if command -v chezmoi >/dev/null 2>&1; then
    ok "chezmoi already installed"
  else
    info "Installing chezmoi to ~/.local/bin ..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
    export PATH="$HOME/.local/bin:$PATH"
  fi
  info "Applying dotfiles ..."
  chezmoi init papasaidfine/dotfiles --apply
  ok "Dotfiles applied"
fi

# --- tmux plugin manager ---
if ask "Install tmux plugin manager (tpm)?"; then
  TPM_DIR="$HOME/.tmux/plugins/tpm"
  if [ -d "$TPM_DIR" ]; then
    ok "tpm already installed at $TPM_DIR"
  else
    if ! command -v git >/dev/null 2>&1; then
      fail "git is required but not found"; exit 1
    fi
    info "Cloning tpm ..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    ok "tpm installed — launch tmux and press prefix + I to install plugins"
  fi
fi

# --- neovim (pre-built archive, no sudo) ---
if ask "Install neovim from pre-built archive?"; then
  if command -v nvim >/dev/null 2>&1; then
    ok "nvim already installed: $(nvim --version | head -1)"
  else
    OS="$(uname -s)"
    ARCH="$(uname -m)"
    case "$OS" in
      Linux)
        case "$ARCH" in
          x86_64)  NVIM_ARCHIVE="nvim-linux-x86_64.tar.gz" ;;
          aarch64) NVIM_ARCHIVE="nvim-linux-arm64.tar.gz" ;;
          *) fail "Unsupported Linux architecture: $ARCH"; exit 1 ;;
        esac
        ;;
      Darwin)
        case "$ARCH" in
          x86_64) NVIM_ARCHIVE="nvim-macos-x86_64.tar.gz" ;;
          arm64)  NVIM_ARCHIVE="nvim-macos-arm64.tar.gz" ;;
          *) fail "Unsupported macOS architecture: $ARCH"; exit 1 ;;
        esac
        ;;
      *) fail "Unsupported OS: $OS"; exit 1 ;;
    esac

    NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/$NVIM_ARCHIVE"
    NVIM_INSTALL_DIR="$HOME/.local"

    info "Downloading $NVIM_ARCHIVE ..."
    TMP_DIR="$(mktemp -d)"
    curl -fSL -o "$TMP_DIR/$NVIM_ARCHIVE" "$NVIM_URL"

    info "Extracting to $NVIM_INSTALL_DIR ..."
    mkdir -p "$NVIM_INSTALL_DIR"
    tar -xzf "$TMP_DIR/$NVIM_ARCHIVE" -C "$TMP_DIR"
    # merge archive contents (bin/, lib/, share/) into ~/.local
    cp -r "$TMP_DIR"/${NVIM_ARCHIVE%.tar.gz}/* "$NVIM_INSTALL_DIR/"
    rm -rf "$TMP_DIR"

    export PATH="$NVIM_INSTALL_DIR/bin:$PATH"
    ok "nvim installed: $(nvim --version | head -1)"
  fi
fi

# --- lazyvim ---
if ask "Install LazyVim config?"; then
  if ! command -v nvim >/dev/null 2>&1; then
    warn "nvim not found — skipping LazyVim config"
  else
    NVIM_DIR="$HOME/.config/nvim"
    if [ -d "$NVIM_DIR" ]; then
      warn "$NVIM_DIR already exists — skipping to avoid overwrite"
    else
      if ! command -v git >/dev/null 2>&1; then
        fail "git is required but not found"; exit 1
      fi
      info "Cloning LazyVim config ..."
      git clone https://github.com/papasaidfine/lazyvim.git "$NVIM_DIR"
      ok "LazyVim config installed — launch nvim to complete setup"
    fi
  fi
fi

info "Done!"
