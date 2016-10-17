#!/bin/sh

. assert
. cgiwork request

# Testes da função __get_headers passando argumento.
get_headers_with_args_test() {
  __assert_equals_string "" "$(__get_headers Content-Type)"
  __assert_equals_exit_status 1 __get_headers Content-Type

  export CONTENT_TYPE="application/x-www-form-urlencoded"

  __assert_equals_string "application/x-www-form-urlencoded"\
    "$(__get_headers Content-Type)"
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

get_headers_with_args_test
