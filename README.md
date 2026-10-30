# My dotfiles

My dotfiles configuration.

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
sudo dnf install -y git ansible-core
git clone https://github.com/danpawlik/dotfiles
ansible-playbook --ask-become-pass dotfiles/ansible/playbooks/dotfiles.yml
```

The Ansible collections used by the role are installed by the `ansible` component.

### Use ansible to install vim

```shell
sudo dnf install -y git ansible-core
git clone https://github.com/danpawlik/dotfiles
ansible-playbook --ask-become-pass dotfiles/ansible/playbooks/vim.yml
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

The `vim` playbook installs Neovim and the NvChad config from `vimrc/nvchad`
(`nvim_config: nvchad`). To use another distribution, clone it into
`~/.config/nvim`, replacing the config installed by the playbook.

### Preparation

```shell
sudo dnf install -y git python3-pip
pip3 install -U setuptools pip
git clone https://github.com/danpawlik/dotfiles
ansible-playbook --ask-become-pass dotfiles/ansible/playbooks/vim.yml
```

Distros, for example:

### <https://github.com/AstroNvim/AstroNvim>

```shell
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
nvim
```

### <https://github.com/NvChad/NvChad>

```shell
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
nvim
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
# For vim config and neovim
sudo rm -rf ~/.local/nvim ~/.local/share/nvim ~/.cache/nvim ~/.config/nvim ~/.local/nodejs ~/.vim ~/.vimrc ~/.local/bin/node ~/.local/bin/npm ~/.local/bin/vim
```
