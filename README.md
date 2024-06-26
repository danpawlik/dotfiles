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
ansible-galaxy collection install community.general
ansible-playbook --ask-become-pass dotfiles/ansible/playbooks/dotfiles.yml
```

### Use ansible to install vim

```shell
sudo yum install -y git ansible
git clone https://github.com/danpawlik/dotfiles
ansible-playbook --ask-become-pass dotfiles/ansible/playbooks/vim.yml
```

On Centos 7, you can run it with:

```shell
ansible-playbook --ask-become-pass -e ansible_python_interpreter=/usr/bin/python2 ansible/playbooks/vim.yml
```

When you have an error:

```shell
No "python3" provider found. Run ":checkhealth provider"
```

Install `pynvim` package into python user environment for all Python3 releases.
For example:

```shell
python3.10 -m pip install --user pynvim
python3.9 -m pip install --user pynvim
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

## Vim alternative distributions

You can always install just neovim, then choose proper distribution:

### Preparation

```shell
yum install -y git python3-pip
pip3 install -U setuptools pip
pip3 install ansible==2.9.13
export PATH=$PATH:/usr/local/bin
git clone https://github.com/danpawlik/dotfiles
ansible-playbook --ask-become-pass -e just_neovim=true dotfiles/ansible/playbooks/vim.yml
```

Or for Centos 7:

```shell
ansible-playbook --ask-become-pass \
  -e just_neovim=true \
  -e ansible_python_interpreter=/usr/bin/python2 \
  dotfiles/ansible/playbooks/vim.yml
```

Distros, for example:

### <https://github.com/AstroNvim/AstroNvim>

```shell
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
nvim +PackerSync
```

Works well on `Centos 7` and newer.

### <https://github.com/NvChad/NvChad>

```shell
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
nvim +'hi NormalFloat guibg=#1e222a' +PackerSync
```

NOTE:
Replace vim with python some nvim-treesitter on `Centos 7`:

```shell
sed -i 's/      \"vim\",/      \"python\",/g' ~/.config/nvim/lua/plugins/configs/treesitter.lua
```

### <https://github.com/LunarVim/LunarVim>

Before, install:

```shell
# if Centos
sudo yum install -y epel-relase
sudo yum install -y neovim cargo gcc-c++ gcc
```

```shell
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh) -y
```

And copy my config into the LunarVim dir:

```shell
cp lvim/lunar-vim.lua ~/.config/lvim/config.lua
```

NOTE:
Disable some nvim-treesitter on `Centos 7`:

```shell
sed -i '/  \"javascript\"/d' ~/.config/lvim/config.lua
sed -i '/  \"typescript\"/d' ~/.config/lvim/config.lua
sed -i '/  \"tsx\"/d' ~/.config/lvim/config.lua
```

## Post configuration

To disable mouse copy as visualization or remove whitespaces, add on the end to the `~/.config/nvim/init.lua`

```lua
vim.cmd [[set mouse-=a]]

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})
```

### Install additional languages

Run inside the neovim distro:

You can choose the Lsp packages to be installed via plugin manager and press "i" on desired plugin:

```shell
:Mason
```

via Mason:

```shell
:MasonInstall ansible-lint bash-language-server checkmake commitlint dhall-lsp dockerfile-language-server gitlint goimports gopls helm-ls html-lsp jedi-language-server jinja-lsp jq-lsp json-lsp lua-language-server markdownlint marksman misspell prettier pyright python-lsp-server rstcheck ruff ruff-lsp rust-analyzer shellcheck staticcheck systemdlint trivy vim-language-server yaml-language-server yamllint
```

Make sure, that `~/.local/share/nvim/mason/bin/` is set in the PATH.
Additional configs: https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/server_configurations

To check what `LSP` or `TS` plugins are enabled, type in vim:

```shell
LspInfo
```

For TS:

Basic plugins,eg.:

```shell
:TSInstall bash cmake comment css dockerfile go graphql haskell html http javascript json make markdown python rst rust typescript vim yaml
```

```shell
TSModuleInfo
```

### Removing

```shell
# to uninstall just lvim
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/uninstall.sh)

# For vim config and neovim
sudo rm -rf ~/.local/nvim ~/.local/share/nvim ~/.cache/nvim ~/.config/nvim ~/.local/nodejs ~/.vim ~/.vimrc ~/.config/coc ~/.config/lvim ~/.local/share/lunarvim ~/.cache/lvim ~/.local/bin/node ~/.local/bin/npm ~/.local/bin/vim
```
