My vim config files
===================

Warning: This pulls a lot of submodules.

To use:

    git clone git://github.com/srijan/vim-config.git ~/.vim
    cd ~/.vim
    git submodule init
    git submodule update

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

For temp files:

    mkdir -p ~/tmp/.vim/{backup,swap,undo}
