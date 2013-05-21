#!/bin/bash
echo "start-num:" ; read START
echo "stop-num:" ;  read STOP
HOSTNAME="amzb"
STIME=10
A="10.235.59.172"  # amazon-windows-local
B="54.216.111.57"  # amazon-windows [stratum proxy atm]

#YAC-MINING-VARS
C="168.61.9.67"    # azure-west-windows
PROG="./gbt2"
THREADS=8
DIR=$HOME

REPO="repo1"
GITURL="https://github.com/q2q/repo1.git"


if [ $1 == "Mine1" ] ; then
	echo "startng-worker-number:" ; read SWN
fi

if [ $1 == "Mine2" ] ; then
	echo "startng-worker-number:" ; read SWN
fi

if [ $1 == "Kill" ] ; then
	echo "process-name:" ; read PNAME
fi


Transfer1() {
        scp -o StrictHostkeyChecking=no ~/IDCF/s2.sh $HOSTNAME$i:/root/
        ssh -o StrictHostkeyChecking=no $HOSTNAME$i "screen -d -m sh s2.sh"
        }
        
Transfer2() {
	ssh -o StrictHostkeyChecking=no ${HOSTNAME}${i} "sudo apt-get update ; sudo apt-get -y install git ; git clone $GITURL ; sh $REPO/initscript.sh"
	}	

Transfer3() {
	ssh -o StrictHostkeyChecking=no ${HOSTNAME}${i} "sh $REPO/cuda-prep.sh"
	}	

Load () {
	ssh -o StrictHostkeyChecking=no ${HOSTNAME}$i "sudo sh $REPO/driver.sh"

Mine1 () {
	ssh -o StrictHostkeyChecking=no ${HOSTNAME}$i \
"screen -d -m $PROG -a scrypt-jane --url=$C:9323 --userpass=user:pass -t $THREADS"
}
Mine2 () {
	ssh -o StrictHostkeyChecking=no ${HOSTNAME}$i "screen -dm sh $REPO/startcuda.sh $B $SWN"
	SWN=$[$SWN+1] ; echo $SWN
}
        
Kill () {
	 ssh -o StrictHostkeyChecking=no ${HOSTNAME}$i \
"pkill $PNAME"
}

Reboot () {
        ssh $HOSTNAME$i "reboot"
}

Status () {
	if [ $PA == a ] ; then ; echo "first-prog-name:" ; read PA ; fi 
	if [ $PB == a ] ; then ; echo "second-prog-name:" ; read PA ; fi
	ssh -o StrictHostkeyChecking=no ${HOSTNAME}$i "ps -e | grep -e '$PA||$PB"
	

Secure() {
	ssh -o StrictHostkeyChecking=no $HOSTNAME$i " echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config "
}

for ((i=$START;i!=($STOP+1);i++)) ; do
    $1
    done

