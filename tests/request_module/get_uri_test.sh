#!/bin/sh

. assert
. cgiwork request

# Testes da função __get_uri.
get_uri_test() {
  __assert_equals_string "" "$(__get_uri)"
  __assert_equals_exit_status 1 __get_uri

  local REQUEST_URI=/

  __assert_equals_string "/" "$(__get_uri)"
  __assert_equals_exit_status 0 __get_uri
}

get_uri_test

__assert_status
