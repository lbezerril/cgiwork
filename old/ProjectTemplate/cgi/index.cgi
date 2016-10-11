#!/bin/bash
echo -e "Content-type: text/html\n"

ARRAY=("type=plain;file=../templates/html/index.html;");

cgiwork "${ARRAY[@]}"
