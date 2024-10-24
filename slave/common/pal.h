#ifndef PAL_H
#define PAL_H

#include <stdint.h>
#include <stdbool.h>

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
bool accept_client();
void read_data(uint8_t* data, uint32_t len);
void write_data(const uint8_t* data, uint32_t len);

#endif  // PAL_H
