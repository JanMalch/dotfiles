autoload -Uz compinit
compinit
# https://stackoverflow.com/questions/13762280/zsh-compinit-insecure-directories
# compaudit | xargs chmod g-w

# Reevaluate the prompt string each time it's displaying a prompt
setopt prompt_subst

# Don't add commands with leading space to history
setopt hist_ignore_space

# Delete duplicates first when HISTFILE size exceeds HISTSIZE.
setopt hist_expire_dups_first

# Ignore duplicated commands history list.
setopt hist_ignore_dups

# Homebrew (only for MacOS)
if [ -d "/opt/homebrew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# fzf
# only use git files by default
# https://github.com/junegunn/fzf?tab=readme-ov-file#respecting-gitignore
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# https://junegunn.github.io/fzf/installation/#setting-up-shell-integration
source <(fzf --zsh)

# ripgrep->fzf->vim [QUERY]
# https://junegunn.github.io/fzf/tips/ripgrep-integration/#wrap-up
rfv() (
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            vim {1} +{2}     # No selection. Open the current line in Vim.
          else
            vim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
)

# https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation
eval "$(zoxide init zsh --cmd cd)"

# https://carapace-sh.github.io/carapace-bin/setup.html
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

# atuin
. "$HOME/.atuin/bin/env"
# Bind ctrl-r but not up arrow
eval "$(atuin init zsh --disable-up-arrow)"

# https://eza.rocks/
# Not using -l because it makes it harder to use with fzf.
# Just use "la" if you want something like "ls -la".
# Also: using carapace for eza completions
alias ls="eza --icons=auto"
alias la="eza -labh --no-user --icons=auto"
alias tree="eza --tree --level=2 --icons=auto"

# https://podman.io/
alias docker="podman"

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# bat
help() {
    "$@" --help 2>&1 | bat --language=help --style="grid,numbers,snip"
}
# https://github.com/sharkdp/bat?tab=readme-ov-file#xclip
alias cat="bat"

# Colors
# https://github.com/sharkdp/pastel#readme
hex2rgb() {
    pastel color "$1" | pastel format rgb
}
rgb2hex() {
    pastel color "$1" | pastel format hex
}

# cheat(sheets)
cheat() {
    local location="$HOME/cheats"
    local query="${1-}"
    local selected
    selected="$(ls "$location" | fzf -1 --preview "bat --style=grid,numbers --color=always $location/{-1} | tail -n +2 | head -n -1" -q "$query")"
    bat --paging=always "$location/$selected"
}

# Starship always at the end
# https://starship.rs/guide/#step-2-set-up-your-shell-to-use-starship
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
eval "$(starship init zsh)"
