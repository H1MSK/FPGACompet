#ifndef PACK_H
#define PACK_H

#include <stdint.h>

#define ID_WRITE_IMG 0x01234567
#define ID_READ_IMG  0x76543210
#define ID_WRITE_ARG 0x89ABCDEF
#define ID_READ_ARG  0xFEDCBA98

typedef struct ClientPackHeader {
  uint32_t identifier;
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
  uint32_t content_len;
} ClientPackHeader;

typedef struct ServerPackHeader {
  uint16_t status;
  uint16_t _reserved;
  uint32_t content_len;
} ServerPackHeader;

#endif  // PACK_H
