#include "worker.h"
#include "pal.h"
#include "pack.h"

uint8_t in_img[MAX_IMG_SIZE];
uint8_t out_img[MAX_IMG_SIZE];

void worker_main() {
  IP_init();

  start_server();

  accept_client();

  PackHeader header;
  while (1) {
    read_data((uint8_t*)&header, sizeof(header));
    switch (header.magic)
    {
    case MAGIC_WRITE_IMG:
      /* code */
      break;
    
    default:
      break;
    }
  }
}