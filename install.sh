#!/bin/bash

SOURCE_DIR=${SOURCE_DIR:-'/tmp/dotfiles'}
USE_ZSH=${USE_ZSH:-0}
USE_OH_MY_ZSH=${USE_OH_MY_ZSH:-0}
USE_PREZTO_ZSH=${USE_PREZTO_ZSH:-1}
USE_POWERLEVEL10K=${USE_POWERLEVEL10K:-0}
USE_GNOME=${USE_GNOME:-1}
INSTALL_VIM=${INSTALL_VIM:-0}
INSTALL_EMACS=${INSTALL_EMACS:-0}

INSTALL_ANDROIND_ADB=${INSTALL_ANDROIND_ADB:-1}

sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install -y htop glances vim-enhanced axel mumble \
                    gnupg zsh zstd bzip2 tmux \
                    pinta alacritty keepassxc fwupd vlc \
                    p7zip unzip ccze wavemon powertop \
                    rsync util-linux-user

if [ "$USE_GNOME" -eq "0" ]; then
    sudo yum install -y gnome-tweaks gnome-backgrounds-extras variety
fi

sudo dnf groupinstall -y development-tools
sudo dnf install -y python3-devel python2-devel python3-pip \
                    git qemu libvirt virt-manager podman podman-docker

sudo yum remove -y nano

sudo yum install -y https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

# brave
sudo dnf install dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install -y brave-browser

# some python libs
# pip --user install pdbpp remote_pdb mypy
pip3 --user install pdbpp remote_pdb mypy pip -U --force-reinstall

# npm
curl --silent --location https://rpm.nodesource.com/setup_14.x | sudo bash -
sudo npm install -g pnpm prettier

# dotfiles
mkdir -p ~/.vim/
if ! [ -d "${SOURCE_DIR}" ]; then
    git clone https://github.com/danpawlik/dotfiles.git "${SOURCE_DIR}"
fi

# vim
if [ "$INSTALL_VIM" -eq "0" ]; then
    bash "${SOURCE_DIR}/setup-vim.sh"
fi

if [ "$INSTALL_EMACS" -eq "0" ]; then
    sudo yum install -y ShellCheck marked ripgrep fd-find || true
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
fi

# android
if [ "$INSTALL_ANDROIND_ADB" -eq "0" ]; then
    sudo yum install -y android-tools.x86_64
    git clone https://github.com/M0Rf30/android-udev-rules /tmp/android-udev-rules
    sudo bash -x /tmp/android-udev-rules/install.sh "$(whoami)"
fi

# tmux
git clone https://github.com/gpakosz/.tmux.git "${HOME}/.tmux"
ln -s "${HOME}/.tmux/.tmux.conf" "${HOME}/.tmux.conf"
cp -a $SOURCE_DIR/tmux/.tmux* "${HOME}/"

if [ "$USE_ZSH" -eq "0" ]; then
    # prezto
    if [ "$USE_PREZTO_ZSH" -eq "0" ]; then
        git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
        setopt EXTENDED_GLOB
        for rcfile in $(ls "${HOME}/.zprezto/runcoms/" | grep -vi 'readme'); do
          ln -s "${HOME}/.zprezto/runcoms/${rcfile}" "${ZDOTDIR:-$HOME}/.${rcfile}"
        done
        cp -a $SOURCE_DIR/prezto/.z* "${HOME}/.zprezto/runcoms/"
        git clone --recurse-submodules https://github.com/belak/prezto-contrib "${ZPREZTODIR}/contrib"

        # starship
        mkdir -p "${HOME}/.config"
        curl -SL https://starship.rs/install.sh > /tmp/starship.sh
        bash /tmp/starship.sh -y
        cp -a $SOURCE_DIR/starship/starship.toml "${HOME}/.config/"
    fi

    # oh my zsh
    if [ "$USE_OH_MY_ZSH" -eq "0" ]; then
        unset ZSH
        curl -SL "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh" | bash
        if [ "$USE_POWERLEVEL10K" -eq "0" ]; then
            cp $SOURCE_DIR/powerlevel10k/.p10k.zsh "${HOME}/"
            git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
        fi
        # install zsh autosuggestions.
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        cp -a $SOURCE_DIR/oh_my_zsh/.z* "${HOME}/"
    fi

    cp -a $SOURCE_DIR/zsh_common/.z* "$HOME/"
    # FIXME: it requires password
    # chsh -s /bin/zsh
    source "${HOME}/.zshrc"
fi

# add FZF
$HOME/.vim/plugged/fzf/install --all

# alacritty
mkdir -p "${HOME}/.config"
cp -a $SOURCE_DIR/alacritty "${HOME}/.config/"

# git
git config --global core.editor vim

# install fonts
FONT_DIR=/tmp/fonts
mkdir -p "${FONT_DIR}" "${HOME}/.fonts"
curl -SL https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip > $FONT_DIR/Fira_code.zip
curl -SL https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip > $FONT_DIR/Hack.zip
curl -SL https://fonts.google.com/download?family=Work%20Sans > $FONT_DIR/Work_Sans.zip
curl -SL https://fonts.google.com/download?family=Source%20Sans%20Pro > $FONT_DIR/Source_Sans_Pro.zip
curl -SL https://fonts.google.com/download?family=Lato > $FONT_DIR/Lato.zip
curl -SL https://fonts.google.com/download?family=Open%20Sans > $FONT_DIR/Open_Sans.zip
curl -SL https://fonts.google.com/download?family=Roboto > $FONT_DIR/Roboto.zip
curl -SL https://fonts.google.com/download?family=Source%20Code%20Pro > $FONT_DIR/Source_Code_Pro.zip

cd "${FONT_DIR}"
for i in $(ls | grep '.zip'); do 7za x -y $i; done
for i in $(find . -type f -name '*ttf' | grep -i regular); do cp $i $HOME/.fonts/ ; done
cd -

# restore KDE env
#TBD

# System tune
sudo mkdir -p /etc/NetworkManager/conf.d/
if ! [ -f '/etc/NetworkManager/conf.d/default-wifi-powersave-on.conf' ]; then
    cat << EOF | sudo tee /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
[connection]
wifi.powersave = 2
EOF
fi

cat << EOF | sudo tee /etc/systemd/system/powertop.service
[Unit]
Description=PowerTOP auto tune

[Service]
Type=oneshot
Environment="TERM=dumb"
RemainAfterExit=true
ExecStart=/usr/sbin/powertop --auto-tune

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable --now powertop.service

if [ "$USE_ZSH" -eq "0" ]; then
    echo "All configuration applied, changing shell is missing..."
    echo "Changing the shell to zsh"
    chsh -s /bin/zsh
fi
