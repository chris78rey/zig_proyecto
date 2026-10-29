#pragma once
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
  int32_t type;       /* 0 bool, 1 int64, 2 float64, 3 decimal text, 4 utf8, 5 binary, 6 date, 7 timestamp, 8 zoned timestamp */
  int32_t nullable;
  int32_t precision;
  int32_t scale;
  const char* name;
  uint64_t name_len;
} pq_column;

typedef struct {
  int32_t is_null;
  int32_t boolean_value;
  int64_t integer_value;
  double float_value;
  const uint8_t* bytes;
  uint64_t bytes_len;
  int32_t year, month, day, hour, minute, second;
  uint32_t nanosecond;
  int32_t offset_minutes;
} pq_cell;

void* pq_writer_create(const char* directory, uint64_t directory_len,
                       const pq_column* columns, uint64_t column_count,
                       uint64_t row_group_rows, char* error, uint64_t error_cap);
int pq_writer_write(void* writer, const pq_cell* cells, uint64_t row_count,
                    char* error, uint64_t error_cap);
int pq_writer_finish(void* writer, uint64_t* rows, uint64_t* bytes,
                     char* error, uint64_t error_cap);
void pq_writer_abort(void* writer);
void pq_writer_destroy(void* writer);

#ifdef __cplusplus
}
#endif
