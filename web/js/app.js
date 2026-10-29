import { API_MODE, cancelExport, getExport, getSchemas, getTable, getTables, startExport } from "./api.js";

const byId = (id) => document.getElementById(id);
const form = byId("export-form");
const schemaSelect = byId("schema");
const tableSelect = byId("table");
const startButton = byId("start-button");
const cancelButton = byId("cancel-button");
const formError = byId("form-error");
const jobError = byId("job-error");
const terminalStates = new Set(["completed", "cancelled", "failed"]);
const labels = { queued: "En cola", connecting: "Conectando", reading: "Leyendo", writing: "Escribiendo", cancelling: "Cancelando", completed: "Completada", cancelled: "Cancelada", failed: "Error" };
let activeJobId = null;
let pollTimer = null;
let tableMetadata = null;
let lastProgress = null;
let busy = false;
let catalogGeneration = 0;

byId("mode-label").textContent = API_MODE === "mock" ? "Modo demostración" : "Backend local";
byId("connection-label").textContent = API_MODE === "mock" ? "Catálogo de ejemplo" : "Backend local";
if (API_MODE !== "mock") document.querySelector(".mode-pill").classList.add("connected-mode");

function setOptions(select, items, placeholder, valueOf, labelOf) {
  select.replaceChildren(new Option(placeholder, ""));
  for (const item of items) select.add(new Option(labelOf(item), valueOf(item)));
}

function showFormError(message) {
  formError.textContent = message;
  formError.hidden = !message;
}

function setBusy(value) {
  busy = value;
  schemaSelect.disabled = value;
  tableSelect.disabled = value || !schemaSelect.value;
  startButton.disabled = value || !tableSelect.value;
  startButton.innerHTML = value ? "<span class=\"button-spinner\" aria-hidden=\"true\"></span> Exportando…" : "<span aria-hidden=\"true\">▶</span> Iniciar exportación";
}

async function loadSchemas() {
  schemaSelect.disabled = true;
  try {
    const result = await getSchemas();
    setOptions(schemaSelect, result.items ?? [], "Selecciona un esquema", (item) => item.name, (item) => item.name);
    schemaSelect.disabled = false;
    if (result.items?.length) {
      schemaSelect.value = result.items[0].name;
      await loadTables(schemaSelect.value);
    }
  } catch (error) {
    setOptions(schemaSelect, [], "No se pudo cargar");
    byId("connection-label").textContent = "Error de conexión";
    showFormError(error.message);
  }
}

async function loadTables(schema) {
  const generation = ++catalogGeneration;
  tableMetadata = null;
  tableSelect.disabled = true;
  startButton.disabled = true;
  byId("table-hint").textContent = "Cargando tablas visibles para esta conexión…";
  try {
    const result = await getTables(schema);
    if (generation !== catalogGeneration) return;
    setOptions(tableSelect, result.items ?? [], "Selecciona una tabla", (item) => item.name, (item) => item.name);
    tableSelect.disabled = !schema || busy;
    byId("table-hint").textContent = `${result.items?.length ?? 0} tablas disponibles en ${schema}.`;
    if (result.items?.length) {
      tableSelect.value = result.items[0].name;
      await loadTableMetadata(schema, tableSelect.value, generation);
    }
  } catch (error) {
    setOptions(tableSelect, [], "No se pudo cargar");
    byId("table-hint").textContent = "Error al consultar las tablas.";
    showFormError(error.message);
  }
  startButton.disabled = busy || !tableSelect.value;
}

async function loadTableMetadata(schema, table, generation = ++catalogGeneration) {
  if (!schema || !table) { tableMetadata = null; return; }
  try {
    const metadata = await getTable(schema, table);
    if (generation !== catalogGeneration) return;
    tableMetadata = metadata;
    const columns = tableMetadata.columns?.length ?? 0;
    byId("table-hint").textContent = `${columns} columnas · metadatos listos para exportar.`;
  } catch (error) {
    if (generation !== catalogGeneration) return;
    tableMetadata = null;
    showFormError(error.message);
  }
  startButton.disabled = busy || !tableMetadata;
}

function formatNumber(value) { return new Intl.NumberFormat("es-EC").format(value ?? 0); }
function formatBytes(value) {
  if (!value) return "0 B";
  const units = ["B", "KB", "MB", "GB", "TB"];
  const index = Math.min(Math.floor(Math.log(value) / Math.log(1024)), units.length - 1);
  return `${(value / (1024 ** index)).toFixed(index > 1 ? 1 : 0)} ${units[index]}`;
}
function formatTime(ms) {
  const seconds = Math.max(0, Math.floor((ms ?? 0) / 1000));
  const hours = Math.floor(seconds / 3600);
  const minutes = Math.floor((seconds % 3600) / 60);
  const rest = seconds % 60;
  return hours ? `${String(hours).padStart(2, "0")}:${String(minutes).padStart(2, "0")}:${String(rest).padStart(2, "0")}` : `${String(minutes).padStart(2, "0")}:${String(rest).padStart(2, "0")}`;
}

