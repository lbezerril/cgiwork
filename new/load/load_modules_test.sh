#!/bin/bash

# ./cgiwork request

. ../../assert.sh
. cgiwork request

__assert_equals_exit_status 1 type __start
__assert_equals_exit_status 1 type __load_module

# Testa se as funções do módulo foram carregas
__assert_equals_exit_status 0 type __get_method
__assert_equals_exit_status 0 type __get_uri
__assert_equals_exit_status 0 type __get_protocol
__assert_equals_exit_status 0 type __get_parameters
