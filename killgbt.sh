#!/bin/bash
PS='minerd'
declare -i FIELD=1
PID=$( ps -e | grep $PS | cut -d ' ' -f$FIELD )

if [ -z $PID ] ; then  
	echo "PID could not be mapped to variable. exiting..."
	exit
fi

if [ $PID != [:number:]* ] ; then
	echo "PID is strange string. exiting..."	
	exit
fi

echo $PID