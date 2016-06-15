#!/bin/bash

ARRAY=( "$@" );
FIRST_ITERATION=0; #0=true;1=false

function is_first_iteration() {
	return $FIRST_ITERATION;
}

function fix_null() {
	# $1: index of ARRAY
	if [ "$(echo "${ARRAY[$1]}" | cut -d'=' -f2- | sed 's/ //g')" == "" ]; then
		ARRAY[$1]="$(echo "${ARRAY[$1]}" | cut -d'=' -f-1)=null";
	fi;
}

function get_attributes() {
	# $1: class name
	for i in "${!ARRAY[@]}"; do
		if is_first_iteration; then fix_null $i; fi;
		echo "${ARRAY[$i]}";
	done |

	grep -Eo "^$1[^.]*..|^$1[^.=]*[=].*" |
	#(^$1[.][^.=]*..)
	#(^$1[.]([^.=]*..|[^.=]*=.*)) # Esse aqui

	#grep -Eo "^$1[.][^.]*..|^$1[.][^.=]*[=].*" |
	sed '/=/! { s/\(.*\)\.\([a-Z]\)$/\1.X/;s/\(.*\)\.\([0-9]\)$/\1.0/; }' |
	sort -u;

	FIRST_ITERATION=1;
}

function attribute_is_value() {
	# $1: attribute
	echo "$1" | grep -q "=";
}

function attribute_is_object_array() {
	# $1: attribute
	return 1;
}

function attribute_is_object() {
	# $1: attribute
	return 1;
}

function attribute_is_value_array() {
	# $1: attribute
	return 1;
}

function write_value() {
	#parei aqui: trocar cut,rev,cut por um regex em grep
	echo "\"$(echo "$1" | cut -d'=' -f1 | rev | cut -d'.' -f1 | rev)\": $(echo "$1" | cut -d'=' -f2-),";
	# Remove element from array
}

function generate_class() {
	# $1: class name
	echo "{";
	# For each attribute of class
	echo "$(get_attributes $1)" | while read attribute; do
		if attribute_is_value "$attribute"; then write_value "$attribute"; continue; fi;
		#if attribute_is_value "$i"; then write_value "$i"; continue; fi;
		#if attribute_is_value "$i"; then write_value "$i"; continue; fi;
		#if attribute_is_value "$i"; then write_value "$i"; continue; fi;
	done;
	#echo -n "something,"; echo -e "\b}";
	echo "}";
}

generate_class "applications.git.";
#generate_class
