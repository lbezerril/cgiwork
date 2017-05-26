#!/bin/sh

. shelltest

echo request | {
  . cgiwork

  # Testes da função _get_parameters sem passar argumento.
  get_parameters_without_args_test() {
    # $@: Lista dos pares key=value de parâmetro esperado.

    _assert_equals_string "" "$(_get_parameters)"
    _assert_equals_exit_status 1 _get_parameters

    local QUERY_STRING="id=1&product=2+2"
    _assert_equals_exit_status 0 _get_parameters

    _get_parameters | while read parameter; do
      _assert_equals_string "$1" "$parameter"
      shift
    done;
  }

  get_parameters_without_args_test "id=1" "product=2 2"

  _assert_exit

}
