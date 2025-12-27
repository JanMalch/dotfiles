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

# zsh-vi-mode
# https://github.com/jeffreytse/zsh-vi-mode
if [ -d "/opt/homebrew" ]; then
    source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
elif [ -d "/usr/share/zsh/plugins/zsh-vi-mode" ]; then
    # e.g. Arch Linux
    source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
fi
ZVM_SYSTEM_CLIPBOARD_ENABLED=true
# Workaround to make vi-mode work with atuin
function zvm_after_init() {
  zvm_bindkey viins '^R' atuin-search
  zvm_bindkey vicmd '^R' atuin-search
}

# Neovim
alias vim="nvim"
alias v="nvim"

# fzf
# https://github.com/catppuccin/fzf/blob/7c2e05606f2e75840b1ba367b1f997cd919809b3/themes/catppuccin-fzf-macchiato.sh
export FZF_DEFAULT_OPTS=" \
--color=bg+:#363A4F,bg:#24273A,spinner:#F4DBD6,hl:#ED8796 \
--color=fg:#CAD3F5,header:#ED8796,info:#C6A0F6,pointer:#F4DBD6 \
--color=marker:#B7BDF8,fg+:#CAD3F5,prompt:#C6A0F6,hl+:#ED8796 \
--color=selected-bg:#494D64 \
--color=border:#6E738D,label:#CAD3F5"
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
export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"
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

# utils
jsondiff() {
    local minus="$1"
    shift
    local plus="$1"
    shift
    delta <(jq --sort-keys . < $minus) <(jq --sort-keys . < $plus) --default-language="json" --file-style="omit" $@
}

jqv() { 
    nvim +JqPlayground $1
}
# TODO: let's see which one I'll find more intuitive
alias vjq="jqv"

dus() {
    # obsolete with https://github.com/bootandy/dust/issues/536
    dust --collapse=node_modules --collapse=.git --collapse=.kotlin --collapse=.gradle $@
}

google() {
    local IFS="%20"
    local q="$(echo "$@")"
    open "https://www.google.com/search?q=$q"
}

# Most of the time I don't need to search in help texts ...
help() {
    "$@" --help 2>&1 | bat --plain --language=help
}
# ... but when I do, I would do so with Neovim
helpv() {
    "$@" --help 2>&1 | vim
}

# cheat(sheets)
cheat() {
    local location="$HOME/cheats"
    local query="${1-}"
    local selected
    selected="$(ls "$location" | fzf -1 --preview "bat --plain --color=always $location/{-1}" -q "$query")"
    if [[ -z "$selected" ]]; then
        return 1
    else
        vim "$location/$selected"
    fi   
}
# ripgrep cheat(sheets)
cheater() {
    local location="$HOME/cheats"
    local query="${1-}"
    if [[ -z "$query" ]]; then
       echo "cheater must be called with exactly one argument"
       return 1
    fi
    local selected
    selected="$(rg -s -l -e "$query" "$location" | fzf -1 --preview "bat --plain --color=always {-1}")"
    if [[ -z "$selected" ]]; then
        return 1
    else
        vim "$selected"
    fi
}

# Starship always at the end
# https://starship.rs/guide/#step-2-set-up-your-shell-to-use-starship
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
eval "$(starship init zsh)"
