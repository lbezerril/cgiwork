#!/bin/sh

. shelltest
. cgiwork request

# Testa se as funções do módulo foram carregas.
__assert_equals_exit_status 0 type __get_method
__assert_equals_exit_status 0 type __get_uri
__assert_equals_exit_status 0 type __get_protocol
__assert_equals_exit_status 0 type __get_parameters

# Testa se as funções internas do módulo não foram carregas.
# TODO: diferente de 0 (dash retorna 127)
__assert_equals_exit_status 1 type __print_header

__assert_exit
