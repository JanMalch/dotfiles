#!/usr/bin/env bash

# Let the script fail on error and on failing pipes
set -eo pipefail

# Updates the theme for bat
update_bat_theme() {
    local destdir="home/.config/bat/themes"
    local theme="Macchiato.tmTheme"
    curl -sS -L -o "$destdir/Catppuccin $theme" "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20$theme"
    echo "bat theme updated"
}

# https://github.com/git/git/blob/master/contrib/git-jump/README
update_git_jump() {
    curl -sS -L -o "home/scripts/git-jump" "https://raw.githubusercontent.com/git/git/refs/heads/master/contrib/git-jump/git-jump"
    echo "git-jump updated"
}

if [ -z "$(git status --porcelain)" ]; then 
    # Working directory clean
    update_bat_theme
    update_git_jump
    git status
else 
    # Uncommitted changes
    echo "ERROR: working directory is not clean"
    git status
    exit 1
fi
