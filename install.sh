#!/bin/bash

REPO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "Setting up dotfiles..."

# 1. SYMLINK CONFIG FILES
# Added 'nix' directory mapping to ~/.config/home-manager
FILES=(
    "aliases:$HOME/.aliases"
    "gitconfig:$HOME/.gitconfig"
    "p10k.zsh:$HOME/.p10k.zsh"
    "vimrc:$HOME/.vimrc"
    "zshrc:$HOME/.zshrc"
    "nix:$HOME/.config/home-manager"
)

mkdir -p "$BACKUP_DIR"

for item in "${FILES[@]}"; do
    FILE_NAME="${item%%:*}"
    TARGET_PATH="${item##*:}"
    SOURCE_PATH="$REPO_DIR/$FILE_NAME"

    # Ensure the parent directory exists (critical for .config/home-manager)
    mkdir -p "$(dirname "$TARGET_PATH")"

    if [ -e "$TARGET_PATH" ] || [ -L "$TARGET_PATH" ]; then
        if [ "$(readlink -f "$TARGET_PATH")" != "$SOURCE_PATH" ]; then
            echo "Backing up $FILE_NAME..."
            mv "$TARGET_PATH" "$BACKUP_DIR/"
        else
            continue
        fi
    fi

    ln -s "$SOURCE_PATH" "$TARGET_PATH"
    echo "Linked $FILE_NAME"
done

# 2. VIM SETUP (Plugin Manager + Theme)
if [ ! -f "$HOME/.vim/autoload/pathogen.vim" ]; then
    echo "Installing Pathogen..."
    mkdir -p "$HOME/.vim/autoload" "$HOME/.vim/bundle"
    curl -LSso "$HOME/.vim/autoload/pathogen.vim" https://tpo.pe/pathogen.vim
fi

if [ ! -d "$HOME/.vim/bundle/vim-colors-solarized" ]; then
    echo "Installing Solarized..."
    git clone https://github.com/altercation/vim-colors-solarized.git "$HOME/.vim/bundle/vim-colors-solarized"
fi

# 3. NIX & HOME MANAGER SETUP
echo "Checking Nix configuration..."

if command -v nix >/dev/null 2>&1; then
    # Detect Architecture (Smart Mac Check)
    if [[ "$(uname)" == "Darwin" ]]; then
        if [[ "$(uname -m)" == "arm64" ]]; then
            echo "🍎 Apple Silicon detected."
            FLAKE_TARGET="blisshex-mac"
        else
            echo "💻 Intel Mac detected."
            FLAKE_TARGET="blisshex-mac-intel"
        fi
    else
        echo "🐧 Linux detected."
        FLAKE_TARGET="blisshex-linux"
    fi

    # Activate Home Manager
    if ! command -v home-manager >/dev/null 2>&1; then
        echo "🚀 Bootstrapping Home Manager for $FLAKE_TARGET..."
        # We use -b backup to handle the 'nix.conf' conflict automatically
        nix run home-manager/master -- switch --flake "$HOME/.config/home-manager#$FLAKE_TARGET" -b backup
    else
        echo "🔄 Updating Home Manager for $FLAKE_TARGET..."
        home-manager switch --flake "$HOME/.config/home-manager#$FLAKE_TARGET"
    fi
else
    echo "⚠️  Nix is not installed. Skipping Home Manager setup."
    echo "   Install it later with: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
fi

# 4. SET SHELL
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
fi

echo "Done."

read -p "Do you want to reconfigure Powerlevel10k? (Y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    zsh -i -c "p10k configure"
fi
