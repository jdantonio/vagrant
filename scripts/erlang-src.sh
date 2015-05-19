#!/usr/bin/env bash

#set -e

echo 'Running erlang installation script for ${1}...'

ERL_VERSION=$1
ALT_PRORITY=$2
PREFIX=${3-/usr}

# installs the build dependencies
sudo apt-get -yq update
sudo apt-get -yq install libncurses5-dev unixodbc-dev libssl-dev openjdk-7-jdk libwxgtk2.8-dev libglu1-mesa-dev

OTP_ROOT=/opt/erlang/${ERL_VERSION}

curl -s http://www.erlang.org/download/otp_src_${ERL_VERSION}.tar.gz | tar -xz -f -
cd otp_src_${ERL_VERSION}
./configure --prefix=${OTP_ROOT}
make
sudo make install
cd ..
rm -rf otp_src_${ERL_VERSION}

ERTS_VERSION=$(ls -d ${OTP_ROOT}/lib/erlang/erts-* | sed 's/.*\/erts-\([0-9\.]*\)$/\1/')

sudo mkdir -p ${PREFIX}/lib ${PREFIX}/bin

for mandir in ${OTP_ROOT}/lib/erlang/erts-${ERTS_VERSION}/man/*
do
  sudo mkdir -p ${PREFIX}/man/$(basename ${mandir})
done

# gather binaries
SLAVE_BIN=""
for exe in ${OTP_ROOT}/bin/*
do
  BASE=$(basename ${exe})
  SLAVE_BIN="${SLAVE_BIN} --slave ${PREFIX}/bin/${BASE} ${BASE} ${exe}"
done
for man in $(cd ${OTP_ROOT}/lib/erlang-erts-${ERTS_VERSION}; find man -type f)

do
  BASE=$(basename ${man})
  echo -n " --slave ${PREFIX}/share/${man} ${BASE} ${OTP_ROOT}/lib/erlang/erts-${ERTS_VERSION}/${man}"
done

echo "update-alternatives --install ${PREFIX}/lib/erlang erlang ${OTP_ROOT}/lib/erlang 1703 ${SLAVE_BIN}" | sudo bash
