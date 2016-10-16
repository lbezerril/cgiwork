#!/bin/bash

cgiwork_path="$PWD/../core"
assert_path="$PWD"
export PATH="$PATH:$cgiwork_path:$assert_path"

. assert
. cgiwork request

# Testa se as funções do módulo foram carregas.
__assert_equals_exit_status 0 type __get_method
__assert_equals_exit_status 0 type __get_uri
__assert_equals_exit_status 0 type __get_protocol
__assert_equals_exit_status 0 type __get_parameters

# Testa se as funções internas do módulo não foram carregas.
# TODO: diferente de 0 (dash retorna 127)
__assert_equals_exit_status 1 type __print_header

# Testes da função __get_method.
get_method_test() {
  __assert_equals_string "" "$(__get_method)"
  __assert_equals_exit_status 1 __get_method

  local REQUEST_METHOD=POST

  __assert_equals_string "POST" "$(__get_method)"
  __assert_equals_exit_status 0 __get_method
}

# Testes da função __get_uri.
get_uri_test() {
  __assert_equals_string "" "$(__get_uri)"
  __assert_equals_exit_status 1 __get_uri

  local REQUEST_URI=/

  __assert_equals_string "/" "$(__get_uri)"
  __assert_equals_exit_status 0 __get_uri
}

# Testes da função __get_protocol.
get_protocol_test() {
  __assert_equals_string "" "$(__get_protocol)"
  __assert_equals_exit_status 1 __get_protocol

  local SERVER_PROTOCOL=HTTP/1.1

  __assert_equals_string "HTTP/1.1" "$(__get_protocol)"
  __assert_equals_exit_status 0 __get_protocol
}

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

# Testes da função __get_headers passando argumento.
get_headers_with_args_test() {
  __assert_equals_string "" "$(__get_headers Content-Type)"
  __assert_equals_exit_status 1 __get_headers Content-Type

  export CONTENT_TYPE="application/x-www-form-urlencoded"

  __assert_equals_string "application/x-www-form-urlencoded" "$(__get_headers Content-Type)"
  __assert_equals_exit_status 0 __get_headers Content-Type

  __assert_equals_string "" "$(__get_headers Content-Length)"
  __assert_equals_exit_status 1 __get_headers Content-Length

  export CONTENT_LENGTH=11

  __assert_equals_string "11" "$(__get_headers Content-Length)"
  __assert_equals_exit_status 0 __get_headers Content-Length

  __assert_equals_string "" "$(__get_headers Host)"
  __assert_equals_exit_status 1 __get_headers Host

  export HTTP_HOST=localhost

  __assert_equals_string "localhost" "$(__get_headers Host)"
  __assert_equals_exit_status 0 __get_headers Host

  __assert_equals_string "" "$(__get_headers User-Agent)"
  __assert_equals_exit_status 1 __get_headers User-Agent

  export HTTP_USER_AGENT=curl/7.38.0

  __assert_equals_string "curl/7.38.0" "$(__get_headers user-Agent)"
  __assert_equals_exit_status 0 __get_headers user-Agent

  export HTTP_HTTP_HTTP="\"this is valid\""
  __assert_equals_string "\"this is valid\"" "$(__get_headers Http-Http)"
  __assert_equals_exit_status 0 __get_headers Http-Http

  __assert_equals_exit_status 1 type __print_header

  unset -v CONTENT_TYPE CONTENT_LENGTH HTTP_HOST HTTP_USER_AGENT HTTP_HTTP_HTTP
}

# Testes da função __get_headers sem passar argumento.
get_headers_without_args_test() {
  # $@: Lista dos pares "Key: value" de header esperado.

  __assert_equals_string "" "$(__get_headers)"
  __assert_equals_exit_status 0 __get_headers # TODO Retorna 1?

  export HTTP_USER_AGENT=curl
  export HTTP_HOST=localhost
  export CONTENT_LENGTH=0
  export CONTENT_TYPE="application/json"
  __assert_equals_exit_status 0 __get_headers

  __get_headers | while read header; do
    __assert_equals_string "$1" "$header"
    shift
  done;

  __assert_equals_exit_status 1 type __print_header
  unset -v HTTP_USER_AGENT HTTP_HOST CONTENT_LENGTH CONTENT_TYPE
}

get_method_test
get_uri_test
get_protocol_test
get_parameters_with_args_test
get_parameters_without_args_test "id=1" "product=2 2"
get_headers_with_args_test
get_headers_without_args_test \
  "user-agent: curl" \
  "host: localhost" \
  "Content-Length: 0" \
  "Content-Type: application/json"

#__assert_resume (trabalha com a análise de variáveis internas gravadas)
