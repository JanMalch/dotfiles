alias vim="nvim"

export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export EDITOR="vim"

export GOPATH="$HOME/go"
# Put standalone binaries like roar and argus in $HOME/bin
# Scripts from my git repository are in $HOME/scripts
export PATH="$GOPATH/bin:$HOME/bin:$HOME/scripts:$PATH"

# https://github.com/JanMalch/argus
export ARGUS_HOME="$HOME/argus"
