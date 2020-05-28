if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export LANG=en_US.UTF-8

xset b off

if [ -f "$HOME/.zsh_aliases" ]; then
    source "$HOME/.zsh_aliases"
fi

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
fi

export SSH_KEY_PATH="~/.ssh/id_rsa"

if [ -f "$HOME/.starship.toml" ]; then
    export STARSHIP_CONFIG=~/.starship.toml
    eval "$(starship init zsh)"
fi

