#!/bin/sh

. assert
. cgiwork request

# Testes da função __get_method.
get_method_test() {
  __assert_equals_string "" "$(__get_method)"
  __assert_equals_exit_status 1 __get_method

  local REQUEST_METHOD=POST

  __assert_equals_string "POST" "$(__get_method)"
  __assert_equals_exit_status 0 __get_method
}

get_method_test