function showJob(job) {
  lastProgress = job;
  byId("empty-state").hidden = true;
  byId("job-state").hidden = false;
  byId("job-table").textContent = `${job.schema}.${job.table}`;
  byId("job-destination").textContent = form.elements.destination.value;
  byId("metric-rows").textContent = formatNumber(job.rows_processed);
  byId("metric-speed").innerHTML = `${formatNumber(Math.round(job.rows_per_second ?? 0))} <em>filas/s</em>`;
  byId("metric-files").textContent = formatNumber(job.files_completed);
  byId("metric-bytes").textContent = formatBytes(job.bytes_written);
  byId("metric-time").textContent = formatTime(job.elapsed_ms);
  byId("metric-batch").textContent = formatNumber(job.current_batch);

  const progress = job.state === "completed" ? 100 : Math.min(96, Math.floor((job.rows_processed / 128450) * 100));
  byId("progress-bar").style.width = `${progress}%`;
  document.querySelector(".progress-track").setAttribute("aria-valuenow", String(progress));
  byId("progress-percent").textContent = `${progress}%`;
  byId("progress-caption").textContent = job.state === "completed" ? "Todos los archivos se cerraron correctamente" : job.state === "failed" ? "La exportación se detuvo" : labels[job.state] ?? job.state;
  const badge = byId("status-badge");
  badge.className = `status-badge status-${job.state}`;
  byId("status-text").textContent = labels[job.state] ?? job.state;
  cancelButton.hidden = terminalStates.has(job.state) || job.state === "cancelling";
  jobError.hidden = !job.error;
  if (job.error) jobError.textContent = `${job.error.message}${job.error.retryable ? " Puedes volver a intentarlo." : ""}`;
  byId("progress-footnote").textContent = terminalStates.has(job.state) ? "Seguimiento finalizado" : "Polling local cada 1,5 segundos";
}

async function poll() {
  if (!activeJobId) return;
  try {
    const job = await getExport(activeJobId);
    showJob(job);
    if (terminalStates.has(job.state)) {
      clearTimeout(pollTimer);
      activeJobId = null;
      setBusy(false);
      return;
    }
    pollTimer = setTimeout(poll, 1500);
  } catch (error) {
    clearTimeout(pollTimer);
    activeJobId = null;
    setBusy(false);
    showJob({ ...(lastProgress ?? { schema: schemaSelect.value, table: tableSelect.value, rows_processed: 0, rows_per_second: 0, files_completed: 0, bytes_written: 0, elapsed_ms: 0, current_batch: 0 }), state: "failed", error: { message: error.message, retryable: error.retryable } });
  }
}

schemaSelect.addEventListener("change", () => { showFormError(""); tableSelect.value = ""; loadTables(schemaSelect.value); });
tableSelect.addEventListener("change", () => { showFormError(""); loadTableMetadata(schemaSelect.value, tableSelect.value, ++catalogGeneration); });

form.addEventListener("submit", async (event) => {
  event.preventDefault();
  showFormError("");
  const destination = form.elements.destination.value.trim();
  const batchSize = Number(form.elements.batch_size.value);
  if (!schemaSelect.value || !tableSelect.value || !tableMetadata) return showFormError("Selecciona un esquema y una tabla válidos.");
  if (!destination) return showFormError("Indica el directorio destino.");
  if (!Number.isInteger(batchSize) || batchSize < 1 || batchSize > 50000) return showFormError("El tamaño del lote debe estar entre 1 y 50.000 filas.");
  setBusy(true);
  try {
    const created = await startExport({ schema: schemaSelect.value, table: tableSelect.value, destination, batch_size: batchSize });
    activeJobId = created.id;
    showJob({ id: created.id, schema: schemaSelect.value, table: tableSelect.value, state: created.state, rows_processed: 0, rows_per_second: 0, files_completed: 0, bytes_written: 0, elapsed_ms: 0, current_batch: 0, error: null });
    pollTimer = setTimeout(poll, 800);
  } catch (error) {
    setBusy(false);
    showFormError(error.message);
  }
});

cancelButton.addEventListener("click", async () => {
  if (!activeJobId) return;
  cancelButton.disabled = true;
  try {
    const job = await cancelExport(activeJobId);
    showJob(job);
    clearTimeout(pollTimer);
    pollTimer = setTimeout(poll, 300);
  } catch (error) {
    jobError.hidden = false;
    jobError.textContent = error.message;
    cancelButton.disabled = false;
  }
});

loadSchemas();
