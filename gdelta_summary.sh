#!/bin/bash

# Verificamos que haya 2 argumentos (las versiones)
if [ $# -ne 2 ]; then
  echo "Uso: $0 <version_inicial> <version_final>"
  exit 1
fi

v1=$1
v2=$2

printf '%.0s-' {1..130}; echo
echo "| Compare versions $v1 and $v2 "
printf '%.0s-' {1..130}; echo


printf "%-40s | %-30s | %-12s | %s\n" "Path" "File" "Status" "Range line change"
printf '%.0s-' {1..130}; echo

git diff --name-status $v1 $v2 | while IFS=$'\t' read -r estado archivo; do
  [[ -z "$archivo" ]] && continue

  case "$estado" in
    A) tipo="Nuevo" ;;
    M) tipo="Modificado" ;;
    *) tipo="Otro" ;;
  esac

  rango=$(git diff $v1 $v2 -- "$archivo" | awk '
    /^@@/ {
      if (match($0, /\+([0-9]+)(,([0-9]+))?/, a)) {
        start = a[1]
        len = (a[3] == "" ? 1 : a[3])
        end = start + len - 1

        if (min_start == 0 || start < min_start) min_start = start
        if (max_end == 0 || end > max_end) max_end = end
      }
    }
    END {
      if (min_start == 0 && max_end == 0) {
        print "-"
      } else {
        print min_start " a " max_end
      }
    }
  ')

  name=$(basename "$archivo")
  path=$(dirname "$archivo")
  [[ "$path" == "." ]] && path="/" || path="$path/"

  printf "%-40s | %-30s | %-12s | %s\n" "$path" "$name" "$tipo" "$rango"
done
