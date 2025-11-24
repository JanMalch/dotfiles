# XDG base directories.
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export EDITOR="$(which nvim)"
export VISUAL="$EDITOR"

alias vim="nvim"

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Put standalone binaries like roar and argus in $HOME/bin
# Scripts from my git repository are in $HOME/scripts
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/scripts:$PATH"

# https://github.com/JanMalch/argus
export ARGUS_HOME="$HOME/argus"

# https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#configuration-file
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/.ripgreprc"
