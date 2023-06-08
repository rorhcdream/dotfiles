if [ -x "$(command -v apk)" ];       then apk add --no-cache $@
elif [ -x "$(command -v apt-get)" ]; then apt install -y $@
elif [ -x "$(command -v brew)" ];     then brew install $@
else echo "FAILED TO INSTALL PACKAGE: Package manager not found."; fi
