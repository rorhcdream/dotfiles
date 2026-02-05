#!/bin/bash
set -ex

basedir=$(dirname $0)
sudo=${SUDO:+sudo}

# install packages
export DEBIAN_FRONTEND=noninteractive
packages=("git" "zsh" "curl" "tmux" "vim" "ripgrep" "wget" "make" "openssh" "gcc" "unzip" "gzip")
if [ -x "$(command -v apk)" ];       then $sudo apk add --no-cache ${packages[@]} zsh-vcs grep
elif [ -x "$(command -v apt-get)" ]; then $sudo apt update && $sudo apt install -y ${packages[@]} language-pack-en
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
    wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    tar -xzvf nvim-linux-x86_64.tar.gz
    (test -e /nvim-linux-x86_64 || $sudo mv nvim-linux-x86_64 /; true)
    $sudo ln -s /nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
fi

# install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# make symbolic links of dotfiles
SUDO=$sudo $basedir/make_symlinks.sh

# install gvm
# sudo apt-get install bison 
# bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

# install go
# gvm install go1.22.3 -B
