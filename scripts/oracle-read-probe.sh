#!/usr/bin/env bash
set -euo pipefail

project_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$project_root"

if [[ ! -f .env ]]; then
  printf 'No existe .env en %s\n' "$project_root" >&2
  exit 1
fi

provided_oracle_user="${ORACLE_USER-}"
provided_oracle_password="${ORACLE_PASSWORD-}"
had_oracle_user="${ORACLE_USER+x}"
had_oracle_password="${ORACLE_PASSWORD+x}"
set -a
# shellcheck disable=SC1091
. ./.env
set +a
if [[ -n "$had_oracle_user" ]]; then export ORACLE_USER="$provided_oracle_user"; fi
if [[ -n "$had_oracle_password" ]]; then export ORACLE_PASSWORD="$provided_oracle_password"; fi

export PYARROW_DIR="${PYARROW_DIR:-$(python3 -c 'import pathlib, pyarrow; print(pathlib.Path(pyarrow.__file__).parent)')}"
export PYARROW_ARROW_LIB="${PYARROW_ARROW_LIB:-$(python3 -c 'import glob, os, pyarrow; print(glob.glob(os.path.dirname(pyarrow.__file__)+"/libarrow.so.*")[0])')}"
export PYARROW_PARQUET_LIB="${PYARROW_PARQUET_LIB:-$(python3 -c 'import glob, os, pyarrow; print(glob.glob(os.path.dirname(pyarrow.__file__)+"/libparquet.so.*")[0])')}"
export STDCXX_LIB="${STDCXX_LIB:-$(g++ -print-file-name=libstdc++.so.6)}"
export GCC_S_LIB="${GCC_S_LIB:-$(g++ -print-file-name=libgcc_s.so.1)}"
if [[ -z "${PARQUET_OUTPUT_DIR:-}" ]]; then
  export PARQUET_OUTPUT_DIR="$(mktemp -d /tmp/zig-proyecto-parquet-probe.XXXXXX)"
  cleanup() { rm -rf -- "$PARQUET_OUTPUT_DIR"; }
  trap cleanup EXIT
else
  mkdir -p -- "$PARQUET_OUTPUT_DIR"
fi

zig build
zig build run
python3 - "$PARQUET_OUTPUT_DIR/part-00001.parquet" <<'PY'
import sys
import pyarrow.parquet as pq

file = pq.ParquetFile(sys.argv[1])
print(f"Verificación PyArrow correcta: filas={file.metadata.num_rows}, columnas={file.metadata.num_columns}, formato=Parquet. Valores omitidos.")
PY
