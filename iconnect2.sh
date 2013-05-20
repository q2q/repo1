#!/bin/bash 

GITURL="https://github.com/q2q/repo1.git"
REP="repo1"
HOSTNAME="amz"

echo "start-num:" ; read START
echo "stop-num:" ; read STOP


	
Build () {	
		ssh -o StrictHostkeyChecking=no ${HOSTNAME}$i \ 
"sudo apt-get update; sudo apt-get -y install git; git clone $GITURL; sudo sh $REP/initscript.sh"
}