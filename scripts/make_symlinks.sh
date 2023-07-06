#!/bin/bash

set -x

basedir=$(dirname $(dirname $(realpath $0)))
files=(".vimrc" ".tmux.conf" ".zshrc" ".gitconfig" ".vim/coc-settings.json")

for filename in "${files[@]}"; do
	mv ~/$filename ~/$filename.old
	ln -s $basedir/$filename ~/$filename
done

