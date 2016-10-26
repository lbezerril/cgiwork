#!/bin/sh

. shelltest
. cgiwork request

# Testes da função __get_protocol.
get_protocol_test() {
  __assert_equals_string "" "$(__get_protocol)"
  __assert_equals_exit_status 1 __get_protocol

  local SERVER_PROTOCOL=HTTP/1.1

  __assert_equals_string "HTTP/1.1" "$(__get_protocol)"
  __assert_equals_exit_status 0 __get_protocol
}

get_protocol_test

__assert_exit
