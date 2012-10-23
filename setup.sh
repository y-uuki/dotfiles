#!/bin/sh

echo "start setup my dotfiles!"

DOT_FILES=( .zsh .zshrc .zprofile .zshrc.alias .zshrc.linux .zshrc.osx .ctags .emacs.el .gdbinit .gemrc .gitconfig .gitignore .inputrc .irbrc .pryrc .perldb .proverc .sbtconfig .screenrc .vim .vimrc .gvimrc .tmux.conf .dir_colors .rdebugrc)

for file in ${DOT_FILES[@]}
do
    ln -fs $HOME/dotfiles/$file $HOME/$file
done

echo "Install vim plugins by neobundle.vim ..."
vim -c "NeobundleInstall"

echo "done setup"
