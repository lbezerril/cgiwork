#!/bin/bash

# Modulos a serem carregados:
# . cgiwork         # Carrega todos os modulos
# . cgiwork request
# . cgiwork response
# . cgiwork checking request response body
# ./cgiwork (terá o comportamento normal, só não irá carregar as funções)

. assert
. cgiwork request

# TODO: diferente de 0 (dash retorna 127)
__assert_equals_exit_status 1 type __start
__assert_equals_exit_status 1 type __load_module

# Testa se as funções do módulo foram carregas
__assert_equals_exit_status 0 type __get_method
__assert_equals_exit_status 0 type __get_uri
__assert_equals_exit_status 0 type __get_protocol
__assert_equals_exit_status 0 type __get_parameters
__assert_equals_exit_status 0 type __get_headers
__assert_equals_exit_status 0 type __get_cookies

__assert_exit
