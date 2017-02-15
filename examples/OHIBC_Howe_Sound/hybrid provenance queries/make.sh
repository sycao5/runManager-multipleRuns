#!/usr/bin/env bash

cd ./examples

for DIR in $(find ./ -maxdepth 1 -type d)
do
	echo "$DIR"
	##cd "$DIR"
	bash ./clean.sh && bash ./make.sh 
done

cd ..