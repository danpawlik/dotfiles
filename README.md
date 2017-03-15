# my-python-vim
My vim settings  for programming in python

This settings are using:
* https://github.com/VundleVim/Vundle.vim
* https://github.com/scrooloose/nerdtree
* https://github.com/bling/vim-airline
* https://github.com/Shougo/neocomplcache.vim
* https://github.com/davidhalter/jedi-vim
* https://github.com/scrooloose/syntastic
* https://github.com/nathanaelkane/vim-indent-guides
* https://github.com/altercation/vim-colors-solarized
* https://github.com/sjl/badwolf
* Others!


Good work and thank you!


How to install:



    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

    git clone https://github.com/dduuch/my-python-vim.git && cd my-python-vim && mv .vimrc ~/ && mv colors  ~/.vim/

    # Adding new vim colors
    mkdir -p ~/.vim
    mkdir -p ~/.vim/colors
    wget https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim -O ~/.vim/colors/solarized.vim
    wget https://raw.githubusercontent.com/sjl/badwolf/master/colors/badwolf.vim -O ~/.vim/colors/badwolf.vim
    wget https://raw.githubusercontent.com/sjl/badwolf/master/colors/goodwolf.vim -O ~/.vim/colors/goodwolf.vim
    wget https://raw.githubusercontent.com/encody/nvim/master/colors/molokai.vim -O ~/.vim/colors/molokai.vim
    wget https://raw.githubusercontent.com/encody/nvim/master/colors/mustang.vim -O ~/.vim/colors/mustang.vim
    wget https://raw.githubusercontent.com/vim-scripts/The-Vim-Gardener/master/colors/gardener.vim  -O ~/.vim/colors/gardener.vim
    wget https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim -O ~/.vim/colors/jellybeans.vim
    wget https://raw.githubusercontent.com/Reewr/vim-monokai-phoenix/master/colors/monokai-phoenix.vim -O ~/.vim/colors/monokai-phoenix.vim
    wget https://raw.githubusercontent.com/ayu-theme/ayu-vim/master/colors/ayu.vim -O ~/.vim/colors/ayu.vim

Its still pre alpha config. YouCompleteMe config is better done. You can find it in another branch.
For my own use.

