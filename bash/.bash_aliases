alias agent='eval $(ssh-agent -s)'
alias docker='podman'
alias pogoda='curl -H "Accept-Language: pl" wttr.in/wroclaw'
alias cleanup-repo='git rebase --abort; git cherry-pick --abort; git merge --abort; git remote update; git checkout master; git checkout main; git reset --hard origin/master;  git reset --hard origin/main; git clean -d -f -x'

alias week='date +"So this is week: %V"'

if [ -f "$HOME/.bash_aliases_work" ]; then
    source "$HOME/.bash_aliases_work"
fi

alias vim="~/.local/bin/nvim"
alias emacs="emacs -nw"

alias sshn='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
alias scpn='scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
