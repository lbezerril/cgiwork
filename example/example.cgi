#!/bin/bash
echo -e "Content-type: text/html\n"

export CGIVAR_visitor_number="$RANDOM";
export CGIVAR_date="$(date +'%D %T')";

CGIVAR_option_list="<option>Select...</option>";
for i in $(ls output/*.txt); do
	filename="$(echo $i | cut -d '/' -f2-)";
	CGIVAR_option_list+="<option value='$i'>$filename</option>";
done;

export CGIVAR_option_list;

cgiwork "example.html"
