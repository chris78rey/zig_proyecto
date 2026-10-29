#!/usr/bin/env python3
"""Servidor local para probar Oracle → Parquet desde el navegador."""
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
import json
import mimetypes
import os
import re
import secrets
import shutil
import subprocess
import tempfile
import threading
import time
import uuid
from urllib.parse import unquote, urlsplit

import oracledb

ROOT = Path(__file__).resolve().parents[1]
WEB = ROOT / "web"
PROBE = ROOT / "scripts" / "oracle-read-probe.sh"
HOST, PORT = "127.0.0.1", 8765
MAX_OUTPUT = 8192
DOWNLOAD_TTL = 15 * 60
IDENTIFIER = re.compile(r"^[A-Za-z][A-Za-z0-9_$#]{0,29}$")
EXPORT_RE = re.compile(
    r"Exportación real correcta: ([A-Z0-9_$#]+)\.([A-Z0-9_$#]+), filas=(\d+), "
    r"archivo=([^,]+), bytes=(\d+), limite=([^,]+), tiempo_ejecucion=([\d.]+) ms\."
)
VERIFY_RE = re.compile(r"Verificación PyArrow correcta: filas=(\d+), columnas=(\d+), formato=Parquet\.")


def load_local_env():
    env_file = ROOT / ".env"
    if not env_file.is_file():
        return
    for line in env_file.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, value = line.split("=", 1)
        key = key.removeprefix("export ").strip()
        value = value.strip()
        if len(value) >= 2 and value[0] == value[-1] and value[0] in "\"'":
            value = value[1:-1]
        os.environ.setdefault(key, value)


load_local_env()
oracledb.init_oracle_client(lib_dir=os.environ.get("ORACLE_CLIENT_LIB_DIR", "/usr/lib/oracle/19.10/client64/lib"))
downloads = {}
downloads_lock = threading.Lock()
full_jobs = {}
full_jobs_lock = threading.Lock()
full_export_running = False


def oracle_connection():
    user = os.environ.get("ORACLE_USER", "")
    password = os.environ.get("ORACLE_PASSWORD", "")
    if not user or not password:
        raise RuntimeError("missing Oracle credentials")
    dsn = oracledb.makedsn("[ORACLE_HOST]", 1521, sid="prdsgh2")
    return oracledb.connect(user=user, password=password, dsn=dsn)


def valid_identifier(value):
    return bool(IDENTIFIER.fullmatch(value))


def estimate_table(schema, table):
    with oracle_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute(
                "SELECT num_rows, avg_row_len, last_analyzed FROM all_tables "
                "WHERE owner = :owner AND table_name = :table_name",
                owner=schema, table_name=table,
            )
            row = cursor.fetchone()
    if row is None or row[0] is None or row[1] is None:
        raise ValueError("No hay estadísticas de tamaño para esa tabla.")
    estimated_rows, avg_row_len, last_analyzed = row
    estimated_bytes = int(estimated_rows * avg_row_len)
    return {
        "estimated_rows": int(estimated_rows),
        "average_row_bytes": int(avg_row_len),
        "estimated_raw_bytes": estimated_bytes,
        "last_analyzed": last_analyzed.isoformat() if last_analyzed else None,
        "free_bytes": shutil.disk_usage(ROOT).free,
    }


