export PATH=$HOME/.local/bin/:$PATH
export LANG=en_US.UTF-8

# Disable beep in xorg
xset b off

if [ -f "$HOME/.zsh_aliases" ]; then
    source "$HOME/.zsh_aliases"
fi

#ZSH_THEME="agnoster"
#ZSH_THEME="fishy"
#ZSH_THEME="risto"
#ZSH_THEME="michelebologna"
ZSH_THEME="powerlevel10k/powerlevel10k"

# CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="false"
HIST_STAMPS="yyyy-mm-dd"
plugins=(git git-extras python pip tmux ansible cp dnf yum )

export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

export EDITOR='vim'
export SSH_KEY_PATH="~/.ssh/id_rsa"
unsetopt correct_all
#
## History line
#PROMPT='%{%f%k%b%}%{%K{${bkg}}%B%F{red}%}%n%{%B%F{blue}%}@%{%B%F{green}%}%m%{%B%F{green}%} %{%b%F{yellow}%K{${bkg}}%}%~%{%B%F{green}%}$(git_prompt_info)%E%{%f%k%b%}$ '
#RPROMPT='!%{%B%F{cyan}%}%!%{%f%k%b%}'
#
## Exit code
#PROMPT='%{%f%k%b%}%{%K{${bkg}}%B%F{red}%}%n%{%B%F{blue}%}@%{%B%F{green}%}%m%{%B%F{green}%} %{%b%F{yellow}%K{${bkg}}%}%~%{%B%F{green}%}$(git_prompt_info)%E%{%f%k%b%}$ '
#RPROMPT='[%F{cyan}%?%f]'
