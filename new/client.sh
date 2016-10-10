#!/bin/bash



. cgiwork
# Modulos a serem carregados:
# . cgiwork         # Carrega todos os modulos
# . cgiwork request
# . cgiwork response
# . cgiwork checking request response body
# ./cgiwork (terá o comportamento normal, só não irá carregar as funções)


# TODO: Rever nome da função
# A função define alguns headers padrão, exemplo status
__check_expected_method "POST"



__get_method
__get_parameters
__get_parameters "id"
__get_uri
__get_protocol
__get_headers "Host"
__get_headers
# TODO: __get_body - Como pegar arquivo de upload ?
# TODO: __get_remote_info - Obter informações de rede da requisição



# __set sem argumento
__set_protocol "HTT/1.1"
__set_status 200
__set_status 200 "OK"
__set_header "Content-type" "text/html"
__set_headers $ARRAY # Será necessário ?
# Commita headers (echo "\n") - Define headers default
__flush_buffer



# TODO: Definir nome desta função
ARRAY+=("visitor_number=$RANDOM");
__tag_page "template.html" $ARRAY
cat template.html | __tag_page $ARRAY


# Json e XML
__marshal_json $ARRAY # Retorna formato json
cat template.json | __unmarshal_json # Retorna objeto array



# TODO: echos não serão echoados até chamar esta função, permitindo assim setar
# o status code depois de montar o body (REST)
__flush_body
