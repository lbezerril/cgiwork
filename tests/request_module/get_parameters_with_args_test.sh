#!/bin/sh

. shelltest

echo request | {
  . cgiwork

  # Testes da função _get_parameters passando argumento.
  get_parameters_with_args_test() {
    _assert_equals_string "" "$(_get_parameters id)"
    _assert_equals_exit_status 1 _get_parameters id

    local QUERY_STRING="id=1&product=2+2"

    _assert_equals_string "1" "$(_get_parameters id)"
    _assert_equals_exit_status 0 _get_parameters id
    _assert_equals_string "2 2" "$(_get_parameters product)"
    _assert_equals_exit_status 0 _get_parameters product
    _assert_equals_string "" "$(_get_parameters name)"
    _assert_equals_exit_status 1 _get_parameters name
  }

  get_parameters_with_args_test

  _assert_exit

}
