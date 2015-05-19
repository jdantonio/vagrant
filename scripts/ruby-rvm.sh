#!/usr/bin/env bash

set -e
echo 'Running ruby-rvm script...'

# do not generate documentation for gems
echo "gem: --no-ri --no-rdoc" >> ~/.gemrc

# install rvm
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable

source ~/.bash_profile

for ruby_version in "$@"
do
    rvm install "${ruby_version}"
done

# because we manipulate the path in the profile,
# we'll add this final line that will let rvm
# setup the path so it's happy
echo -e '\nrvm use default > /dev/null 2>&1\n' >> ~/.profile
echo -e '\nrvm use default > /dev/null 2>&1\n' >> ~/.bash_profile
