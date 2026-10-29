#!/usr/bin/env bash
set -euo pipefail
project_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
pyarrow_dir="${1:?falta la ruta de PyArrow}"
mkdir -p "$project_root/zig-out/lib"
g++ -std=c++20 -fPIC \
  -I"$project_root/src/parquet" \
  -I"$pyarrow_dir/include" \
  -c "$project_root/src/parquet/arrow_shim.cpp" \
  -o "$project_root/zig-out/lib/arrow_shim.o"
