#!/bin/bash
echo "start ="
read START
echo "stop="
read STOP

if [ $1 == "Mine" ]
	then
		echo "offset"
		read MOFF
fi

SCPPATH="~/IDCF/s2.sh"
#FILE=$( echo $SCPPATH | cut -d '/'
MINEPWD='x'
HOSTNAME="at"

Secure() {
	ssh -o StrictHostkeyChecking=no $HOSTNAME$i " echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config "
	}

Transfer() {
        scp -o StrictHostkeyChecking=no ~/IDCF/s2.sh $HOSTNAME$i:/root/
        ssh -o StrictHostkeyChecking=no $HOSTNAME$i "screen -d -m sh s2.sh"
        }

Mine () {
        s=$[$i+$MOFF]
        ssh $HOSTNAME$i "screen -d -m ./gbt2 -a scrypt-jane --url=mineyac2.dontmine.me:8080 --userpass=rogiservice.$s:$MINEPWD"
	#ssh idcf$i "screen -d -m ./gbt --url=us.litecoinpool.org:9332 --userpass=wetroof.$s:4444"
        }

Reboot () {
        ssh $HOSTNAME$i "reboot"
}



for ((i=$START;i!=($STOP+1);i++))
        do
        $1
	
	
        done

