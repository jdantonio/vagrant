#!/usr/bin/env bash

set -e

echo 'Running Ubuntu common script...'

sudo apt-get -qy update
sudo apt-get -qy upgrade
sudo apt-get -qy purge --auto-remove puppet
sudo apt-get -qy purge --auto-remove chef 

sudo apt-get -y install build-essential \
	tree \
	ack-grep \
	git \
	unzip \
	htop \
	ntp \
	vim \
	bash-completion 

mkdir ~/bin

echo '[[ -f ~/.personal/bash_aliases ]] && source ~/.personal/bash_aliases' >> .bash_aliases

mkdir -p ~/.bash_completion.d
cat >> ~/.bash_completion << EOF
#
# Source all the files in the ~/.bash_completion.d folder
#
for completion in ~/.bash_completion.d/*
do
	source "\${completion}"
done
EOF
