#!/bin/bash
echo "start ="
read START
echo "stop="
read STOP

if [ $1 == "Mine" ]
	then
		echo "startng-working-number:"
		read SWN
fi

SCPPATH="~/IDCF/s2.sh"
#FILE=$( echo $SCPPATH | cut -d '/'
MINEPWD='pass'
HOSTNAME="amz"

Secure() {
	ssh -o StrictHostkeyChecking=no $HOSTNAME$i " echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config "
	}

Transfer() {
        scp -o StrictHostkeyChecking=no ~/IDCF/s2.sh $HOSTNAME$i:/root/
        ssh -o StrictHostkeyChecking=no $HOSTNAME$i "screen -d -m sh s2.sh"
        }
        
Tamazon() {
	GITURL="https://github.com/q2q/repo1.git"
	REPO="repo1"
	ssh -o StrictHostkeyChecking=no ${HOSTNAME}${i} "sudo apt-get update ; sudo apt-get -y install git ; git clone $GITURL ; sh $REPO/initscript.sh"
	}	

Mine () {
	REPO="repo1"
    ssh -o StrictHostkeyChecking=no ${HOSTNAME}$i \
"cd cpuminer; screen -d -m ./minerd -a scrypt-jane --url=http://mineyac2.dontmine.me:8080 --userpass=rogiservice.${SWN}:pass"
#"cd cpuminer; screen -d -m ./minerd -a scrypt-jane --url=168.61.9.67:9323 --userpass=user:pass"     
    #ssh $HOSTNAME$i "screen -d -m ./gbt2 -a scrypt-jane --url=mineyac2.dontmine.me:8080 --userpass=rogiservice.$s:$MINEPWD"
	#ssh idcf$i "screen -d -m ./gbt --url=us.litecoinpool.org:9332 --userpass=wetroof.$s:4444"
	SWN=$[$SWN+1]
	echo $SWN
        }

Kill () {
	 ssh -o StrictHostkeyChecking=no ${HOSTNAME}$i \
"pkill minerd"
	}

Reboot () {
        ssh $HOSTNAME$i "reboot"
}

for ((i=$START;i!=($STOP+1);i++))
        do
        $1
	
	
        done

