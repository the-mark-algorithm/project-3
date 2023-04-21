#!/bin/sh

set -e

test_memory_internal() {
  ./test_memory_setup "$1" "$2" "$3" "$4" "$6"
  valgrind --tool=massif --massif-out-file=massif.out ./test_memory mem.db "$1" "$2" "$3" "$5"
  grep mem_heap_B massif.out | sed -e 's/mem_heap_B=\(.*\)/\1/' | sort -g | tail -n 1
  rm -f massif.out
}

test_memory_internal mem1.db 32 32 16384 10 0
