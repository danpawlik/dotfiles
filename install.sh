#!/bin/bash


sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf copr enable grumpey/TESTING -y

sudo dnf install -y htop glances vim-enhanced axel mumble \
                    gnupg zsh zstd bzip2 tmux \
                    pinta alacritty keepass fwupd vlc \
                    p7zip unzip ccze wavemon

sudo dnf groupinstall -y development-tools
sudo dnf install -y python3-devel python2-devel python3-pip python2-pip \
                    git qemu libvirt virt-manager podman

sudo yum remove -y nano

sudo yum install -y https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

# brave
sudo dnf install dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install -y brave-browser

# some python libs
pip install pdbpp remote_pdb mypy
pip3 install pdbpp remote_pdb mypy

# dotfiles
mkdir -p ~/.vim/
curl -fLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone https://github.com/danpawlik/dotfiles.git /tmp/dotfiles

# vim
cp /tmp/dotfiles/vimrc/ycm ~/.vimrc

sudo yum install -y automake gcc gcc-c++ kernel-devel cmake python-devel python3-devel
vim +PlugInstall +qall

# android
sudo yum install -y android-tools.x86_64
git clone https://github.com/M0Rf30/android-udev-rules /tmp/android-udev-rules
sudo bash -x /tmp/android-udev-rules/install.sh $(whoami)

# tmux
git clone https://github.com/gpakosz/.tmux.git $HOME/.tmux
ln -s $HOME/.tmux/.tmux.conf $HOME/.tmux.conf
cp -a /tmp/dotfiles/tmux/.tmux* $HOME/

# prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in $(ls $HOME/.zprezto/runcoms/ | grep -vi readme); do
  ln -s "$HOME/.zprezto/runcoms/$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile}"
done
chsh -s /bin/zsh

cp -a /tmp/dotfiles/prezto/.z* $HOME/.zprezto/runcoms/

# alacritty
mkdir -p $HOME/.config
cp -a /tmp/dotfiles/alacritty $HOME/.config/

# starship
curl -SL https://starship.rs/install.sh > /tmp/starship.sh
bash /tmp/starship.sh -y
mkdir -p $HOME/.config
cp -a /tmp/dotfiles/starship/starship.toml $HOME/.config/

# install fonts
FONT_DIR=/tmp/fonts
mkdir -p $FONT_DIR
mkdir -p $HOME/.fonts
curl -SL https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip > $FONT_DIR/Fira_code.zip
curl -SL https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip > $FONT_DIR/Hack.zip
curl -SL https://fonts.google.com/download?family=Work%20Sans > $FONT_DIR/Work_Sans.zip
curl -SL https://fonts.google.com/download?family=Source%20Sans%20Pro > $FONT_DIR/Source_Sans_Pro.zip
curl -SL https://fonts.google.com/download?family=Lato > $FONT_DIR/Lato.zip
curl -SL https://fonts.google.com/download?family=Open%20Sans > $FONT_DIR/Open_Sans.zip
curl -SL https://fonts.google.com/download?family=Roboto > $FONT_DIR/Roboto.zip
curl -LO https://fonts.google.com/download?family=Source%20Code%20Pro > $FONT_DIR/Source_Code_Pro.zip

cd $FONT_DIR
for i in $(ls | grep zip); do 7za x -y $i; done
for i in $(find . -type f -name '*ttf' | grep -i regular); do cp $i $HOME/.fonts/ ; done
cd -

# restore KDE env
#TBD
