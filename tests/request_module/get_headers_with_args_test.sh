#!/bin/sh

. shelltest

echo request | {
  . cgiwork

  # Testes da função _get_headers passando argumento.
  get_headers_with_args_test() {
    _assert_equals_string "" "$(_get_headers Content-Type)"
    _assert_equals_exit_status 1 _get_headers Content-Type

    export CONTENT_TYPE="application/x-www-form-urlencoded"

    _assert_equals_string "application/x-www-form-urlencoded"\
      "$(_get_headers Content-Type)"
    _assert_equals_exit_status 0 _get_headers Content-Type

    _assert_equals_string "" "$(_get_headers Content-Length)"
    _assert_equals_exit_status 1 _get_headers Content-Length

    export CONTENT_LENGTH=11

    _assert_equals_string "11" "$(_get_headers Content-Length)"
    _assert_equals_exit_status 0 _get_headers Content-Length

    _assert_equals_string "" "$(_get_headers Host)"
    _assert_equals_exit_status 1 _get_headers Host

    export HTTP_HOST=localhost

    _assert_equals_string "localhost" "$(_get_headers Host)"
    _assert_equals_exit_status 0 _get_headers Host

    _assert_equals_string "" "$(_get_headers User-Agent)"
    _assert_equals_exit_status 1 _get_headers User-Agent

    export HTTP_USER_AGENT=curl/7.38.0

    _assert_equals_string "curl/7.38.0" "$(_get_headers user-Agent)"
    _assert_equals_exit_status 0 _get_headers user-Agent

    export HTTP_HTTP_HTTP="\"this is valid\""
    _assert_equals_string "\"this is valid\"" "$(_get_headers Http-Http)"
    _assert_equals_exit_status 0 _get_headers Http-Http

    _assert_equals_exit_status 1 type __print_header

    unset -v CONTENT_TYPE CONTENT_LENGTH HTTP_HOST HTTP_USER_AGENT HTTP_HTTP_HTTP
  }

  get_headers_with_args_test

  _assert_exit

}
