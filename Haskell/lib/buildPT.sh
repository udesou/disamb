#!/bin/bash

if [[ "$@" == "-o" ]]
then
    sdf2table -i ../src-gen/syntax/Haskell-front.def -o old-sdf2tabletemp.aterm -t -m Haskell-front
	pp-aterm -i old-sdf2tabletemp.aterm -o old-sdf2table.txt 
	rm old-sdf2tabletemp.aterm
fi

if [[ "$@" == "-n" || "$#" -eq 0 ]]
then
    pp-aterm -i ../target/metaborg/sdf-new.tbl -o new-sdf2table.txt 
fi

if [[ "$@" == "-no" || "$@" == "-on" ]]
then
   pp-aterm -i ../target/metaborg/sdf-new.tbl -o new-sdf2table.txt 
    
   sdf2table -i ../src-gen/syntax/Haskell-front.def -o old-sdf2tabletemp.aterm -t -m Haskell-front
   pp-aterm -i old-sdf2tabletemp.aterm -o old-sdf2table.txt 
   rm old-sdf2tabletemp.aterm

fi
