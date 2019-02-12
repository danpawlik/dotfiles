export ZSH=$HOME/.oh-my-zsh

export PATH=$HOME/homebrew/bin/:$HOME/Library/Python/2.7/bin/:/usr/local/share/python/:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

if [ -f "$HOME/.zsh_aliases" ]; then
    source "$HOME/.zsh_aliases"
fi

#ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
#ZSH_THEME="risto"
#ZSH_THEME="michelebologna"
#ZSH_THEME="example"
#ZSH_THEME="spaceship"
#ZSH_THEME="fishy"
ZSH_THEME="spaceship"

CASE_SENSITIVE="true"

HYPHEN_INSENSITIVE="true"

# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=7
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd/mm/yyyy"
# ZSH_CUSTOM=/path/to/new-custom-folder
plugins=(
  git,
  brew,
  cp,
  github,
  rsync,
  screen,
  virtualenv
)

export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export SSH_KEY_PATH="~/.ssh/rsa_id"
unsetopt correct_all

# Spaceship
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_COLOR=cyan
SPACESHIP_USER_SHOW=always
SPACESHIP_USER_COLOR=green
SPACESHIP_HOST_SHOW=true
SPACESHIP_DIR_SHOW=true
SPACESHIP_GIT_SHOW=true
SPACESHIP_GIT_BRANCH_SHOW=true
SPACESHIP_GIT_STATUS_SHOW=true
SPACESHIP_GIT_BRANCH_COLOR=blue
SPACESHIP_DOCKER_SHOW=true
SPACESHIP_VENV_SHOW=true
SPACESHIP_GIT_BRANCH_PREFIX=""
SPACESHIP_USER_PREFIX=""

# History line
#PROMPT='%{%f%k%b%}%{%K{${bkg}}%B%F{red}%}%n%{%B%F{blue}%}@%{%B%F{green}%}%m%{%B%F{green}%} %{%b%F{yellow}%K{${bkg}}%}%~%{%B%F{green}%}$(git_prompt_info)%E%{%f%k%b%}$ '
#RPROMPT='!%{%B%F{cyan}%}%!%{%f%k%b%}'

# Exit code
#PROMPT='%{%f%k%b%}%{%K{${bkg}}%B%F{red}%}%n%{%B%F{blue}%}@%{%B%F{green}%}%m%{%B%F{green}%} %{%b%F{yellow}%K{${bkg}}%}%~%{%B%F{green}%}$(git_prompt_info)%E%{%f%k%b%}$ '
#RPROMPT='[%F{cyan}%?%f]'
