# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [ -f "$HOME/.bash_aliases" ]; then
    source "$HOME/.bash_aliases"
fi

# ble.sh - fish-like autosuggestions
[[ -f "$HOME/.local/share/blesh/ble.sh" ]] && source "$HOME/.local/share/blesh/ble.sh"

xset b off 2>/dev/null

export PATH=~/android-platform-tools:$HOME/.local/bin/:$PATH
export LANG=en_US.UTF-8
export EDITOR='vim'
export SSH_KEY_PATH="~/.ssh/id_rsa"

# History
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth:erasedups
HISTTIMEFORMAT="%Y-%m-%d "
shopt -s histappend

alias vimdiff="nvim -d"
export PATH=~/.local/bin:~/go/bin:/usr/local/bin/:$PATH
export DOCKER_HOST=unix:///run/user/$(id -u)/podman//podman.sock

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

bind '"\e[1~": beginning-of-line'
bind '"\e[4~": end-of-line'

# pnpm
export PNPM_HOME="/home/dpawlik/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
#
if command -v kubectl &>/dev/null; then
    source <(kubectl completion bash)
    alias k='kubectl'
    complete -o default -F __start_kubectl k
fi

export PATH=~/.cargo/bin/:~/.local/share/nvim/mason/bin/:$PATH

# Starship prompt (load last)
if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
fi
