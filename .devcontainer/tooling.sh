#!/usr/bin/env bash

# Let the script fail on error and on failing pipes
set -eo pipefail

# Refer to e.g. https://pkgs.alpinelinux.org/package/v3.22/community/x86/carapace
sudo apk add carapace eza fd fzf go neovim ripgrep starship xclip zoxide
# Glow isn't available on Alpine
go install github.com/charmbracelet/glow/v2@latest

echo
sh "$HOME/scripts/setup_doctor"
echo

echo "All essential tools are installed. Run the following command to finalize:"
echo "  source ~/.zshenv && source ~/.config/zsh/.zshrc"
