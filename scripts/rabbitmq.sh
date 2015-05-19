#!/usr/bin/env bash

#set -e

echo 'Running Ubuntu rabbitmq script...'

sudo -s -u vagrant

if ! grep -q "deb http://www.rabbitmq.com/debian/ testing main" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list
fi

curl -s http://www.rabbitmq.com/rabbitmq-signing-key-public.asc | apt-key add -
apt-get -qy update
apt-get -qy install rabbitmq-server

rabbitmq-plugins enable rabbitmq_management

service rabbitmq-server stop

cp /vagrant/templates/rabbitmq.config /etc/rabbitmq/

chown rabbitmq /etc/rabbitmq/rabbitmq.config 
chmod 0400 /etc/rabbitmq/rabbitmq.config 

echo "LKJSHFDUIAHWAELJKDHSFKJDHAHKJLGFSDSKJ" > /etc/rabbitmq/.erlang.cookie
chmod 0400 /etc/rabbitmq/.erlang.cookie

echo "manual" > /etc/init/rabbitmq-server.override
