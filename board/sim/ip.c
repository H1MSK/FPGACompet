#include <stdio.h>
#include <string.h>
#include <assert.h>
#include "pal.h"

uint32_t sim_mem[1024];

void IP_init() {
}

void IP_process(uint16_t width, uint16_t height, const uint8_t* in, uint8_t* out) {
  // memcpy(out, in, width * height * 1);
  void do_net_apply();
  do_net_apply();
  return;
  printf("IP_process finished.\n");
}

void IP_set(uint32_t addr, uint32_t val) {
  assert(addr < 1024);
  sim_mem[addr] = val;
  printf("IP_set@%d:%d.\n", addr, val);
  if (addr == 0 && val == 0x01) {
    IP_process(1024, 1024, NULL, NULL);
  }
}

uint32_t IP_get(uint32_t addr) {
  assert(addr < 1024);
  printf("IP_get@%d.\n", addr);
  if (addr == 1) return 0x01;
  return sim_mem[addr];
}
