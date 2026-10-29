// Cambiar a "http" cuando el servidor Zig sirva el contrato /api/v1.
export const API_MODE = "mock";
const BASE = "/api/v1";

const demoSchemas = ["TABLEAU", "LABORATORIO"];
const demoTables = {
  TABLEAU: ["ANALISISLABORATORIO", "RESULTADOS_DEMO"],
  LABORATORIO: ["MUESTRAS_DEMO", "CATALOGO_DEMO"],
};
const demoColumns = {
  ANALISISLABORATORIO: [
    { name: "ID", type: "int64", nullable: false, precision: 10, scale: 0 },
    { name: "FECHA_ANALISIS", type: "timestamp", nullable: true },
    { name: "RESULTADO", type: "decimal", nullable: true, precision: 18, scale: 4 },
    { name: "OBSERVACION", type: "utf8", nullable: true },
  ],
};
const demoJobs = new Map();
let sequence = 1;

const delay = (ms = 180) => new Promise((resolve) => setTimeout(resolve, ms));
const apiError = (code, message, retryable = false) => Object.assign(new Error(message), { code, retryable });

async function request(path, options = {}) {
  let response;
  try {
    response = await fetch(`${BASE}${path}`, {
      ...options,
      headers: { "Content-Type": "application/json", ...options.headers },
    });
  } catch {
    throw apiError("unavailable", "No se pudo contactar al backend local.", true);
  }
  const body = await response.json().catch(() => null);
  if (!response.ok) {
    const error = body?.error ?? {};
    throw apiError(error.code ?? "internal", error.message ?? `Error HTTP ${response.status}.`, error.retryable ?? false);
  }
  return body;
}

export async function getSchemas() {
  if (API_MODE === "mock") { await delay(); return { items: demoSchemas.map((name) => ({ name })) }; }
  return request("/schemas");
}

export async function getTables(schema) {
  if (API_MODE === "mock") {
    await delay();
    return { items: (demoTables[schema] ?? []).map((name) => ({ schema, name })) };
  }
  return request(`/schemas/${encodeURIComponent(schema)}/tables`);
}

export async function getTable(schema, table) {
  if (API_MODE === "mock") {
    await delay();
    return { schema, name: table, columns: demoColumns[table] ?? [{ name: "ID", type: "int64", nullable: false }] };
  }
  return request(`/schemas/${encodeURIComponent(schema)}/tables/${encodeURIComponent(table)}`);
}

export async function startExport(payload) {
  if (API_MODE === "mock") {
    await delay(250);
    const id = `exp_demo_${String(sequence++).padStart(4, "0")}`;
    demoJobs.set(id, { id, schema: payload.schema, table: payload.table, state: "queued", rows_processed: 0, rows_per_second: 0, files_completed: 0, bytes_written: 0, elapsed_ms: 0, current_batch: 0, error: null, polls: 0, cancel_requested: false, fail_demo: payload.destination.toLowerCase().includes("demo-error") });
    return { id, state: "queued", status_url: `${BASE}/exports/${id}` };
  }
  return request("/exports", { method: "POST", body: JSON.stringify(payload) });
}

export async function getExport(id) {
  if (API_MODE === "mock") {
    await delay(180);
    const job = demoJobs.get(id);
    if (!job) throw apiError("not_found", "No se encontró la exportación.");
    job.polls += 1;
    job.elapsed_ms += 1500;
    if (job.cancel_requested) {
      job.state = job.polls > 1 ? "cancelled" : "cancelling";
    } else if (job.fail_demo && job.polls >= 3) {
      job.state = "failed";
      job.error = { code: "destination", message: "Error simulado al escribir en el directorio destino.", retryable: false };
    } else if (job.polls === 1) {
      job.state = "connecting";
    } else if (job.polls === 2) {
      job.state = "reading";
    } else if (job.polls < 9) {
      job.state = job.polls % 2 === 0 ? "reading" : "writing";
      job.rows_processed = Math.min(120000, (job.polls - 2) * 20000);
      job.rows_per_second = 14500 + (job.polls % 3) * 1250;
      job.files_completed = Math.floor(job.rows_processed / 40000);
      job.bytes_written = job.files_completed * 18_400_000 + Math.floor((job.rows_processed % 40000) * 450);
      job.current_batch = Math.ceil(job.rows_processed / 10000);
    } else {
      job.state = "completed";
      job.rows_processed = 128450;
      job.rows_per_second = 16280;
      job.files_completed = 4;
      job.bytes_written = 79_486_200;
      job.current_batch = 13;
    }
    return { ...job };
  }
  return request(`/exports/${encodeURIComponent(id)}`);
}

export async function cancelExport(id) {
  if (API_MODE === "mock") {
    await delay();
    const job = demoJobs.get(id);
    if (!job) throw apiError("not_found", "No se encontró la exportación.");
    if (["completed", "cancelled", "failed"].includes(job.state)) throw apiError("conflict", "La exportación ya terminó.");
    job.cancel_requested = true;
    job.state = "cancelling";
    return { ...job };
  }
  return request(`/exports/${encodeURIComponent(id)}`, { method: "DELETE" });
}
