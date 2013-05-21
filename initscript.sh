#!/bin/bash

sudo apt-get install -y build-essential libcurl4-openssl-dev automake 
git clone https://github.com/ali1234/cpuminer.git
cd $HOME/cpuminer
./autogen.sh
./configure CFLAGS=-O3
make
cp minerd ~/minerd 