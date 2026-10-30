# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# ble.sh: fish-like autosuggestions, syntax highlighting, better completion.
# Load core without attaching; attach at the end for fast startup.
source ~/.local/share/blesh/ble.sh --noattach

if [ -f "$HOME/.bash_aliases" ]; then
    source "$HOME/.bash_aliases"
fi

xset b off 2>/dev/null

export LANG=en_US.UTF-8
export EDITOR='vim'
export SSH_KEY_PATH="~/.ssh/id_rsa"
export DOCKER_HOST=unix:///run/user/$(id -u)/podman//podman.sock

# History
HISTSIZE=50000
HISTFILESIZE=100000
HISTCONTROL=ignoreboth:erasedups
HISTTIMEFORMAT="%Y-%m-%d "
shopt -s histappend checkwinsize

# fzf: fuzzy history search (Ctrl-R), files (Ctrl-T), cd (Alt-C)
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
ble-import contrib/integration/fzf-key-bindings
# Fuzzy Tab completion: type "viking", press Tab -> matches openai-viking-test
ble-import contrib/integration/fzf-completion
ble-bind -m emacs -f tab fzf-complete

# Prompt, powerlevel10k "lean" look:
#   ~/dotfiles master ⇡6 *12 +1 !3 -1 ?2 ❯                 ✘ INT venv 09:01:00
ble-import contrib/prompt-git
export VIRTUAL_ENV_DISABLE_PROMPT=1   # venv is shown on the right instead

# \q{dir}: parent path steel blue, last component bold bright blue
function ble/prompt/backslash:dir {
  local p=$PWD
  [[ $p == "$HOME" || $p == "$HOME"/* ]] && p="~${p#"$HOME"}"
  local head= tail=$p
  [[ $p == */* ]] && head=${p%/*}/ tail=${p##*/}
  ble/prompt/print $'\e[0;38;5;31m'"$head"$'\e[1;38;5;39m'"$tail"$'\e[0m'
}

# Git counts from one async "git status --porcelain=v2 --branch --show-stash"
_ble_gitstat=
ble/contrib/prompt-defer/clear _ble_gitstat
function ble/contrib/prompt-defer:_ble_gitstat/clear { _ble_gitstat=; }
function ble/contrib/prompt-defer:_ble_gitstat/worker {
  local line xy ahead=0 behind=0 stash=0 staged=0 modified=0 deleted=0 untracked=0
  while IFS= read -r line; do
    case $line in
    ('# branch.ab '*)
      line=${line#'# branch.ab +'}; ahead=${line%% *}; behind=${line##*-} ;;
    ('# stash '*) stash=${line#'# stash '} ;;
    ([12u]' '*)
      xy=${line:2:2}
      if [[ $xy == *D* ]]; then
        ((++deleted))
      else
        [[ ${xy::1} != . ]] && ((++staged))
        [[ ${xy:1} != . ]] && ((++modified))
      fi ;;
    ('? '*) ((++untracked)) ;;
    esac
  done < <(git status --porcelain=v2 --branch --show-stash 2>/dev/null)
  ble/util/put "$ahead $behind $stash $staged $modified $deleted $untracked" >| "$_ble_base_run/$$.gitstat"
}
function ble/contrib/prompt-defer:_ble_gitstat/callback {
  local ret=
  ble/util/readfile ret "$_ble_base_run/$$.gitstat" 2>/dev/null
  _ble_gitstat=${ret%$'\n'}
}

# \q{gitprompt}: branch + ⇣behind ⇡ahead *stash (green), +staged !modified
# -deleted (yellow), ?untracked (blue)
function ble/prompt/backslash:gitprompt {
  local "${_ble_contrib_prompt_git_vars[@]/%/=}" # WA #D1570 checked
  ble/contrib/prompt-git/initialize || return 0
  ble/contrib/prompt-git/update-head-information
  local out=$' \e[0;38;5;76m'${branch:-@${hash::7}}
  ble/contrib/prompt-defer/submit _ble_gitstat "$PWD" ''
  ble/prompt/unit/add-hash '$_ble_gitstat'
  local ahead=0 behind=0 stash=0 staged=0 modified=0 deleted=0 untracked=0
  read -r ahead behind stash staged modified deleted untracked <<< "$_ble_gitstat"
  ((behind))    && out+=" ⇣$behind"
  ((ahead))     && out+=" ⇡$ahead"
  ((stash))     && out+=" *$stash"
  ((staged))    && out+=$' \e[38;5;178m+'$staged
  ((modified))  && out+=$' \e[38;5;178m!'$modified
  ((deleted))   && out+=$' \e[38;5;178m-'$deleted
  ((untracked)) && out+=$' \e[38;5;39m?'$untracked
  ble/prompt/print "$out"$'\e[0m'
}

# \q{pchar}: ❯ green, red after a failed command
function ble/prompt/backslash:pchar {
  ble/prompt/unit/add-hash '$_ble_edit_exec_lastexit'
  if ((_ble_edit_exec_lastexit)); then
    ble/prompt/print $'\e[38;5;196m❯\e[0m'
  else
    ble/prompt/print $'\e[38;5;76m❯\e[0m'
  fi
}

# \q{status}: "✘ 1" / "✘ INT" on the right after a failed command
function ble/prompt/backslash:status {
  ble/prompt/unit/add-hash '$_ble_edit_exec_lastexit'
  local e=$_ble_edit_exec_lastexit s
  ((e)) || return 0
  s=$e
  ((e > 128)) && s=$(builtin kill -l $((e - 128)) 2>/dev/null) || s=$e
  ble/prompt/print $'\e[38;5;160m✘ '"$s"$'\e[0m '
}

# \q{venv}: active python virtualenv name
function ble/prompt/backslash:venv {
  ble/prompt/unit/add-hash '$VIRTUAL_ENV'
  [[ ${VIRTUAL_ENV-} ]] || return 0
  ble/prompt/print $'\e[38;5;37m'"${VIRTUAL_ENV##*/}"$'\e[0m '
}

PS1='\q{dir}\q{gitprompt} \q{pchar} '
bleopt prompt_rps1='\q{status}\q{venv}\e[38;5;66m\t\e[0m'

alias vimdiff="nvim -d"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"

if command -v kubectl &>/dev/null; then
    source <(kubectl completion bash)
    alias k='kubectl'
    complete -o default -F __start_kubectl k
fi

export PATH="$PNPM_HOME:$HOME/.local/bin:$HOME/go/bin:/usr/local/bin:$HOME/.cargo/bin:$HOME/.local/share/nvim/mason/bin:$HOME/android-platform-tools:$PATH"

# ls: colorized output. vivid only generates LS_COLORS, the alias turns on --color.
# The "ansi" theme reuses the terminal palette and leaves regular files uncolored.
if command -v vivid >/dev/null 2>&1; then
    if _ls_colors=$(vivid generate "${VIVID_THEME:-ansi}"); then
        # regular files with multiple hard links: bold magenta (vivid leaves them uncolored)
        export LS_COLORS="$_ls_colors:mh=1;35"
    fi
    unset _ls_colors
fi
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -la --color=auto'

# Attach ble.sh last
[[ ${BLE_VERSION-} ]] && ble-attach

# zsh-like Ctrl+W: kill only the current word, stopping at / . - and other
# punctuation instead of deleting the whole shell word. Use Ctrl+U to clear
# everything to the left. Ctrl+K still kills everything to the right.
if [[ ${BLE_VERSION-} ]]; then
    ble-bind -m emacs -f C-w kill-backward-cword
fi