def run_full_export(job_id, schema, table, output_dir, estimate):
    global full_export_running
    started = time.monotonic()
    env = {
        **os.environ,
        "ORACLE_SCHEMA": schema,
        "ORACLE_TABLE": table,
        "ORACLE_MAX_ROWS": "all",
        "ORACLE_FETCH_ARRAY_SIZE": "1000",
        "EXPORT_PROGRESS": "1",
        "PARQUET_OUTPUT_DIR": str(output_dir),
    }
    with full_jobs_lock:
        full_jobs[job_id]["state"] = "connecting"
        full_jobs[job_id]["started_at"] = started
    try:
        process = subprocess.Popen(
            ["bash", str(PROBE)], cwd=ROOT, env=env,
            stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
            text=True, bufsize=1,
        )
        with full_jobs_lock:
            full_jobs[job_id]["process"] = process
            full_jobs[job_id]["state"] = "reading"
        output_tail = ""
        for line in process.stdout:
            output_tail = (output_tail + line)[-MAX_OUTPUT:]
            progress = re.search(r"EXPORT_PROGRESS rows=(\d+) batch=(\d+) state=([a-z_]+)", line)
            if progress:
                with full_jobs_lock:
                    job = full_jobs[job_id]
                    job["rows_processed"] = int(progress.group(1))
                    job["current_batch"] = int(progress.group(2))
                    job["state"] = progress.group(3)
                    job["elapsed_ms"] = round((time.monotonic() - started) * 1000)
        return_code = process.wait()
        exported = EXPORT_RE.search(output_tail)
        verified = VERIFY_RE.search(output_tail)
        parquet_file = output_dir / "part-00001.parquet"
        if return_code != 0 or not exported or not verified or not parquet_file.is_file():
            shutil.rmtree(output_dir, ignore_errors=True)
            with full_jobs_lock:
                full_jobs[job_id].update({"state": "failed", "error": "Falló la exportación o la verificación Parquet."})
            return
        with full_jobs_lock:
            full_jobs[job_id].update({
                "state": "completed",
                "rows_processed": int(exported.group(3)),
                "columns": int(verified.group(2)),
                "bytes_written": int(exported.group(5)),
                "elapsed_ms": round(float(exported.group(7))),
                "output_file": str(parquet_file.relative_to(ROOT)),
                "download_url": f"/api/v1/full-exports/{job_id}/download",
                "statistics": estimate,
            })
    except Exception:
        shutil.rmtree(output_dir, ignore_errors=True)
        with full_jobs_lock:
            full_jobs[job_id].update({"state": "failed", "error": "No se pudo completar la exportación."})
    finally:
        with full_jobs_lock:
            full_export_running = False


def cleanup_expired_downloads():
    now = time.time()
    with downloads_lock:
        expired = [token for token, record in downloads.items() if record["expires_at"] <= now]
        for token in expired:
            shutil.rmtree(downloads.pop(token)["directory"], ignore_errors=True)
        active_directories = {record["directory"] for record in downloads.values()}
    temp_root = Path(tempfile.gettempdir())
    for directory in temp_root.glob("zig-proyecto-parquet-download-*"):
        try:
            if directory not in active_directories and now - directory.stat().st_mtime >= DOWNLOAD_TTL:
                shutil.rmtree(directory, ignore_errors=True)
        except FileNotFoundError:
            pass


