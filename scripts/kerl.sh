#!/usr/bin/env bash

echo "Installing Erlang via kerl..."

# installs the build dependencies (debian)
sudo apt-get -yq update
sudo apt-get -yq install libncurses5-dev unixodbc-dev libssl-dev openjdk-7-jdk libwxgtk2.8-dev libglu1-mesa-dev

git clone https://github.com/spawngrid/kerl

cp kerl/kerl ~/bin/
chmod a+x ~/bin/kerl

cp kerl/bash_completion/kerl ~/.bash_completion.d/kerl

for ERLANG in "$@"
do
    kerl build ${ERLANG} ${ERLANG}
    kerl install ${ERLANG} ~/erlang/${ERLANG}
done

if [ $# -ge 1 ]; then
    echo "source ~/erlang/${1}/activate" >> ~/.profile
fi

rm -rf kerl
