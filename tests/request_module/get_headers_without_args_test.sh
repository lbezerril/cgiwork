#!/bin/sh

. assert
. cgiwork request

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

get_headers_without_args_test \
  "user-agent: curl" \
  "host: localhost" \
  "Content-Length: 0" \
  "Content-Type: application/json"

__assert_exit
