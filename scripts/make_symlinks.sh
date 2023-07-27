#!/bin/bash

set -x

basedir=$(dirname $(dirname $(realpath $0)))
files=(
    ".vimrc"
    ".tmux.conf"
    ".zshrc"
    ".gitconfig"
    ".vim/coc-settings.json"
    ".vim/scripts/coc_nvim.vim"
    ".vim/scripts/toggle_terminal.vim"
    ".config/nvim/init.vim"
    ".config/nvim/coc-configs.json"
)


for filename in "${files[@]}"; do
    mkdir -p ~/$(dirname $filename)
    mv ~/$filename ~/$filename.old
    ln -s $basedir/$filename ~/$filename
done

