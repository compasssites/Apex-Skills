#!/bin/sh

set -eu

if [ "$#" -ne 2 ]; then
  echo "usage: emit_sqlcl_import.sh <export-root> <changed-file>" >&2
  exit 1
fi

root=$1
target=$2

if [ ! -d "$root" ]; then
  echo "error: export root not found: $root" >&2
  exit 1
fi

case $target in
  "$root"/*) rel=${target#"$root"/} ;;
  *) rel=$target ;;
esac

case $rel in
  @*)
    printf '%s\n' "$rel"
    ;;
  application/*)
    printf '@%s\n' "$rel"
    ;;
  */application/*)
    printf '@%s\n' "${rel#*/}"
    ;;
  *)
    echo "error: expected a path inside application/: $target" >&2
    exit 1
    ;;
esac
