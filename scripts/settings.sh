# machine configuration
uname_out="$(uname -s)"
case "${uname_out}" in
	Linux*)		machine=Linux;;
	Darwin*)    	machine=Mac;;
	CYGWIN*)    	machine=Cygwin;;
 	MINGW*)     	machine=MinGw;;
    	*)          	machine="UNKNOWN:${uname_out}"
esac
case $machine in
	Linux)
		pkg_manager="apt"
		yflag="-y"
		sudo="sudo"
		;;
	Mac)
		pkg_manager="brew"
		yflag=""
		sudo=""
		;;
	*)
		echo "$machine is not supported"
		exit 1
esac
echo "Machine: $machine"

# install packages
packages=("git" "zsh" "curl" "tmux")
[[ $machine == "Mac" ]] && packages+=("coreutils")	# for 'realpath' command
echo "Installing packages: ${packages[@]}"
$sudo $pkg_manager install ${packages[@]} $yflag || 
{ echo "Failed"; exit 1; }

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

# make symbolic links of dotfiles
BASEDIR=$(dirname $(realpath $0)) &&
sh $BASEDIR/make_symlinks.sh

