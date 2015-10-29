#!/bin/bash
control_c(){
        tput clear
        rm -f /tmp/tempfile
        echo "Exiting..."
        exit 1
}
trap control_c SIGINT
for ((i=5000; i<=7800; i++)); do
        cat links.txt | while read line; do
                curl "$line?sz=$i" -sS > /dev/null & echo $i;
        done
done
wait
