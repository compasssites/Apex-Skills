#!/bin/sh

set -eu

if [ "$#" -ne 2 ]; then
  echo "usage: find_page_file.sh <export-root> <page-number>" >&2
  exit 1
fi

root=$1
page_number=$2

if [ ! -d "$root" ]; then
  echo "error: export root not found: $root" >&2
  exit 1
fi

page_digits=$(printf '%s' "$page_number" | tr -cd '0-9')

if [ -z "$page_digits" ]; then
  echo "error: page number must contain digits" >&2
  exit 1
fi

search_dir=$root/application/pages

if [ ! -d "$search_dir" ]; then
  echo "error: pages directory not found under $root/application/pages" >&2
  exit 1
fi

matches=$(
  find "$search_dir" -type f -name 'page_*.sql' | while IFS= read -r file; do
    base=$(basename "$file")
    digits=$(printf '%s' "$base" | sed -E 's/^page_0*([0-9]+)\.sql$/\1/')
    if [ "$digits" = "$page_digits" ]; then
      printf '%s\n' "$file"
    fi
  done
)

if [ -z "$matches" ]; then
  exit 1
fi

printf '%s\n' "$matches"
