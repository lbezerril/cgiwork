#!/bin/sh

. assert
. cgiwork request

# Testes da função __get_parameters passando argumento.
get_parameters_with_args_test() {
  __assert_equals_string "" "$(__get_parameters id)"
  __assert_equals_exit_status 1 __get_parameters id

  local QUERY_STRING="id=1&product=2+2"

  __assert_equals_string "1" "$(__get_parameters id)"
  __assert_equals_exit_status 0 __get_parameters id
  __assert_equals_string "2 2" "$(__get_parameters product)"
  __assert_equals_exit_status 0 __get_parameters product
  __assert_equals_string "" "$(__get_parameters name)"
  __assert_equals_exit_status 1 __get_parameters name
}

get_parameters_with_args_test

__assert_exit
