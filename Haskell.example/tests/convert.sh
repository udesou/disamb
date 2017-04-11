#!/bin/bash

for i in *.hs; do
	
	name=$(echo $i | cut -f 1 -d '.')
	echo "converting $name"
    value=$(<$i)
    echo "module $name

language Haskell-front start symbol Module

test $name [[$value]] parse succeeds" >> "$name.spt"
rm $i
done