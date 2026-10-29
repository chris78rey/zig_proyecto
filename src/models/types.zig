//! Tipos compartidos entre la fuente, la orquestación y el destino.

pub const Identifier = []const u8;

pub const LogicalType = enum {
    boolean,
    int64,
    float64,
    decimal,
    utf8,
    binary,
    date,
    timestamp,
    timestamp_with_timezone,
};

pub const Column = struct {
    name: []const u8,
    logical_type: LogicalType,
    nullable: bool,
    precision: ?u16 = null,
    scale: ?i16 = null,
    /// Longitud máxima en bytes si el adaptador la conoce.
    byte_length: ?u64 = null,
};

pub const Date = struct {
    year: i32,
    month: u8,
    day: u8,
};

pub const Timestamp = struct {
    year: i32,
    month: u8,
    day: u8,
    hour: u8,
    minute: u8,
    second: u8,
    /// Nanosegundos [0, 999_999_999]. DATE puede usar cero.
    nanosecond: u32 = 0,
};

pub const ZonedTimestamp = struct {
    timestamp: Timestamp,
    /// Desplazamiento local respecto de UTC, en minutos.
    offset_minutes: i16,
};

pub const Value = union(LogicalType) {
    boolean: bool,
    int64: i64,
    float64: f64,
    /// Decimal base 10 en forma textual canónica; no pierde precisión Oracle.
    decimal: []const u8,
    utf8: []const u8,
    binary: []const u8,
    date: Date,
    timestamp: Timestamp,
    timestamp_with_timezone: ZonedTimestamp,
};

/// `null` representa SQL NULL. La etiqueta de cada Value debe coincidir con
/// `Column.logical_type`.
pub const Cell = ?Value;

pub const Row = []const Cell;

pub const TableRef = struct {
    schema: Identifier,
    table: Identifier,
};

pub const ExportId = []const u8;

pub const ExportState = enum {
    queued,
    connecting,
    reading,
    writing,
    cancelling,
    completed,
    cancelled,
    failed,
};

pub const ExportProgress = struct {
    id: ExportId,
    table: TableRef,
    state: ExportState,
    rows_processed: u64,
    rows_per_second: f64,
    files_completed: u64,
    bytes_written: u64,
    elapsed_ms: u64,
    current_batch: u64,
    error_info: ?ErrorInfo = null,
};

pub const ErrorCode = enum {
    cancelled,
    invalid_argument,
    unavailable,
    source,
    destination,
    out_of_memory,
    internal,
};

pub const ErrorInfo = struct {
    code: ErrorCode,
    message: []const u8,
    retryable: bool = false,
};
