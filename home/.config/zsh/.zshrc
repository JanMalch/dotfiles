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

# see functions below
export TRY_PATH="$HOME/tries"
export CHEATS_PATH="$HOME/cheats" 

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

alias cl='clear'

alias vim="nvim"
alias v="nvim"

alias cat="bat"       # https://github.com/sharkdp/bat
alias docker="podman" # https://podman.io/

# https://eza.rocks/
# Not using -l because it makes it harder to use with fzf.
# Just use "la" if you want something like "ls -la".
# Also: using carapace for eza completions
alias ls="eza --group-directories-first --icons=auto"
alias la="eza --group-directories-first -labh --no-user --icons=auto --git"
alias tree="eza --group-directories-first --tree --level=2 --icons=auto"

# verbose & confirm overwrites
alias mv="mv -iv"
alias cp="cp -riv"
alias mkdir="mkdir -vp"

# Copying
if [ "$(command -v "xclip")" ]; then
  alias copy="xclip"
  alias paste="xclip -o"
elif [ "$(command -v "pbcopy")" ]; then
  alias copy="pbcopy"
  alias paste="pbpaste"
fi

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias mkcd="takedir" # see function below

# ----------------------
# Functions
# ----------------------

autoload -U zmv # built-in zsh mass file renaming

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

cx() { cd "$@" && ls -a; }
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && ls -a; }
yl() { cat - | sed "${1}q;d" | copy; }
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
extract() {
  case $1 in
    *.tar.gz|*.tgz) tar -xzf "$1";;
    *.tar.bz2|*.tbz2) tar -xjf "$1";;
    *.zip) unzip "$1";;
    *.rar) unrar x "$1";;
    *) echo "Unknown archive format";;
  esac
}

# fzf-based replacement for https://github.com/tobi/try
# When fzf is closed with enter, it will create a directory with the name of the entered query.
# When called without a query, it prepopulates it with the current date.
# If you absolutely don't know what you are searching for, you can just call `try 2`,
# which will show all tries, because every directory has a 2 in it, because of the year.
# And if you don't use that date "convention", then you can remove the 2 with one stroke.
try() {
  local query
  query="$1"
  local opt
  if [ -z "$query" ]; then
    query=$(date +"%Y-%m-%d-")
  else
    opt="-1"
  fi
  local fzf_out
  fzf_out=$(ls "$TRY_PATH" | fzf --print-query --style full --preview 'printf "%s/%s" "$TRY_PATH" {} | xargs eza --group-directories-first --tree --level=2 --icons=auto --color=always' $opt --query "$query")
  local selected
  selected=$(echo "$fzf_out" | tail -1)
  if [ -z "$selected" ]; then
    return 1
  else
    mkdir -p "$TRY_PATH/$selected" && cx "$TRY_PATH/$selected"
  fi
}

# ----------------------
# Functions: take
# ----------------------

# https://batsov.com/articles/2022/09/16/oh-my-zsh-fun-with-take/

take() {
  if [[ $1 =~ ^(https?|ftp).*\.tar\.(gz|bz2|xz)$ ]]; then
    takeurl "$1"
  elif [[ $1 =~ ^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]; then
    takegit "$1"
  else
    takedir "$@"
  fi
}

takedir() {
  mkdir -p $@ && cd ${@:$#}
}

takegit() {
  git clone "$1"
  cd "$(basename ${1%%.git})"
}

takeurl() {
  local data thedir
  data="$(mktemp)"
  curl -L "$1" > "$data"
  # TODO: use extract
  tar xf "$data"
  thedir="$(tar tf "$data" | head -n 1)"
  rm "$data"
  cd "$thedir"
}

# ----------------------
# Functions: Cheatsheets
# ----------------------

cheat() {
    local query="${1-}"
    local selected
    selected="$(ls "$CHEATS_PATH" | fzf -1 --preview "bat --plain --color=always $CHEATS_PATH/{-1}" -q "$query")"
    if [[ -z "$selected" ]]; then
        return 1
    else
        bat --style="numbers,grid" "$CHEATS_PATH/$selected"
    fi   
}

cheatv() {
    local query="${1-}"
    local selected
    selected="$(ls "$CHEATS_PATH" | fzf -1 --preview "bat --plain --color=always $CHEATS_PATH/{-1}" -q "$query")"
    if [[ -z "$selected" ]]; then
        return 1
    else
        v "$CHEATS_PATH/$selected"
    fi   
}

cheater() {
    local query="${1-}"
    if [[ -z "$query" ]]; then
       echo "cheater must be called with exactly one argument"
       return 1
    fi
    local selected
    selected="$(rg -s -l -e "$query" "$CHEATS_PATH" | fzf -1 --preview "bat --plain --color=always {-1}")"
    if [[ -z "$selected" ]]; then
        return 1
    else
        vim "$selected"
    fi
}

# ----------------------
# Functions: Transcoding
# Source: https://github.com/basecamp/omarchy/blob/886320acee68f374d3c29696c764e3f67f08d071/default/bash/fns/transcoding
# ----------------------

# Transcode a video to a good-balance 1080p that's great for sharing online
transcode-video-1080p() {
  ffmpeg -i "$1" -vf scale=1920:1080 -c:v libx264 -preset fast -crf 23 -c:a copy "${1%.*}-1080p.mp4"
}

# Transcode a video to a good-balance 4K that's great for sharing online
transcode-video-4K() {
  ffmpeg -i "$1" -c:v libx265 -preset slow -crf 24 -c:a aac -b:a 192k "${1%.*}-optimized.mp4"
}

# Transcode any image to JPG image that's great for shrinking wallpapers
img2jpg() {
  img="$1"
  shift

  magick "$img" "$@" -quality 95 -strip "${img%.*}-converted.jpg"
}

# Transcode any image to a small JPG (max 1080px wide) that's great for sharing online
img2jpg-small() {
  img="$1"
  shift

  magick "$img" "$@" -resize 1080x\> -quality 95 -strip "${img%.*}-small.jpg"
}

# Transcode any image to a medium JPG (max 1800px wide) that's great for sharing online
img2jpg-medium() {
  img="$1"
  shift

  magick "$img" "$@" -resize 1800x\> -quality 95 -strip "${img%.*}-medium.jpg"
}

# Transcode any image to compressed-but-lossless PNG
img2png() {
  img="$1"
  shift

  magick "$img" "$@" -strip -define png:compression-filter=5 \
    -define png:compression-level=9 \
    -define png:compression-strategy=1 \
    -define png:exclude-chunk=all \
    "${img%.*}-optimized.png"
}

# ----------------------
# Tools
# ----------------------

# https://superfile.dev/configure/superfile-config/#macoslinux-bash-or-fish
spf() {
    os=$(uname -s)

    # Linux
    if [[ "$os" == "Linux" ]]; then
        export SPF_LAST_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/superfile/lastdir"
    fi

    # macOS
    if [[ "$os" == "Darwin" ]]; then
        export SPF_LAST_DIR="$HOME/Library/Application Support/superfile/lastdir"
    fi

    command spf "$@"

    [ ! -f "$SPF_LAST_DIR" ] || {
        . "$SPF_LAST_DIR"
        rm -f -- "$SPF_LAST_DIR" > /dev/null
    }
}

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
eval "$(zoxide init zsh --cmd cd)"          # https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation
eval "$(atuin init zsh --disable-up-arrow)" # Bind ctrl-r but not up arrow, https://atuin.sh/ 
eval "$(starship init zsh)"                 # https://starship.rs/guide/#step-2-set-up-your-shell-to-use-starship
