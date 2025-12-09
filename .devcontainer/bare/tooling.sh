#!/usr/bin/env bash

# Let the script fail on error and on failing pipes
set -eo pipefail

# Refer to e.g. https://pkgs.alpinelinux.org/package/v3.22/community/x86/carapace
sudo apk add bat carapace eza fd fzf go neovim nodejs ripgrep starship tmux xclip zoxide
# Glow isn't available on Alpine
go install github.com/charmbracelet/glow/v2@latest
bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)

echo
sh "$HOME/scripts/setup_doctor"
echo

echo "All essential tools are installed. Run the following command to finalize:"
echo "  source ~/.zshenv && source ~/.config/zsh/.zshrc"
