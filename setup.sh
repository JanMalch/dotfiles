#!/usr/bin/env bash

# Let the script fail on error and on failing pipes
set -eo pipefail

if ! command -v "stow" >/dev/null 2>&1; then
    echo -e "\e[1;31mPlease install stow and rerun.\e[0m"
    echo -e "\e[4;34mhttps://www.gnu.org/software/stow/\e[0m"
    echo -e "\e[4;34mhttps://tamerlan.dev/how-i-manage-my-dotfiles-using-gnu-stow/#using-gnu-stow\e[0m"
    exit 1
fi

stow home
sh "$HOME/scripts/setup_doctor"

echo
echo "Basic setup has finished. Please install all necessary tools from the above list yourself."
echo "Then, run the following command, or open a new terminal to finalize."
echo "  source ~/.zshenv && source ~/.config/zsh/.zshrc"
