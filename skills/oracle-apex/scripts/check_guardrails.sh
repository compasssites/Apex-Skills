#!/bin/sh

set -eu

if [ "$#" -lt 1 ]; then
  echo "usage: check_guardrails.sh <path> [path...]" >&2
  exit 1
fi

status=0

for path in "$@"; do
  case $path in
    application/pages/page_*.sql|*"/application/pages/"page_*.sql)
      printf 'OK page export %s\n' "$path"
      ;;
    *"/application/shared_components/"*|application/shared_components/*)
      printf 'OK shared component %s\n' "$path"
      ;;
    */f[0-9]*.sql|f[0-9]*.sql|*/create_application.sql|create_application.sql)
      printf 'BLOCK main app ddl %s\n' "$path"
      status=1
      ;;
    *)
      printf 'WARN review target %s\n' "$path"
      ;;
  esac
done

exit "$status"
