#!/bin/sh

# Colore a mensagem com a cor informada.
__message() {
  # $1: Mensagem.
  # $2: Cor.

  [ -z "$2" ] && return

  # Cores disponíveis.
  local NC='\033[0m'
  local BLACK='\033[0;30m'
  local BLUE='\033[0;34m'
  local CYAN='\033[0;36m'
  local DARKGRAY='\033[1;30m'
  local GREEN='\033[0;32m'
  local LIGHTBLUE='\033[1;34m'
  local LIGHTCYAN='\033[1;36m'
  local LIGHTGRAY='\033[0;37m'
  local LIGHTGREEN='\033[1;32m'
  local LIGHTPURPLE='\033[1;35m'
  local LIGHTRED='\033[1;31m'
  local ORANGE='\033[0;33m'
  local PURPLE='\033[0;35m'
  local RED='\033[0;31m'
  local WHITE='\033[1;37m'
  local YELLOW='\033[1;33m'

  # Obtem o código da cor informada.
  local color_code=$(eval "echo \$$2")

  # TODO validar:
  #echo "$color_code --"
  # __message true "a b"

  /bin/echo -e "${color_code}${1}${NC}"
}

# Realiza um teste de string. Caso o valor a ser testado foi o mesmo que o
# esperado, retorna 0. Caso contrário retorna 1.
__assert_equals_string() {
  # $1: Valor esperado.
  # $2: Valor a ser testado.

  [ "$1" = "$2" ]
  local exit_status=$?

  [ $exit_status -eq 0 ] &&
    __message "Success!" GREEN ||
    __message "Fail: string expected: [$1] but was: [$2]" RED

  return $exit_status
}

# Realiza um teste numérico. Caso o valor a ser testado foi o mesmo que o
# esperado, retorna 0. Caso contrário retorna 1. Se os valores informados não
# forem numéricos, retorna 2.
__assert_equals_numeric() {
  # $1: Valor esperado.
  # $2: Valor a ser testado.

  [ $1 -eq $2 ] 2>/dev/null
  local exit_status=$?

  [ $exit_status -eq 0 ] &&
    __message "Success!" GREEN ||
    __message "Fail: numeric expected: [$1] but was: [$2]" RED

  return $exit_status
}

# Executa a função ou comando passado e realiza um teste de exit status. Se o
# exit status foi o mesmo que o esperado, retorna 0. Caso contrário retorna 1.
# Se o exit status esperado informado não for numérico, retorna 2.
__assert_equals_exit_status() {
  # $1: Exit status esperado do retorna da função ou comando a ser testado.
  # $2: Função ou comando a ser testado.

  local expected=$1; shift

  # Executa a função ou comando ignorando stdout e stderr.
  eval $@ >/dev/null 2>&1

  local real=$?
  [ $expected -eq $real ] 2>/dev/null
  local exit_status=$?

  [ $exit_status -eq 0 ] &&
    __message "Success!" GREEN ||
    __message "Fail: exit status expected: [$expected] but was: [$real]" RED

  return $exit_status
}

# TODO
#__assert_not_equals_string() {}
#__assert_not_equals_numeric() {}
#__assert_not_equals_exit_status() {}
