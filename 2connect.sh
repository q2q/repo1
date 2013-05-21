#!/bin/bash
echo "start-num:" ; read START
echo "stop-num:" ;  read STOP
HOSTNAME="amzb"
STIME=10
M1NE1ADDR="10.235.59.172"
M1NE2ADDR="54.216.111.57"

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
	GITURL="https://github.com/q2q/repo1.git"
	REPO="repo1"
	ssh -o StrictHostkeyChecking=no ${HOSTNAME}${i} "sudo apt-get update ; sudo apt-get -y install git ; git clone $GITURL ; sh $REPO/initscript.sh"
	}	

Transfer3() {
	REPO="repo1"
	ssh -o StrictHostkeyChecking=no ${HOSTNAME}${i} "sh $REPO/cuda-prep.sh"
	}	

Mine1 () {
	ssh -o StrictHostkeyChecking=no ${HOSTNAME}$i \
"cd cpuminer; screen -d -m ./minerd -a scrypt-jane --url=${MINE1ADDR}:9323 --userpass=user:pass -t 14"
#"screen -d -m ./gbt2 -a scrypt-jane --url=mineyac2.dontmine.me:8080 --userpass=rogiservice.$SWN:pass"
}
Mine2 () {
	ssh -o StrictHostkeyChecking=no ${HOSTNAME}$i \
"echo -e './cudaminer -l 56x8,56x8 -C 1,1 --url=http://${MINE2ADDR}:8332 --userpass=growl.${SWN}:x &\n sleep $STIME ; pkill sshd' > startcuda.sh ; screen -d -m sh startcuda.sh"
	SWN=$[$SWN+1] ; echo $SWN
}
        
Kill () {
	 ssh -o StrictHostkeyChecking=no ${HOSTNAME}$i \
"pkill $PNAME"
}

Reboot () {
        ssh $HOSTNAME$i "reboot"
}

Secure() {
	ssh -o StrictHostkeyChecking=no $HOSTNAME$i " echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config "
}

for ((i=$START;i!=($STOP+1);i++)) ; do
    $1
    done

