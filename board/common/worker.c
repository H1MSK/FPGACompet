#include "worker.h"
#include <stdio.h>
#include "common.h"
#include "pack.h"
#include "pal.h"

uint8_t in_img[MAX_IMG_SIZE];
uint8_t out_img[MAX_IMG_SIZE];

static ClientPackHeader client;
static ServerPackHeader server;

inline static uint32_t min(uint32_t a, uint32_t b) {
  return a < b ? a : b;
}

inline static void do_recv_img() {
  uint8_t* ptr = in_img;
  uint32_t total_len = client.content_len;
  printf("recv img, size: %d x %d, content length: %d\n",
         client.data.img_size.width, client.data.img_size.height, total_len);

  uint32_t current_len = 0, read_len;
  while (current_len < total_len) {
    read_len = read_data(ptr, min(total_len - current_len, MAX_PACK_SIZE));
    ptr += read_len;
    current_len += read_len;
  }

  server.status = 'o' + ('k' << 8);
  server.content_len = 0;
  write_data((uint8_t*)&server, sizeof(server));
}

inline static void do_send_img() {
  printf("send img, size: %d x %d\n", client.data.img_size.width,
         client.data.img_size.height);
  uint8_t* ptr = out_img;

  uint32_t total_len = 1024 * 1024;

  server.status = 'o' + ('k' << 8);
  server.content_len = total_len;
  write_data((uint8_t*)&server, sizeof(server));

  uint32_t current_len = 0, write_len;
  while (current_len < total_len) {
    write_len = write_data(ptr, min(total_len - current_len, MAX_PACK_SIZE));
    ptr += write_len;
    current_len += write_len;
  }
}

inline static void do_write_arg() {
  printf("write arg, addr: %x, data: %x\n", client.data.arg.addr,
         client.data.arg.data);
  IP_set(client.data.arg.addr, client.data.arg.data);
  server.status = 'o' + ('k' << 8);
  server.content_len = 0;
  write_data((uint8_t*)&server, sizeof(server));
}

inline static void do_read_arg() {
  uint32_t data = IP_get(client.data.arg.addr);
  printf("read arg, addr: %x, data: %x\n", client.data.arg.addr, data);
  server.status = 'o' + ('k' << 8);
  server.content_len = 4;
  write_data((uint8_t*)&server, sizeof(server));
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
    
    while (1) {
      uint32_t len = read_data((uint8_t*)&client, sizeof(client));
      if (len != sizeof(client)) {
        printf(
            "read client failed, want %ld bytes, but get %d bytes. "
            "Disconnect.\n",
            sizeof(client), len);
        close_client();
        break;
      }
      switch (client.identifier) {
        case ID_WRITE_IMG:
          do_recv_img(client);
          break;
        case ID_READ_IMG:
          do_send_img(client);
          break;
        case ID_WRITE_ARG:
          do_write_arg(client);
          break;
        case ID_READ_ARG:
          do_read_arg(client);
          break;
        default:
          break;
      }
    }
  }
}