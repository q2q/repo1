#!/bin/bash

PATH=$(pwd)
apt-get install build-essential libcurl4-openssl-dev automake 
git clone https://github.com/ali1234/cpuminer.git
cd $PATH/cpuminer
./autogen.sh
./configure CFLAGS=-O3
make
