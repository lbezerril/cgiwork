#!/usr/bin/env sh

# $1: Shell a ser utilizado para executar os testes.

# Finaliza o script se algum comando falhar.
set -e

# Verifica se o shell foi passado.
if [ -z "$1" ]; then
  echo "You must specify a Shell."
  exit 1
fi

# Verifica se o shell passado foi encontrado.
if ! type $1 >/dev/null; then
  echo "$1: not found."
  exit 1
fi

core_path="$(dirname $0)/../core"
tools_path="$(dirname $0)/tools"
export PATH="$PATH:$core_path:$tools_path"

# Para cada script de teste, executa com o shell informado.
for i in $(find -name '*_test.sh'); do
  script_file="$i"
  echo "[$script_file] Starting tests..."

  if $1 $i; then
    echo "[$script_file] Done!"
  else
    echo "[$script_file] Fail!"
    exit 1
  fi
done

echo "Finished: SUCCESS!"
