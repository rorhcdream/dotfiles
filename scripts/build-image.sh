set -ex
version=$(cat $(dirname $0)/../version)
docker build -t rorhcdream/dotfiles:ubuntu-latest -f Dockerfile-ubuntu  $(dirname $0)/..
docker build -t rorhcdream/dotfiles:alpine-latest -f Dockerfile-alpine  $(dirname $0)/..
docker tag rorhcdream/dotfiles:ubuntu-latest rorhcdream/dotfiles:ubuntu-$version
docker tag rorhcdream/dotfiles:alpine-latest rorhcdream/dotfiles:alpine-$version
