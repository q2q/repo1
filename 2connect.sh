#!/bin/bash
echo "start-num:" ; read START
echo "stop-num:" ;  read STOP
HOSTNAME="amzb"
STIME=1

if [ $1 == "Mine1" ] ; then
	echo "startng-worker-number:" ; read SWN
fi

if [ $1 == "Mine2" ] ; then
	echo "startng-worker-number:" ; read SWN
fi

if [ $1 == "Kill" ] ; then
	echo "process-name:" ; read PNAME
fi

Transfer() {
        scp -o StrictHostkeyChecking=no ~/IDCF/s2.sh $HOSTNAME$i:/root/
        ssh -o StrictHostkeyChecking=no $HOSTNAME$i "screen -d -m sh s2.sh"
        }
        
Tamazon() {
	GITURL="https://github.com/q2q/repo1.git"
	REPO="repo1"
	ssh -o StrictHostkeyChecking=no ${HOSTNAME}${i} "sudo apt-get update ; sudo apt-get -y install git ; git clone $GITURL ; sh $REPO/initscript.sh"
	}	

Mine1 () {
	ssh -o StrictHostkeyChecking=no ${HOSTNAME}$i \
"cd cpuminer; screen -d -m ./minerd -a scrypt-jane --url=168.61.9.67:9323 --userpass=user:pass -t 14"
#"screen -d -m ./gbt2 -a scrypt-jane --url=mineyac2.dontmine.me:8080 --userpass=rogiservice.$SWN:pass"
	SWN=$[$SWN+1] ; echo $SWN
}
Mine2 () {
	ssh -o StrictHostkeyChecking=no ${HOSTNAME}$i \
"echo -e './cudaminer -l 56x4,56x4 --url=litecoinpool.org:9332 --userpass=wetroof.${SWN}:4444 &\npkill sshd' > startcuda.sh ; screen -d -m sh startcuda.sh"
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

