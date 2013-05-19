#!/bin/bash

# $1="http://mineyac2.dontmine.me:8080" $2=rogiservice.17:pass

if [ -z $1 || ] ; then
	echo "variable is empty"
fi

if [ -z $1 || ] ; then
	echo "variable is empty"
fi

cd $PATH/cpuminer
screen -d -m ./minerd -a scrypt-jane --url=$1 --userpass=$2

