set -x

BASEDIR=$(dirname $(dirname $(realpath $0)))
mv ~/.vimrc ~/.vimrc.old
mv ~/.tmux.conf ~/.tmux.conf.old
mv ~/.zshrc ~/.zshrc.old
ln -s $BASEDIR/.vimrc ~/.vimrc
ln -s $BASEDIR/.tmux.conf ~/.tmux.conf
ln -s $BASEDIR/.zshrc ~/.zshrc

