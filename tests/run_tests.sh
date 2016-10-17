#!/usr/bin/env sh

# $1: Shell a ser utilizado para executar os testes.

core_path="$(dirname $0)/../core"
tools_path="$(dirname $0)/tools"
export PATH="$PATH:$core_path:$tools_path"

# Verifica se o shell foi passado.
if [ -z "$1" ]; then
  message "You must specify a Shell." YELLOW
  exit 1
fi

# Verifica se o shell passado foi encontrado.
if ! type $1 >/dev/null; then
  message "$1: not found." YELLOW
  exit 1
fi

message "\n#!-----------------------\
 Starting battery of tests!\
 -----------------------!#\n"\
 LIGHTBLUE

exit_status=0

# Para cada script de teste, executa com o shell informado.
for i in $(find -name '*_test.sh'); do

  message "################################### START: \
###################################\n" LIGHTBLUE

  script_file="$i"
  message -n "[$script_file]: " DARKGRAY; message "Starting tests...\n"\
    LIGHTBLUE

  if $1 $i; then
    message -n "\n[$script_file]: " DARKGRAY; message "Success!\n" LIGHTGREEN;
  else
    message -n "\n[$script_file]: " DARKGRAY; message "Fail!\n" LIGHTRED;
    exit_status=$((exit_status+1))
  fi
  message "#################################### \
END! ####################################\n\n\n" LIGHTBLUE
done

#for i in $core_path/cgiwork*; do
#  checkbashisms.pl "$i"
#done

if [ $exit_status -eq 0 ]; then
  message "############################ Finished: SUCCESS :) \
############################\n\n" LIGHTGREEN
else
  message "############################# Finished: FAIL :'( \
#############################\n\n" LIGHTRED
fi

exit $exit_status
