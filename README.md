# my-python-vim
My vim settings  for programming in python

This settings are using:
* https://github.com/VundleVim/Vundle.vim
* https://github.com/scrooloose/nerdtree
* https://github.com/bling/vim-airline
* https://github.com/Valloric/YouCompleteMe
* https://github.com/scrooloose/syntastic
* https://github.com/nathanaelkane/vim-indent-guides
* https://github.com/altercation/vim-colors-solarized
* https://github.com/sjl/badwolf


Good work and thank you!


How to install:



    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    
    apt-get update && apt-get install -y git ctags cmake python-dev gcc g++  | yum install -y git gcc-c++ cmake



    git clone https://github.com/dduuch/my-python-vim.git && cd my-python-vim && mv .vimrc ~/ && mv colors  ~/.vim/


    vim +PluginInstall +qall

If you want, to enable semantic support for C-family languages in YouCompleteMe, make this:

    cd ~/.vim/bundle/YouCompleteMe
    ./install.sh --clang-completer

If you have some errors, please install packages above.
If you have problem to compile YCM on compute with 512MB RAM, you can use script in my repo.Script was taken from http://www.nyayapati.com/srao/2014/05/youcompleteme-install-fails-due-to-internal-compiler-error/


Its still pre alpha config.
For my own use.

