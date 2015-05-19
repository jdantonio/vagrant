#!/usr/bin/env bash

#set -e

echo 'Running erlang rebar installation script'

git clone https://github.com/rebar/rebar
cd rebar
./bootstrap
cp rebar ../bin/
cd ..
rm -rf rebar
