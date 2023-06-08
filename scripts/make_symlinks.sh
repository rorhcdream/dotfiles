#!/bin/bash

set -x

basedir=$(dirname $(dirname $(realpath $0)))
files=(".vimrc" ".tmux.conf" ".zshrc" ".gitconfig")

for filename in "${files[@]}"; do
	mv ~/$filename ~/$filename.old
	ln -s $basedir/$filename ~/$filename
done

