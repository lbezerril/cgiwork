#!/bin/sh

. shelltest

echo request | {
  . cgiwork

  # Testes da função _get_uri.
  get_uri_test() {
    _assert_equals_string "" "$(_get_uri)"
    _assert_equals_exit_status 1 _get_uri

    local REQUEST_URI=/

    _assert_equals_string "/" "$(_get_uri)"
    _assert_equals_exit_status 0 _get_uri
  }

  get_uri_test

  _assert_exit

}
