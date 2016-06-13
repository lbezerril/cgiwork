#!/bin/bash
# Levar em consideração a versao do bash(4) para o uso do declare
# http://stackoverflow.com/questions/1494178/how-to-define-hash-tables-in-bash

current_date=$(date +'%Y');
declare -A JSON_root=( ["date"]="$current_date" );
#echo "Array root: ${JSON_root["date"]}";

# Erro no sed por conta da barra gerada do pwd
declare -A JSON_file=( ["name"]="$(pwd)" ["size"]=$RANDOM );
#echo "Array file: ${JSON_file["name"]} -- ${JSON_file["size"]}";

# http://stackoverflow.com/questions/9772036/pass-all-variables-from-one-shellscript-to-another
# Tomar muito cuidado com conflito de variaveis entre scripts
#. ./framework.sh






declare -A JSON_ROOT=( ["file_name"]="root.json" ["date"]="$current_date" );
declare -A JSON_FILE=( ["file_name"]="file.json" ["name"]="nomequalquer" ["size"]=$RANDOM );

# Passar por parametro qual o json raiz (root.json)
. ./framework.sh JSON_ROOT JSON_FILE;
