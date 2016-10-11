#!/bin/bash

ARRAY=( "$@" );
FIRST_ITERATION=0; #0=true;1=false

function is_first_iteration() {
	return $FIRST_ITERATION;
}

function prepare_array() {
	# $1: index of ARRAY
	# Add dot:
	ARRAY[$1]=".${ARRAY[$1]}";
	# Fix null:
	if [ "$(echo "${ARRAY[$1]}" | cut -d'=' -f2- | sed 's/ //g')" == "" ]; then
		ARRAY[$1]="$(echo "${ARRAY[$1]}" | cut -d'=' -f-1)=null";
	fi;
}

function get_attributes() {
	# $1: class name
	for i in "${!ARRAY[@]}"; do
		if is_first_iteration; then prepare_array $i; fi;
		echo "$i|${ARRAY[$i]}";
	done |
	grep -Eo "(^([0-9]*)\|$1[.][^.=]*(..|=.*))" |
	sed '/=/! { s/[a-Z]$/X/g;s/[0-9]$/0/g; }' |
	sort -u -t'|' -k2;

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
	echo "$1" | grep -q "X$";
}

function attribute_is_value_array() {
	# $1: attribute
	return 1;
}

function write_value() {
	# $1: attribute
	local index="$(echo "$1" | cut -d'|' -f1)";
	local key="$(echo "$1" | cut -d'=' -f1 | grep -Eo '[^.]*$')";
	local value="$(echo "$1" | cut -d'=' -f2-)";
	echo "\"$key\": $value,";
	unset ARRAY[$index]; # Remove element from array
}

function get_class_by_attribute() {
	# $1: attribute
	echo "$1" | grep -o '[.].*[.]' | sed 's/.$//g';
}

function print_opening_bracket() {
	# $1: class annotation
	if [[ "$1" == "" ]]; then
		echo "{";
	else
		local class_name="$(echo "$1" | grep -Eo '[^.]*$')";
		echo "\"$class_name\": {";
	fi;
}

function generate_class() {
	# $1: class annotation
	print_opening_bracket "$1";
	# For each attribute of class
	echo "$(get_attributes $1)" | while read attribute; do
		if attribute_is_value "$attribute"; then write_value "$attribute"; continue; fi;
		#if attribute_is_object_array "$attribute"; then write_value "$attribute"; continue; fi;
		if attribute_is_object "$attribute"; then generate_class $(get_class_by_attribute "$attribute"); continue; fi;
		#if attribute_is_value_array "$attribute"; then write_value "$attribute"; continue; fi;
	done;
	#echo -n "something,"; echo -e "\b}";
	echo "}";
}

generate_class
