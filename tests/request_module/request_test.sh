#!/bin/sh

. shelltest

echo request | {
  . cgiwork

  # Testa se as funções do módulo foram carregas.
  _assert_equals_exit_status 0 type _get_method
  _assert_equals_exit_status 0 type _get_uri
  _assert_equals_exit_status 0 type _get_protocol
  _assert_equals_exit_status 0 type _get_parameters

  # Testa se as funções internas do módulo não foram carregas.
  # TODO: diferente de 0 (dash retorna 127)
  _assert_equals_exit_status 1 type __print_header

  _assert_exit

}
