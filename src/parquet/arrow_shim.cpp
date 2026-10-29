#include "arrow_shim.h"

#include <arrow/api.h>
#include <arrow/io/api.h>
#include <parquet/arrow/writer.h>
#include <parquet/properties.h>

#include <filesystem>
#include <algorithm>
#include <cstring>
#include <memory>
#include <stdexcept>
#include <string>
#include <vector>

namespace fs = std::filesystem;

static void check(const arrow::Status& status) {
  if (!status.ok()) throw std::runtime_error(status.ToString());
}

struct Writer {
  fs::path directory, temporary, final_path;
  std::shared_ptr<arrow::Schema> schema;
  std::shared_ptr<arrow::io::FileOutputStream> sink;
  std::unique_ptr<parquet::arrow::FileWriter> writer;
  std::vector<std::shared_ptr<arrow::ArrayBuilder>> builders;
  uint64_t rows = 0;
  bool closed = false;
};

static void set_error(char* out, uint64_t cap, const std::string& message) {
  if (!out || cap == 0) return;
  const auto n = std::min<uint64_t>(cap - 1, message.size());
  std::memcpy(out, message.data(), n);
  out[n] = 0;
}

static int64_t days_from_civil(int y, unsigned m, unsigned d) {
  y -= m <= 2;
  const int era = (y >= 0 ? y : y - 399) / 400;
  const unsigned yoe = static_cast<unsigned>(y - era * 400);
  const unsigned doy = (153 * (m + (m > 2 ? -3 : 9)) + 2) / 5 + d - 1;
  const unsigned doe = yoe * 365 + yoe / 4 - yoe / 100 + doy;
  return era * 146097 + static_cast<int>(doe) - 719468;
}

static int64_t timestamp_ns(const pq_cell& c, bool zoned) {
  int64_t seconds = days_from_civil(c.year, c.month, c.day) * 86400 + c.hour * 3600 + c.minute * 60 + c.second;
  if (zoned) seconds -= static_cast<int64_t>(c.offset_minutes) * 60;
  return seconds * 1000000000LL + c.nanosecond;
}

extern "C" void* pq_writer_create(const char* dir, uint64_t dir_len,
                                    const pq_column* cols, uint64_t ncols,
                                    uint64_t row_group_rows, char* err, uint64_t cap) {
  try {
    auto w = std::make_unique<Writer>();
    w->directory = std::string(dir, dir_len);
    fs::create_directories(w->directory);
    w->final_path = w->directory / "part-00001.parquet";
    w->temporary = w->directory / "part-00001.parquet.partial";
    if (fs::exists(w->final_path) || fs::exists(w->temporary)) throw std::runtime_error("El archivo de salida ya existe");
    std::vector<std::shared_ptr<arrow::Field>> fields;
    for (uint64_t i = 0; i < ncols; ++i) {
      auto name = std::string(cols[i].name, cols[i].name_len);
      std::shared_ptr<arrow::DataType> type;
      switch (cols[i].type) {
        case 0: type = arrow::boolean(); break;
        case 1: type = arrow::int64(); break;
        case 2: type = arrow::float64(); break;
        case 3: case 4: type = arrow::utf8(); break;
        case 5: type = arrow::binary(); break;
        case 6: type = arrow::date32(); break;
        case 7: case 8: type = arrow::timestamp(arrow::TimeUnit::NANO, "UTC"); break;
        default: throw std::runtime_error("Tipo de columna no soportado");
      }
      fields.push_back(arrow::field(name, type, cols[i].nullable != 0));
    }
    w->schema = arrow::schema(fields);
    auto output_result = arrow::io::FileOutputStream::Open(w->temporary.string());
    if (!output_result.ok()) throw std::runtime_error(output_result.status().ToString());
    w->sink = *output_result;
    parquet::WriterProperties::Builder props;
    props.compression(parquet::Compression::SNAPPY);
    props.max_row_group_length(std::max<uint64_t>(1, row_group_rows));
    auto writer_result = parquet::arrow::FileWriter::Open(*w->schema, arrow::default_memory_pool(), w->sink, props.build());
    if (!writer_result.ok()) throw std::runtime_error(writer_result.status().ToString());
    w->writer = std::move(*writer_result);
    for (const auto& field : fields) {
      auto builder_result = arrow::MakeBuilder(field->type());
      if (!builder_result.ok()) throw std::runtime_error(builder_result.status().ToString());
      w->builders.push_back(std::move(*builder_result));
    }
    return w.release();
  } catch (const std::exception& e) { set_error(err, cap, e.what()); }
  catch (...) { set_error(err, cap, "Falló la inicialización del escritor Parquet"); }
  return nullptr;
}

