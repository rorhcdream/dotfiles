set -x
sudo apt install git -y &&
sudo apt install zsh -y &&
sudo apt install curl -y &&
sudo apt install tmux -y &&
yes | sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &&
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting &&
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions &&
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &&

BASEDIR=$(dirname $(realpath $0)) &&
sh $BASEDIR/make_symlinks.sh
