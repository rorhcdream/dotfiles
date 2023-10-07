#!/bin/bash
set -ex

basedir=$(dirname $0)
sudo=${SUDO:+sudo}

# install packages
export DEBIAN_FRONTEND=noninteractive
packages=("git" "zsh" "curl" "tmux" "vim" "ripgrep" "wget")
if [ -x "$(command -v apk)" ];       then $sudo apk add --no-cache ${packages[@]} zsh-vcs grep
elif [ -x "$(command -v apt-get)" ]; then $sudo apt update && apt install -y ${packages[@]} language-pack-en
elif [ -x "$(command -v brew)" ];     then $sudo brew install ${packages[@]}
else echo "FAILED TO INSTALL PACKAGE: Package manager not found."; fi

# machine configuration
uname_out="$(uname -s)"
case "${uname_out}" in
	Linux*)		machine=Linux;;
	Darwin*)    machine=Mac;;
    *)          machine="UNKNOWN:${uname_out}"
esac
os_id=$(grep -ioP '^ID=\K.+' /etc/os-release)
echo "Machine: $machine"
echo "OS: $os_id"

# install oh-my-zsh and its extensions
echo "Installing oh-my-zsh and its extensions"
yes | sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

# install tmux plugin manager
echo "Installing tmux plugin manager"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# # install vim plugin manager
# echo "Installing vim plugin manager"
# curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim ||
# { echo "Failed"; exit 1; }

# install pyenv
curl https://pyenv.run | bash

# install nvm and node
if [ $os_id = "alpine" ]; then
    $sudo apk add nodejs
else
    touch ~/.bashrc
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    source ~/.bashrc
    nvm install node
fi

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install

# install nvim
echo "Installing nvim"
if [ $machine = "Mac" ]; then
	$sudo brew install neovim
elif [ $os_id = "alpine" ]; then
    $sudo apk add --no-cache neovim
else
    wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
    tar -xzvf nvim-linux64.tar.gz
    (test -e /nvim-linux64 || $sudo mv nvim-linux64 /; true)
    $sudo ln -s /nvim-linux64/bin/nvim /usr/local/bin/nvim
fi

# install nvim plugin manager
echo "Installing nvim plugin manager"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# make symbolic links of dotfiles
SUDO=$sudo $basedir/make_symlinks.sh

# install nvim plugins
echo "Installing nvim plugins"
nvim -e -s -u ~/.vimrc +PlugInstall || true



