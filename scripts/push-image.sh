set -ex
version=$(cat $(dirname $0)/../version)
docker push rorhcdream/dotfiles:ubuntu-latest
docker push rorhcdream/dotfiles:alpine-latest
docker push rorhcdream/dotfiles:ubuntu-$version
docker push rorhcdream/dotfiles:alpine-$version
