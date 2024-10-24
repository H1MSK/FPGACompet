#include "worker.h"
#include <stdio.h>
#include "common.h"
#include "pack.h"
#include "pal.h"

uint8_t in_img[MAX_IMG_SIZE];
uint8_t out_img[MAX_IMG_SIZE];

static uint8_t msg_ok[] = {'o', 'k'};

inline static uint32_t min(uint32_t a, uint32_t b) {
  return a < b ? a : b;
}

inline static void do_recv_img(PackHeader header) {
  uint8_t* ptr = in_img;
  uint32_t total_len = header.content_len;
  printf("recv img, size: %d x %d, content length: %d\n",
         header.data.img_size.width, header.data.img_size.height, total_len);

  uint32_t current_len = 0, read_len;
  while (current_len < total_len) {
    read_len = read_data(ptr, min(total_len - current_len, MAX_PACK_SIZE));
    ptr += read_len;
    current_len += read_len;
  }

  write_data(msg_ok, ARRLEN(msg_ok));
}

inline static void do_send_img(PackHeader header) {
  printf("send img, size: %d x %d\n", header.data.img_size.width,
         header.data.img_size.height);
  uint8_t* ptr = out_img;
  write_data(msg_ok, ARRLEN(msg_ok));

  uint32_t total_len = 1024 * 1024;

  uint32_t current_len = 0, write_len;
  while (current_len < total_len) {
    write_len = write_data(ptr, min(total_len - current_len, MAX_PACK_SIZE));
    ptr += write_len;
    current_len += write_len;
  }
}

inline static void do_write_arg(PackHeader header) {
  printf("write arg, addr: %x, data: %x\n", header.data.arg.addr,
         header.data.arg.data);
  IP_set(header.data.arg.addr, header.data.arg.data);
  write_data(msg_ok, ARRLEN(msg_ok));
}

inline static void do_read_arg(PackHeader header) {
  uint32_t data = IP_get(header.data.arg.addr);
  printf("read arg, addr: %x, data: %x\n", header.data.arg.addr, data);
  write_data(msg_ok, ARRLEN(msg_ok));
  write_data((uint8_t*)&data, 4);
}

void worker_main() {
  printf("worker start\n");
  IP_init();
  printf("IP init done\n");

  start_server();
  printf("server start\n");

  while (1) {
    printf("waiting for client\n");
    accept_client();
    PackHeader header;
    while (1) {
      uint32_t len = read_data((uint8_t*)&header, sizeof(header));
      if (len != sizeof(header)) {
        printf(
            "read header failed, want %ld bytes, but get %d bytes. "
            "Disconnect.\n",
            sizeof(header), len);
        close_client();
        break;
      }
      switch (header.magic) {
        case MAGIC_WRITE_IMG:
          do_recv_img(header);
          break;
        case MAGIC_READ_IMG:
          do_send_img(header);
          break;
        case MAGIC_WRITE_ARG:
          do_write_arg(header);
          break;
        case MAGIC_READ_ARG:
          do_read_arg(header);
          break;
        default:
          break;
      }
    }
  }
}