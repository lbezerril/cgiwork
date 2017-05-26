#!/bin/sh

. shelltest

echo request | {
  . cgiwork

  # Testes da função _get_method.
  get_method_test() {
    _assert_equals_string "" "$(_get_method)"
    _assert_equals_exit_status 1 _get_method

    local REQUEST_METHOD=POST

    _assert_equals_string "POST" "$(_get_method)"
    _assert_equals_exit_status 0 _get_method
  }

  get_method_test

  _assert_exit

}
