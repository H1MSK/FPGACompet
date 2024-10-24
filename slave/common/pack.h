#ifndef PACK_H
#define PACK_H

#include <stdint.h>

#define MAGIC_WRITE_IMG 0x01234567
#define MAGIC_READ_IMG  0x76543210
#define MAGIC_SEND_ARGS 0x89ABCDEF
#define MAGIC_RECV_ARGS 0xFEDCBA98

typedef struct PackHeader {
  uint32_t magic;
  union {
    struct {
      uint16_t height;
      uint16_t width;
      uint32_t _reserved;
    } img_size;
    struct {
      uint32_t addr;
      uint32_t data;
    } arg;
  } data;
} PackHeader;

#endif  // PACK_H
