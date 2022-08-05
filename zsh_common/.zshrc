if [ -f "$HOME/.zsh_aliases" ]; then
    source "$HOME/.zsh_aliases"
fi

if [ -f "$HOME/.zsh_prezto" ]; then
# Source Prezto.
    if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
      source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
    fi
    source "$HOME/.zsh_prezto"
fi

if [ -f "$HOME/.zsh_ohmyzsh" ]; then
    source "$HOME/.zsh_ohmyzsh"
fi

xset b off

export PATH=~/android-platform-tools:$HOME/.local/bin/:$PATH
export LANG=en_US.UTF-8
export EDITOR='vim'
export SSH_KEY_PATH="~/.ssh/id_rsa"

unsetopt correct_all

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias vimdiff="nvim"
alias vimdiff="nvim -d"
export PATH=~/.local/bin:~/go/bin:/usr/local/bin/:$PATH
export DOCKER_HOST=unix:///run/user/$(id -u)/podman//podman.sock

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

bindkey "\033[1~" beginning-of-line
bindkey "\033[4~" end-of-line

# pnpm
export PNPM_HOME="/home/dpawlik/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
#
source <(kubectl completion zsh)
alias k='kubectl'
