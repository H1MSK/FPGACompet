#include <stdio.h>
#include <string.h>
#include "pal.h"

void IP_init() {
}

void IP_process(uint16_t width, uint16_t height, const uint8_t* in, uint8_t* out) {
  memcpy(out, in, width * height * 1);
  printf("IP_process finished.\n");
}

void IP_set(uint32_t addr, uint32_t val) {
  printf("IP_set@%d:%d.\n", addr, val);
  if (addr == 0 && val == 0x01) {
    IP_process(1024, 1024, in_img, out_img);
  }
}

uint32_t IP_get(uint32_t addr) {
  printf("IP_get@%d.\n", addr);
  if (addr == 1) return 0x01;
  return 0;
}
