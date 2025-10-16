#!/bin/bash

set -x

basedir=$(dirname $(dirname $(realpath $0)))
files=(
    ".tmux.conf"
    ".zshrc"
    ".gitconfig"
    ".config/gh/config.yaml"
    ".config/nvim"
    ".config/lazygit"
    ".golangci.yml"
)

for filename in "${files[@]}"; do
    mkdir -p ~/$(dirname $filename)
    mv ~/$filename ~/$filename.old
    ln -s $basedir/$filename ~/$filename
done