class Handler(BaseHTTPRequestHandler):
    server_version = "OracleParquetProbe/1.0"

    def log_message(self, _format, *_args):
        # Evita guardar rutas/errores de los trabajos en logs innecesarios.
        return

    def send_json(self, status, value):
        payload = json.dumps(value, ensure_ascii=False).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(payload)))
        self.send_header("Cache-Control", "no-store")
        self.send_header("X-Content-Type-Options", "nosniff")
        self.end_headers()
        self.wfile.write(payload)

    def valid_local_request(self):
        host = self.headers.get("Host", "")
        if host not in (f"{HOST}:{PORT}", f"localhost:{PORT}"):
            return False
        origin = self.headers.get("Origin")
        return not origin or origin in (f"http://{HOST}:{PORT}", f"http://localhost:{PORT}")

    def do_GET(self):
        cleanup_expired_downloads()
        if not self.valid_local_request():
            self.send_error(403)
            return
        path = unquote(urlsplit(self.path).path)
        match = re.fullmatch(r"/api/v1/downloads/([A-Za-z0-9_-]{40,50})", path)
        if match:
            self.download_parquet(match.group(1))
            return
        match = re.fullmatch(r"/api/v1/full-exports/([0-9a-f]{32})(/download)?", path)
        if match:
            if match.group(2):
                self.download_full_export(match.group(1))
            else:
                self.full_export_status(match.group(1))
            return
        if path == "/api/v1/schemas":
            self.catalog_schemas()
            return
        match = re.fullmatch(r"/api/v1/schemas/([^/]+)/tables(?:/([^/]+))?", path)
        if match:
            schema, table = match.groups()
            if not valid_identifier(schema) or (table is not None and not valid_identifier(table)):
                self.send_json(400, {"error": "Identificador Oracle no válido."})
            elif table is None:
                self.catalog_tables(schema)
            else:
                self.catalog_columns(schema, table)
            return
        if path == "/probe":
            path = "/probe.html"
        if path == "/":
            path = "/index.html"
        candidate = (WEB / path.lstrip("/")).resolve()
        if WEB.resolve() not in candidate.parents or not candidate.is_file():
            self.send_error(404)
            return
        guessed_type = mimetypes.guess_type(candidate.name)[0] or "application/octet-stream"
        content_type = f"{guessed_type}; charset=utf-8" if guessed_type.startswith(("text/", "application/javascript")) else guessed_type
        payload = candidate.read_bytes()
        self.send_response(200)
        self.send_header("Content-Type", content_type)
        self.send_header("Content-Length", str(len(payload)))
        self.send_header("X-Content-Type-Options", "nosniff")
        self.end_headers()
        self.wfile.write(payload)

    def download_parquet(self, token):
        cleanup_expired_downloads()
        with downloads_lock:
            record = downloads.pop(token, None)
        if record is None or not record["file"].is_file():
            self.send_json(404, {"error": "La descarga ya expiró o fue utilizada."})
            return
        try:
            self.send_response(200)
            self.send_header("Content-Type", "application/vnd.apache.parquet")
            self.send_header("Content-Length", str(record["file"].stat().st_size))
            self.send_header("Content-Disposition", f'attachment; filename="{record["filename"]}"')
            self.send_header("Cache-Control", "no-store")
            self.send_header("X-Content-Type-Options", "nosniff")
            self.end_headers()
            with record["file"].open("rb") as parquet_file:
                shutil.copyfileobj(parquet_file, self.wfile, length=1024 * 1024)
        except (BrokenPipeError, ConnectionResetError):
            pass
        finally:
            shutil.rmtree(record["directory"], ignore_errors=True)

    def full_export_status(self, job_id):
        with full_jobs_lock:
            job = full_jobs.get(job_id)
            if job is None:
                self.send_json(404, {"error": "No se encontró la exportación."})
                return
            response = {key: value for key, value in job.items() if key not in ("process", "started_at", "statistics")}
            response["estimated_rows"] = job["statistics"]["estimated_rows"]
        self.send_json(200, response)

    def download_full_export(self, job_id):
        with full_jobs_lock:
            job = full_jobs.get(job_id)
            if job is None or job.get("state") != "completed":
                self.send_json(404, {"error": "El archivo no está listo para descargar."})
                return
            file_path = (ROOT / job["output_file"]).resolve()
            filename = f"{job['schema']}_{job['table']}.parquet"
        if ROOT not in file_path.parents or not file_path.is_file():
            self.send_json(404, {"error": "No se encontró el archivo Parquet."})
            return
        try:
            self.send_response(200)
            self.send_header("Content-Type", "application/vnd.apache.parquet")
            self.send_header("Content-Length", str(file_path.stat().st_size))
            self.send_header("Content-Disposition", f'attachment; filename="{filename}"')
            self.send_header("Cache-Control", "no-store")
            self.send_header("X-Content-Type-Options", "nosniff")
            self.end_headers()
            with file_path.open("rb") as parquet_file:
                shutil.copyfileobj(parquet_file, self.wfile, length=1024 * 1024)
        except (BrokenPipeError, ConnectionResetError):
            pass

    def start_full_export(self, schema, table):
        global full_export_running
        try:
            estimate = estimate_table(schema, table)
        except ValueError as exc:
            self.send_json(422, {"error": str(exc)})
            return
        except Exception:
            self.send_json(503, {"error": "No se pudieron consultar estadísticas Oracle para estimar el tamaño."})
            return

        required_bytes = int(estimate["estimated_raw_bytes"] * 1.5 + 512 * 1024 * 1024)
        if required_bytes > estimate["free_bytes"]:
            self.send_json(507, {
                "error": "El espacio libre no ofrece margen suficiente para una exportación completa.",
                **estimate,
                "required_bytes": required_bytes,
            })
            return

        with full_jobs_lock:
            if full_export_running:
                self.send_json(409, {"error": "Ya hay una exportación completa en curso."})
                return
            job_id = uuid.uuid4().hex
            output_dir = ROOT / "output" / "exports" / f"{schema}_{table}_{job_id[:8]}"
            try:
                output_dir.mkdir(parents=True, exist_ok=False)
            except OSError:
                self.send_json(507, {"error": "No se pudo crear el directorio de exportación."})
                return
            full_export_running = True
            full_jobs[job_id] = {
                "id": job_id, "schema": schema, "table": table,
                "state": "queued", "rows_processed": 0, "current_batch": 0,
                "bytes_written": 0, "elapsed_ms": 0,
                "output_directory": str(output_dir.relative_to(ROOT)),
                "statistics": estimate,
            }
        worker = threading.Thread(
            target=run_full_export,
            args=(job_id, schema, table, output_dir, estimate),
            daemon=True,
        )
        worker.start()
        self.send_json(202, {
            "id": job_id,
            "state": "queued",
            "estimated_rows": estimate["estimated_rows"],
            "estimated_raw_bytes": estimate["estimated_raw_bytes"],
            "free_bytes": estimate["free_bytes"],
            "required_bytes": required_bytes,
            "output_directory": str(output_dir.relative_to(ROOT)),
            "statistics_last_analyzed": estimate["last_analyzed"],
        })

    def catalog_schemas(self):
        try:
            with oracle_connection() as connection:
                with connection.cursor() as cursor:
                    cursor.execute("SELECT DISTINCT owner FROM all_tables ORDER BY owner")
                    items = [{"name": row[0]} for row in cursor]
            self.send_json(200, {"items": items})
        except Exception:
            self.send_json(503, {"error": "No se pudo consultar el catálogo Oracle local."})

    def catalog_tables(self, schema):
        try:
            with oracle_connection() as connection:
                with connection.cursor() as cursor:
                    cursor.execute("SELECT table_name FROM all_tables WHERE owner = :owner ORDER BY table_name", owner=schema)
                    items = [{"schema": schema, "name": row[0]} for row in cursor]
            self.send_json(200, {"items": items})
        except Exception:
            self.send_json(503, {"error": "No se pudieron consultar las tablas visibles de ese esquema."})

    def catalog_columns(self, schema, table):
        try:
            with oracle_connection() as connection:
                with connection.cursor() as cursor:
                    cursor.execute(
                        "SELECT column_name, data_type, nullable, data_precision, data_scale, data_length "
                        "FROM all_tab_columns WHERE owner = :owner AND table_name = :table_name ORDER BY column_id",
                        owner=schema, table_name=table,
                    )
                    items = [{
                        "name": row[0], "type": row[1], "nullable": row[2] == "Y",
                        "precision": row[3], "scale": row[4], "byte_length": row[5],
                    } for row in cursor]
            if not items:
                self.send_json(404, {"error": "La tabla no está visible para esta conexión."})
                return
            self.send_json(200, {"schema": schema, "name": table, "columns": items})
        except Exception:
            self.send_json(503, {"error": "No se pudieron consultar los metadatos de la tabla."})

    def do_POST(self):
        cleanup_expired_downloads()
        if not self.valid_local_request():
            self.send_json(403, {"error": "Solicitud local no válida."})
            return
        route = urlsplit(self.path).path
        if route not in ("/api/v1/connection-test", "/api/v1/full-exports"):
            self.send_json(404, {"error": "Ruta no encontrada."})
            return
        try:
            length = int(self.headers.get("Content-Length", "0"))
            if length > 4096:
                self.send_json(413, {"error": "Solicitud demasiado grande."})
                return
            payload = json.loads(self.rfile.read(length)) if length else {}
        except (ValueError, json.JSONDecodeError):
            self.send_json(400, {"error": "Solicitud JSON no válida."})
            return
        schema = payload.get("schema", "TABLEAU")
        table = payload.get("table", "ANALISISLABORATORIO")
        if not isinstance(schema, str) or not isinstance(table, str) or not valid_identifier(schema) or not valid_identifier(table):
            self.send_json(400, {"error": "Selecciona un esquema y una tabla válidos."})
            return
        if route == "/api/v1/full-exports":
            self.start_full_export(schema, table)
            return
        started = time.monotonic()
        cleanup_expired_downloads()
        output_dir = Path(tempfile.mkdtemp(prefix="zig-proyecto-parquet-download-"))
        try:
            result = subprocess.run(
                ["bash", str(PROBE)], cwd=ROOT, capture_output=True, text=True,
                timeout=120, check=False,
                env={**os.environ, "ORACLE_SCHEMA": schema, "ORACLE_TABLE": table,
                     "PARQUET_OUTPUT_DIR": str(output_dir)},
            )
        except subprocess.TimeoutExpired:
            shutil.rmtree(output_dir, ignore_errors=True)
            self.send_json(504, {"error": "La prueba excedió el tiempo permitido."})
            return
        output = (result.stdout + result.stderr)[-MAX_OUTPUT:]
        exported = EXPORT_RE.search(output)
        verified = VERIFY_RE.search(output)
        if result.returncode != 0 or not exported or not verified:
            shutil.rmtree(output_dir, ignore_errors=True)
            self.send_json(502, {"error": "Falló la conexión o la validación Oracle/Parquet. Revisa .env y los requisitos locales."})
            return
        if exported.group(1) != schema or exported.group(2) != table:
            shutil.rmtree(output_dir, ignore_errors=True)
            self.send_json(502, {"error": "El resultado no coincide con la tabla seleccionada."})
            return
        parquet_path = output_dir / "part-00001.parquet"
        if not parquet_path.is_file():
            shutil.rmtree(output_dir, ignore_errors=True)
            self.send_json(502, {"error": "No se encontró el Parquet generado."})
            return
        token = secrets.token_urlsafe(32)
        with downloads_lock:
            downloads[token] = {
                "directory": output_dir,
                "file": parquet_path,
                "filename": f"{schema}_{table}_muestra.parquet",
                "expires_at": time.time() + DOWNLOAD_TTL,
            }
        self.send_json(200, {
            "state": "completed",
            "schema": exported.group(1),
            "table": exported.group(2),
            "rows": int(exported.group(3)),
            "columns": int(verified.group(2)),
            "bytes": int(exported.group(5)),
            "elapsed_ms": round(float(exported.group(7)), 3),
            "verification": "PyArrow abrió el Parquet correctamente",
            "download_url": f"/api/v1/downloads/{token}",
            "download_expires_in_seconds": DOWNLOAD_TTL,
            "temporary_output_removed": False,
            "wall_ms": round((time.monotonic() - started) * 1000, 1),
        })


if __name__ == "__main__":
    cleanup_expired_downloads()
    print(f"Prueba web Oracle → Parquet: http://{HOST}:{PORT}/probe", flush=True)
    ThreadingHTTPServer((HOST, PORT), Handler).serve_forever()
