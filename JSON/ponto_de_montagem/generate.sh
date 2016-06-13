#!/bin/bash

ARRAY=();

ARRAY+=("root.nome=\"/$(pwd | rev | cut -d'/' -f-1 | rev)\"");
ARRAY+=("root.teste.0=null");
COUNT_DIR=0;
for i in $(ls); do
	if echo $i | grep -q '.sh'; then
		continue;
	fi;
	ARRAY+=("root.dirs.$COUNT_DIR.nome=\"$i\"");
	
	COUNT_FILE=0;
	for i in $(ls $i); do
		ARRAY+=("root.dirs.$COUNT_DIR.files.$COUNT_FILE.nome=\"$i\"");
		COUNT_FILE=$[$COUNT_FILE+1];
	done;
	COUNT_DIR=$[$COUNT_DIR+1];
done;

./cgi.sh "${ARRAY[@]}";
