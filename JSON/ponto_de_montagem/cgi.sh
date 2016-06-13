#!/bin/bash

ARRAY=( "$@" );
first_iteration=true;

function get_attributes() {
	for i in "${!ARRAY[@]}"; do
		if [ ! -z $first_iteration ]; then
			if [ "$(echo "${ARRAY[$i]}" | cut -d'=' -f2- | sed 's/ //g')" == "" ]; then
				ARRAY[$i]="$(echo "${ARRAY[$i]}" | cut -d'=' -f-1)=null";
			fi;
		fi;
		echo "${ARRAY[$i]}";
	done |
	grep -o "^$1[^.]*..\|^$1[^.=]*[=].*" |
	#grep -o "^$1[.][^.]*..\|^$1[.][^.=]*[=].*" |
	sed '/=/! { s/\(.*\)\.\([a-Z]\)$/\1.X/;s/\(.*\)\.\([0-9]\)$/\1.0/; }' |
	sort -u;

	unset first_iteration;
}

function attribute_is_value() {
	echo "$1" | grep -q "=";
}

function attribute_is_object_array() {
	return 1;
}

function attribute_is_object() {
	return 1;
}

function attribute_is_value_array() {
	return 1;
}

function write_value() {
	#parei aqui: trocar cut,rev,cut por um regex em grep
	echo "\"$(echo "$1" | cut -d'=' -f1 | rev | cut -d'.' -f1 | rev)\": $(echo "$1" | cut -d'=' -f2-),";
	# Remove element from array
}
function iterate_attributes() {
	echo "$(get_attributes $1)" | while read line; do
		if attribute_is_value "$line"; then write_value "$line"; continue; fi;
		#if attribute_is_value "$i"; then write_value "$i"; continue; fi;
		#if attribute_is_value "$i"; then write_value "$i"; continue; fi;
		#if attribute_is_value "$i"; then write_value "$i"; continue; fi;
	done;
}

function generate_class() {
	echo "{";
	iterate_attributes "$1";
	#echo -n "something,"; echo -e "\b}";
	echo "}";
}

generate_class "applications.git.";
