set -x

BASEDIR=$(dirname $(dirname $(realpath $0)))
FILES=(".vimrc" ".tmux.conf" ".zshrc" ".gitconfig")

for FILENAME in "${FILES[@]}"; do
	mv ~/$FILENAME ~/$FILENAME.old
	ln -s $BASEDIR/$FILENAME ~/$FILENAME
done

