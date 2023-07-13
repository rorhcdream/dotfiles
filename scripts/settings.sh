#!/bin/bash

basedir=$(dirname $0)

# machine configuration
uname_out="$(uname -s)"
case "${uname_out}" in
	Linux*)		machine=Linux;;
	Darwin*)    	machine=Mac;;
    	*)          	machine="UNKNOWN:${uname_out}"
esac
echo "Machine: $machine"

# install packages
packages=("git" "zsh" "curl" "tmux" "vim" "ripgrep")
if [ -x "$(command -v apk)" ];       then apk add --no-cache ${packages[@]} zsh-vcs
elif [ -x "$(command -v apt-get)" ]; then apt update && apt install -y ${packages[@]} language-pack-en
elif [ -x "$(command -v brew)" ];     then brew install ${packages[@]}
else echo "FAILED TO INSTALL PACKAGE: Package manager not found."; fi

# install oh-my-zsh and its extensions
echo "Installing oh-my-zsh and its extensions"
yes | sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &&
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting &&
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ||
{ echo "Failed"; exit 1; }

# install tmux plugin manager
echo "Installing tmux plugin manager"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm ||
{ echo "Failed"; exit 1; }

# install vim plugin manager
echo "Installing vim plugin manager"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim ||
{ echo "Failed"; exit 1; }

# instal pyenv
curl https://pyenv.run | bash

# install nvim
echo "Installing nvim"
if [ $machine = "Mac" ]; then
	brew install neovim ||
	{ echo "Failed"; exit 1; }
else 
	wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage && 
	chmod +x nvim.appimage && 
	sudo mv nvim.appimage /usr/local/bin/nvim ||
	{ echo "Failed"; exit 1; }
fi

# install nvim plugin manager
echo "Installing nvim plugin manager"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' ||
{ echo "Failed"; exit 1; }

# make symbolic links of dotfiles
$basedir/make_symlinks.sh

# install vim plugins
echo "Installing vim plugins"
vim +PlugInstall +qall ||
{ echo "Failed"; exit 1; }



