#!/usr/bin/env bash

set -e
echo 'Running ruby-rvm script...'

as_vagrant='sudo -u vagrant -H bash -l -c'
home='/home/vagrant'
touch $home/.bash_profile

# do not generate documentation for gems
$as_vagrant 'echo "gem: --no-ri --no-rdoc" >> ~/.gemrc'

sudo sed -i 's/10.0.2.3/4.2.2.2/' /etc/resolv.conf

# install rvm
$as_vagrant 'curl -sSL https://get.rvm.io | bash -s stable'

# source rvm for usage outside of package scripts
rvm_path="$home/.rvm/scripts/rvm"
