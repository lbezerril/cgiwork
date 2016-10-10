#!/bin/bash

. ../../assert.sh
. cgiwork request



# TODO
#__get_headers "Host"
#__get_headers



# Testa se as funções do módulo foram carregas
__assert_equals_exit_status 0 type __get_method
__assert_equals_exit_status 0 type __get_uri
__assert_equals_exit_status 0 type __get_protocol
__assert_equals_exit_status 0 type __get_parameters

# Testes da função __get_method
get_method_test() {
  __assert_equals_string "" "$(__get_method)"
  __assert_equals_exit_status 1 __get_method

  local REQUEST_METHOD=POST
  __assert_equals_string "POST" "$(__get_method)"
  __assert_equals_exit_status 0 __get_method
}

# Testes da função __get_uri
get_uri_test() {
  __assert_equals_string "" "$(__get_uri)"
  __assert_equals_exit_status 1 __get_uri

  local REQUEST_URI=/
  __assert_equals_string "/" "$(__get_uri)"
  __assert_equals_exit_status 0 __get_uri
}

# Testes da função __get_protocol
get_protocol_test() {
  __assert_equals_string "" "$(__get_protocol)"
  __assert_equals_exit_status 1 __get_protocol

  local SERVER_PROTOCOL=HTTP/1.1
  __assert_equals_string "HTTP/1.1" "$(__get_protocol)"
  __assert_equals_exit_status 0 __get_protocol
}

# Testes da função __get_parameters passando argumento
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

# Testes da função __get_parameters sem passar argumento
get_parameters_without_args_test() {
  __assert_equals_string "" "$(__get_parameters)"
  __assert_equals_exit_status 1 __get_parameters
  local QUERY_STRING="id=1&product=2+2"
  __get_parameters | while read parameter; do
    __assert_equals_string "$1" "$parameter"
    shift
  done;
}

get_method_test
get_uri_test
get_protocol_test
get_parameters_with_args_test
get_parameters_without_args_test "id=1" "product=2 2"
