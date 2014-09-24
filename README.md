# Installation

## Clone the repo

    git clone git://github.com/kwk/dotvim.git ~/.vim

## Initialize the submodules

You need to bring in the code of the plugins by updating the plugins

    cd ~/.vim
    git submodule init
    git submodule update

## Create symlinks:

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

# About

This is inspired by the post ["Synchronizing plugins with git submodules and
pathogen"][1]. 

[1]: http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/
