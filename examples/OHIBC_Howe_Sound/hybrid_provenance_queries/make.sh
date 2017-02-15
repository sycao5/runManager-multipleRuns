#!/usr/bin/env bash

cd ./examples

for DIR in $(find . -mindepth 1 -maxdepth 1 -type d)
do
	cur_dir=$(pwd)
	#echo "$DIR"
	cd "$DIR"
	#echo $(pwd)
	bash ./clean.sh
	bash ./make.sh 
	cd $cur_dir
done

cd ..