#ifndef PAL_H
#define PAL_H

#include <stdint.h>
#include "common.h"

#ifdef __cplusplus
extern "C" {
#endif

// to IP
void IP_init();
void IP_process(uint16_t width,
                 uint16_t height,
                 const uint8_t* in,
                 uint8_t* out);

void IP_set(uint32_t addr, uint32_t val);
uint32_t IP_get(uint32_t addr);

// to host
void start_server();
void accept_client();
void close_client();
uint32_t read_data(uint8_t* data, uint32_t len);
uint32_t write_data(const uint8_t* data, uint32_t len);

#ifdef __cplusplus
}  // extern "C"
#endif

#endif  // PAL_H
