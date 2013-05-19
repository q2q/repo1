#!/bin/bash

if [ -z $1 || -z 2$ ] ; then
	echo "variable is empty"
fi

CDIR=$(pwd)
cd $CDIR/cpuminer
./minerd --url=$1 --userpass=$2

