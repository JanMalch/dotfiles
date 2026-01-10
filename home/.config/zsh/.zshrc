autoload -Uz compinit && compinit
# https://stackoverflow.com/questions/13762280/zsh-compinit-insecure-directories
# compaudit | xargs chmod g-w

setopt prompt_subst           # Reevaluate the prompt string each time it's displaying a prompt
setopt hist_ignore_space      # Don't add commands with leading space to history
setopt hist_expire_dups_first # Delete duplicates first when HISTFILE size exceeds HISTSIZE.
setopt hist_ignore_dups       # Ignore duplicated commands history list.

# ----------------------
# Environment Variables
# ----------------------

export ZVM_SYSTEM_CLIPBOARD_ENABLED=true

export CARAPACE_BRIDGES='zsh'
export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"

export TRY_PATH="$HOME/tries" # https://github.com/tobi/try

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS=" \
  --color=bg+:#363A4F,bg:#24273A,spinner:#F4DBD6,hl:#ED8796 \
  --color=fg:#CAD3F5,header:#ED8796,info:#C6A0F6,pointer:#F4DBD6 \
  --color=marker:#B7BDF8,fg+:#CAD3F5,prompt:#C6A0F6,hl+:#ED8796 \
  --color=selected-bg:#494D64 \
  --color=border:#6E738D,label:#CAD3F5"

# ----------------------
# General Aliases
# ----------------------

alias vim="nvim"
alias v="nvim"

alias cat="bat"       # https://github.com/sharkdp/bat
alias docker="podman" # https://podman.io/

# https://eza.rocks/
# Not using -l because it makes it harder to use with fzf.
# Just use "la" if you want something like "ls -la".
# Also: using carapace for eza completions
alias ls="eza --icons=auto"
alias la="eza -labh --no-user --icons=auto"
alias tree="eza --tree --level=2 --icons=auto"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# ----------------------
# Functions
# ----------------------

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

hex2rgb() { pastel color "$1" | pastel format rgb; }
rgb2hex() { pastel color "$1" | pastel format hex; }
jqv() { nvim +JqPlayground $1; }
google() { local IFS="%20"; local q="$(echo "$@")"; open "https://www.google.com/search?q=$q"; }
help() { "$@" --help 2>&1 | bat --plain --language=help; }
helpv() { "$@" --help 2>&1 | vim; }
jsondiff() {
    local minus="$1"; shift
    local plus="$1"; shift
    delta <(jq --sort-keys . < $minus) <(jq --sort-keys . < $plus) --default-language="json" --file-style="omit" $@
}

# ----------------------
# Functions: Cheatsheets
# ----------------------

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

# ----------------------
# Tools
# ----------------------

# https://github.com/jeffreytse/zsh-vi-mode
if [ -d "/opt/homebrew" ]; then
    source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
elif [ -d "/usr/share/zsh/plugins/zsh-vi-mode" ]; then
    # e.g. Arch Linux
    source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
fi

zvm_after_init() {
  zvm_bindkey viins '^R' atuin-search
  zvm_bindkey vicmd '^R' atuin-search
}

zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)                # https://carapace-sh.github.io/carapace-bin/setup.html
source <(fzf --zsh)                         # https://junegunn.github.io/fzf/installation/#setting-up-shell-integration
eval "$(ruby "$HOME/.localrb/try.rb" init)" # https://github.com/tobi/try
eval "$(zoxide init zsh --cmd cd)"          # https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation
eval "$(atuin init zsh --disable-up-arrow)" # Bind ctrl-r but not up arrow, https://atuin.sh/ 
eval "$(starship init zsh)"                 # https://starship.rs/guide/#step-2-set-up-your-shell-to-use-starship
