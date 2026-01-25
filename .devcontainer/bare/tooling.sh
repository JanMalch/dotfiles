#!/usr/bin/env bash

# Let the script fail on error and on failing pipes
set -eo pipefail

# Refer to e.g. https://pkgs.alpinelinux.org/package/v3.22/community/x86/carapace
sudo apk add bat carapace eza fd fzf delta dust lazygit go git-lfs neovim nodejs ripgrep ruby starship tmux xclip zoxide
git lfs install
bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)
bash -c "$(curl -sLo- https://superfile.dev/install.sh)"

echo
sh "$HOME/scripts/setup_doctor"
echo

echo "All essential tools are installed. Run the following command to finalize:"
echo "  source ~/.zshenv && source ~/.config/zsh/.zshrc"
