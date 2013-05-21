#!/bin/bash
echo "start-num:" ; read START
echo "stop-num:" ;  read STOP
HOSTNAME="amzb"
STIME=10
A="10.235.59.172"
B="54.216.111.57"

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
"cd cpuminer; screen -d -m ./minerd -a scrypt-jane --url=$A:9323 --userpass=user:pass -t 14"
#"screen -d -m ./gbt2 -a scrypt-jane --url=mineyac2.dontmine.me:8080 --userpass=rogiservice.$SWN:pass"
}
Mine2 () {
	ssh -o StrictHostkeyChecking=no ${HOSTNAME}$i \
echo "./cudaminer -l 56x8,56x8 -C 1,1 --url=http://${B}:8332 --userpass=growl.${SWN}:x" > a.txt
	ssh -o StrictHostkeyChecking=no ${HOSTNAME}$i \
"cat export.txt a.txt > startcuda.sh" 
	ssh -o StrictHostkeyChecking=no ${HOSTNAME}$i "screen -dm sh startcuda.sh"
	
"screen -dm export PATH=/usr/local/cuda-5.0/bin:$PATH ;
export LD_LIBRARY_PATH=/usr/local/cuda-5.0/lib64:/usr/local/cuda-5.0/lib ;
./cudaminer -l 56x8,56x8 -C 1,1 --url=http://${MINE2ADDR}:8332 --userpass=growl.${SWN}:x 
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

