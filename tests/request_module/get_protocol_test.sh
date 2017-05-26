#!/bin/sh

. shelltest

echo request | {
  . cgiwork

  # Testes da função _get_protocol.
  get_protocol_test() {
    _assert_equals_string "" "$(_get_protocol)"
    _assert_equals_exit_status 1 _get_protocol

    local SERVER_PROTOCOL=HTTP/1.1

    _assert_equals_string "HTTP/1.1" "$(_get_protocol)"
    _assert_equals_exit_status 0 _get_protocol
  }

  get_protocol_test

  _assert_exit

}
