autoload -Uz compinit && compinit
# https://stackoverflow.com/questions/13762280/zsh-compinit-insecure-directories
# compaudit | xargs chmod g-w

# autoload all functions
fpath=("$ZDOTDIR/functions" $fpath)
for file in "$ZDOTDIR/functions/*"; do autoload -Uz "$(basename $file)"; done

# Reevaluate the prompt string each time it's displaying a prompt
setopt prompt_subst
# Don't add commands with leading space to history
setopt hist_ignore_space
# Delete duplicates first when HISTFILE size exceeds HISTSIZE.
setopt hist_expire_dups_first
# Ignore duplicated commands history list.
setopt hist_ignore_dups

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
zvm_after_init() {
  zvm_bindkey viins '^R' atuin-search
  zvm_bindkey vicmd '^R' atuin-search
}

# https://github.com/catppuccin/fzf/blob/7c2e05606f2e75840b1ba367b1f997cd919809b3/themes/catppuccin-fzf-macchiato.sh
export FZF_DEFAULT_OPTS=" \
    --color=bg+:#363A4F,bg:#24273A,spinner:#F4DBD6,hl:#ED8796 \
    --color=fg:#CAD3F5,header:#ED8796,info:#C6A0F6,pointer:#F4DBD6 \
    --color=marker:#B7BDF8,fg+:#CAD3F5,prompt:#C6A0F6,hl+:#ED8796 \
    --color=selected-bg:#494D64 \
    --color=border:#6E738D,label:#CAD3F5"
# only use git files by default
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
source <(fzf --zsh)

# https://carapace-sh.github.io/carapace-bin/setup.html
export CARAPACE_BRIDGES='zsh'
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

# https://eza.rocks/
# Not using -l because it makes it harder to use with fzf.
# Just use "la" if you want something like "ls -la".
# Also: using carapace for eza completions
export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"
alias ls="eza --icons=auto"
alias la="eza -labh --no-user --icons=auto"
alias tree="eza --tree --level=2 --icons=auto"

# misc
alias vim="nvim"
alias v="nvim"
alias docker="podman"
alias cat="bat"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

hex2rgb() { pastel color "$1" | pastel format rgb; }
rgb2hex() { pastel color "$1" | pastel format hex; }
jqv() { nvim +JqPlayground $1; }
help() { "$@" --help 2>&1 | bat --plain --language=help; }
helpv() { "$@" --help 2>&1 | vim; }
dus() {
    # obsolete with https://github.com/bootandy/dust/issues/536
    dust --collapse=node_modules --collapse=.git --collapse=.kotlin --collapse=.gradle $@
}

eval "$(zoxide init zsh --cmd cd)"
eval "$(atuin init zsh --disable-up-arrow)"
eval "$(ruby "$HOME/.localrb/try.rb" init)"

# Starship always at the end
# https://starship.rs/guide/#step-2-set-up-your-shell-to-use-starship
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
eval "$(starship init zsh)"
