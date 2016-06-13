#!/bin/bash
echo -e "Content-type: text/html\n"

# Type of response and output file (Should be the first element of the array):
ARRAY=("type=plain;file=example.html;");

ARRAY+=("visitor_number=$RANDOM");
ARRAY+=("date=$(date +'%D %T')");

option_list="<option>Select...</option>";
for i in $(ls output/*.txt); do
	filename="$(echo $i | cut -d '/' -f2-)";
	option_list+="<option value='$i'>$filename</option>";
done;

ARRAY+=("option_list=$option_list");

cgiwork "${ARRAY[@]}"
