echo "enter common name for field Host" ; read HOST
echo "enter value for start of numbering" ; read SVAL
echo "howmany=?" ; read STOP
#echo "start=?" ; read START
#echo "stop=?" ; read STOP
echo "input file name" ; read IF1
echo "output file name (default is home/tempconfig)" ; read OF1

if [ -z $OF1 ] ; then 
	OF1="${HOME}/tempconfig"
fi

KEY="~/.ssh/firstkey.pem"
USER="ubutu"


declare -i START=1
for ((i=$START;i!=($STOP+1);i++)) ; do
	HOSTNAME=$(cat $IF1 | head -$i | tail -1)
	echo \
"Host ${HOST}${SVAL}
Hostname $HOSTNAME
IdentityFile $KEY
User $USER
" >> $OF1
	SVAL=$[$SVAL+1]
	done


	