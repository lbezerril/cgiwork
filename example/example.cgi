#!/bin/bash
echo -e "Content-type: text/html\n"

ARRAY=();

ARRAY+=("visitor_number=$RANDOM");
ARRAY+=("date=$(date +'%D %T')");

option_list="<option>Select...</option>";
for i in $(ls output/*.txt); do
	filename="$(echo $i | cut -d '/' -f2-)";
	option_list+="<option value='$i'>$filename</option>";
done;

ARRAY+=("option_list=$option_list");

cgiwork "${ARRAY[@]}" "example.html"

# Verificar possibilidade de executar o cgiwork com "."
# . cgiwork
