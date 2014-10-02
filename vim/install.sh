#!/bin/sh
#
# Vim
#
# This installs Vundle (if it is not already installed) and 
# installs all of the vim plugins listed in your vimrc
#
# Note: .vim and .vimrc should already be symlinked
#       when this runs


VIM_BUNDLE="$HOME/.vim/bundle"
VUNDLE="$VIM_BUNDLE/Vundle.vim"

if [ ! -d "$VUNDLE" ]; then
	rm -rf "$VIM_BUNDLE/"
	git clone https://github.com/gmarik/vundle.git "$VUNDLE"
	echo "Installing Vundle and Vim plugins"
fi

vim +PluginInstall +qall

exit 0