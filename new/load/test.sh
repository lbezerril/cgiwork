#!/bin/bash

#. cgiwork checking request response body
. cgiwork request

REQUEST_METHOD=POST
__get_method || echo falha

REQUEST_URI=/
__get_uri || echo falha

SERVER_PROTOCOL=HTTP/1.1
__get_protocol || echo falha

QUERY_STRING="id=1&product=2+2"
__get_parameters | while read line; do
  echo "> $line";
done;
__get_parameters "product" || echo falha

#__get_headers "Host"
#__get_headers
