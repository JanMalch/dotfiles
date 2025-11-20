# https://eza.rocks/#completions
export FPATH="$XDG_CONFIG_HOME/eza/completions/zsh:$FPATH"

# https://junegunn.github.io/fzf/installation/#setting-up-shell-integration
source <(fzf --zsh)

# https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation
eval "$(zoxide init zsh --cmd cd)"

# https://carapace-sh.github.io/carapace-bin/setup.html
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

# https://eza.rocks/
# Not using -l because it makes it harder to use with fzf.
# Just use "la" if you want something like "ls -la".
alias ls="eza --icons"
alias tree="eza --tree --level=2 --icons"

# https://podman.io/
alias docker="podman"

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Colors
# https://github.com/sharkdp/pastel#readme
function hex2rgb {
    pastel color "$1" | pastel format rgb
}
function rgb2hex {
    pastel color "$1" | pastel format hex
}

# Starship always at the end
# https://starship.rs/guide/#step-2-set-up-your-shell-to-use-starship
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
eval "$(starship init zsh)"
