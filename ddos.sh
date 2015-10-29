#!/bin/bash
cat links.txt | while read line; do
        for ((i=1000; i<=7700; i++)); do
                curl -sS "$line?sz=$i" > /dev/null;
                echo "size: $i"
        done
done
