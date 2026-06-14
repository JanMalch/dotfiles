#!/usr/bin/env bash

# Let the script fail on error and on failing pipes
set -eo pipefail

# Refer to e.g. https://pkgs.alpinelinux.org/package/v3.22/community/x86/carapace
sudo apk add bat carapace eza fastfetch fd ffmpeg fzf delta dust dysk lazygit go git-lfs imagemagick neovim nodejs npm ripgrep starship xclip zoxide
git lfs install

echo
sh "$HOME/scripts/setup_doctor"
echo

echo "All essential tools are installed. Run the following command to finalize:"
echo "  source ~/.zshenv && source ~/.config/zsh/.zshrc"
