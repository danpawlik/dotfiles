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
