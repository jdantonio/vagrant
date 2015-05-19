#!/usr/bin/env bash

#set -e

echo 'Running Ubuntu erlang script...'

source /etc/lsb-release

if ! grep -q "deb http://packages.erlang-solutions.com/debian" /etc/apt/sources.list /etc/apt/sources.list.d/* ; then
    echo "deb http://packages.erlang-solutions.com/debian/ ${DISTRIB_CODENAME} contrib" >> /etc/apt/sources.list.d/erlang-solutions.list
fi

curl http://packages.erlang-solutions.com/debian/erlang_solutions.asc | apt-key add -

apt-get -qy update
apt-get -qy install erlang --force-yes
apt-get -qy install erlang-nox --force-yes