extern "C" int pq_writer_write(void* ptr, const pq_cell* cells, uint64_t nrows, char* err, uint64_t cap) {
  try {
    auto& w = *static_cast<Writer*>(ptr);
    const auto ncols = w.builders.size();
    for (uint64_t r = 0; r < nrows; ++r) for (uint64_t c = 0; c < ncols; ++c) {
      const auto& v = cells[r * ncols + c];
      auto& b = w.builders[c];
      if (v.is_null) { check(b->AppendNull()); continue; }
      switch (w.schema->field(static_cast<int>(c))->type()->id()) {
        case arrow::Type::BOOL: check(static_cast<arrow::BooleanBuilder*>(b.get())->Append(v.boolean_value != 0)); break;
        case arrow::Type::INT64: check(static_cast<arrow::Int64Builder*>(b.get())->Append(v.integer_value)); break;
        case arrow::Type::DOUBLE: check(static_cast<arrow::DoubleBuilder*>(b.get())->Append(v.float_value)); break;
        case arrow::Type::STRING: check(static_cast<arrow::StringBuilder*>(b.get())->Append(reinterpret_cast<const char*>(v.bytes), v.bytes_len)); break;
        case arrow::Type::BINARY: check(static_cast<arrow::BinaryBuilder*>(b.get())->Append(v.bytes, v.bytes_len)); break;
        case arrow::Type::DATE32: check(static_cast<arrow::Date32Builder*>(b.get())->Append(static_cast<int32_t>(days_from_civil(v.year, v.month, v.day)))); break;
        case arrow::Type::TIMESTAMP: {
          auto value = timestamp_ns(v, v.offset_minutes != INT32_MIN);
          check(static_cast<arrow::TimestampBuilder*>(b.get())->Append(value)); break;
        }
        default: throw std::runtime_error("Tipo Arrow interno no soportado");
      }
    }
    std::vector<std::shared_ptr<arrow::Array>> arrays;
    for (auto& b : w.builders) {
      std::shared_ptr<arrow::Array> array;
      check(b->Finish(&array));
      arrays.push_back(array);
    }
    auto batch = arrow::RecordBatch::Make(w.schema, static_cast<int64_t>(nrows), arrays);
    check(w.writer->WriteRecordBatch(*batch));
    w.rows += nrows;
    return 0;
  } catch (const std::exception& e) { set_error(err, cap, e.what()); }
  catch (...) { set_error(err, cap, "Falló la escritura Parquet"); }
  return -1;
}

extern "C" int pq_writer_finish(void* ptr, uint64_t* rows, uint64_t* bytes, char* err, uint64_t cap) {
  try {
    auto& w = *static_cast<Writer*>(ptr);
    check(w.writer->Close());
    w.writer.reset();
    check(w.sink->Close());
    w.sink.reset();
    fs::rename(w.temporary, w.final_path);
    w.closed = true;
    *rows = w.rows;
    *bytes = fs::file_size(w.final_path);
    return 0;
  } catch (const std::exception& e) { set_error(err, cap, e.what()); }
  catch (...) { set_error(err, cap, "Falló el cierre del archivo Parquet"); }
  return -1;
}

extern "C" void pq_writer_abort(void* ptr) {
  if (!ptr) return;
  auto& w = *static_cast<Writer*>(ptr);
  if (w.writer) { (void)w.writer->Close(); w.writer.reset(); }
  if (w.sink) { (void)w.sink->Close(); w.sink.reset(); }
  std::error_code ec;
  fs::remove(w.temporary, ec);
}

extern "C" void pq_writer_destroy(void* ptr) { delete static_cast<Writer*>(ptr); }
