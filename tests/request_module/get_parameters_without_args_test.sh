#!/bin/sh

. assert
. cgiwork request

# Testes da função __get_parameters sem passar argumento.
get_parameters_without_args_test() {
  # $@: Lista dos pares key=value de parâmetro esperado.

  __assert_equals_string "" "$(__get_parameters)"
  __assert_equals_exit_status 1 __get_parameters

  local QUERY_STRING="id=1&product=2+2"
  __assert_equals_exit_status 0 __get_parameters

  __get_parameters | while read parameter; do
    __assert_equals_string "$1" "$parameter"
    shift
  done;
}

get_parameters_without_args_test "id=1" "product=2 2"
