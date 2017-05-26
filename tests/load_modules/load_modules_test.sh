#!/bin/bash

# Modulos a serem carregados:
# . cgiwork         # Carrega todos os modulos
# . cgiwork request
# . cgiwork response
# . cgiwork checking request response body
# ./cgiwork (terá o comportamento normal, só não irá carregar as funções)

. shelltest

echo request | {
  . cgiwork

  # TODO: diferente de 0 (dash retorna 127)
  _assert_equals_exit_status 1 type __start
  _assert_equals_exit_status 1 type __should_the_module_be_loaded
  # TODO: __MODULES

  # Testa se as funções do módulo foram carregas
  _assert_equals_exit_status 0 type _get_method
  _assert_equals_exit_status 0 type _get_uri
  _assert_equals_exit_status 0 type _get_protocol
  _assert_equals_exit_status 0 type _get_parameters
  _assert_equals_exit_status 0 type _get_headers
  _assert_equals_exit_status 0 type _get_cookies

  _assert_exit

}
