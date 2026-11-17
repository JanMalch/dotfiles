#!/usr/bin/env bash

# Let the script fail on error and on failing pipes
set -eo pipefail

if ! command -v "stow" >/dev/null 2>&1; then
	printf "\e[1;31m%s\e[0m\n" "Please install stow and rerun."
	printf "\e[4;34m%s\e[0m\n" "https://www.gnu.org/software/stow/"
	printf "\e[4;34m%s\e[0m\n" "https://tamerlan.dev/how-i-manage-my-dotfiles-using-gnu-stow/#using-gnu-stow"
	printf "\e[4;34m%s\e[0m && brew install stow\n" "https://brew.sh/"
	exit 1
fi

stow home
sh "$HOME/scripts/setup_doctor"

echo
echo "Basic setup has finished. Please install all necessary tools from the above list yourself."
echo "Then, run the following command, or open a new terminal to finalize."
echo "  source ~/.zshenv && source ~/.config/zsh/.zshrc"
echo
printf "\e[1m%s\e[0m\n" "Further Steps"
printf "%s \e[4;34m%s\e[0m\n" "I usually install my dependencies via Homebrew: " 'https://brew.sh/'
echo "Once you have that, you can install most of the core tools:"
cat <<EOF

brew install bat bottom carapace git-delta gnu-sed eza fastfetch fd fzf git-lfs go \\
	jq yq neovim lazygit node pastel ripgrep starship tlrc tree-sitter-cli tuicr zsh-vi-mode zoxide
git lfs install
go install mvdan.cc/sh/v3/cmd/shfmt@latest
go install github.com/JanMalch/roar@latest
go install github.com/JanMalch/snips@latest
open 'https://rust-lang.org/tools/install/'
EOF
