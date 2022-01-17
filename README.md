# My dotfiles
My dotfiles configurtion.

## Vim configuration

![Vimrc screenshot](https://raw.githubusercontent.com/danpawlik/dotfiles/master/screenshots/vim.png)

tl; dr

```shell
curl -SL https://raw.githubusercontent.com/danpawlik/dotfiles/master/setup-vim.sh | bash
```

or use neovim nightly version:

```shell
curl -SL https://raw.githubusercontent.com/danpawlik/dotfiles/master/setup-vim.sh | NVIM_VERSION=nightly bash
```

If you want to install some other vim distribution, that works well on `neovim` like:

* [init.nvim](https://github.com/Blacksuan19/init.nvim)
* [spacevim](https://github.com/SpaceVim/SpaceVim)
* [Janus](https://github.com/carlhuda/janus)
* [spf13](https://github.com/spf13/spf13-vim)


## Use ansible to install dotfiles

```shell
sudo yum install -y git ansible
git clone https://github.com/danpawlik/dotfiles
ansible-playbook --ask-become-pass dotfiles/ansible/playbooks/dotfiles.yml
```

## ZSH and others

tl; dr

```shell
curl -LO https://raw.githubusercontent.com/danpawlik/dotfiles/master/install.sh | bash
```

## Tmux

tl;dr

```shell
curl -SL https://raw.githubusercontent.com/danpawlik/dotfiles/master/tmux/.tmux.conf > $HOME/.tmux.conf
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
$HOME/.tmux/plugins/tpm/bin/install_plugins
```

![Tmux screenshot](https://raw.githubusercontent.com/danpawlik/dotfiles/master/screenshots/default.png)
![Tmux screenshot multiuser](https://raw.githubusercontent.com/danpawlik/dotfiles/master/screenshots/multiuser.png)
![Tmux screenshot production](https://raw.githubusercontent.com/danpawlik/dotfiles/master/screenshots/tmux-production.png)
