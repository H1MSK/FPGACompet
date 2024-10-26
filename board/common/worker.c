#include "worker.h"
#include <stdio.h>
#include <stdbool.h>
#include "common.h"
#include "pack.h"
#include "pal.h"

uint8_t in_img[MAX_IMG_SIZE];
uint8_t out_img[MAX_IMG_SIZE];

static uint32_t pack_cnt;

static ClientPackHeader client;
static ServerPackHeader server;

inline static uint32_t min(uint32_t a, uint32_t b) {
  return a < b ? a : b;
}

inline static bool do_recv_img() {
  uint8_t* ptr = in_img;
  uint32_t total_len = client.content_len;
  printf("#%lu: recv img, size: %d x %d, content length: %lu\n", pack_cnt,
         client.data.img_size.width, client.data.img_size.height, total_len);

  uint32_t current_len = 0, read_len;
  while (current_len < total_len) {
    read_len = read_data(ptr, min(total_len - current_len, MAX_PACK_SIZE));
    if (read_len == 0) return false;
    ptr += read_len;
    current_len += read_len;
  }

  server.status = 'o' + ('k' << 8);
  server._reserved = 0;
  server.content_len = 0;
  write_data((uint8_t*)&server, sizeof(server));

  return true;
}

inline static bool do_send_img() {
  printf("#%lu: send img, size: %d x %d\n", pack_cnt, client.data.img_size.width,
         client.data.img_size.height);
  uint8_t* ptr = out_img;

  uint32_t total_len = 1024 * 1024;

  server.status = 'o' + ('k' << 8);
  server._reserved = 0;
  server.content_len = total_len;
  uint32_t current_len = 0, write_len;
  
  write_len = write_data((uint8_t*)&server, sizeof(server));
  if (write_len == 0) return false;

  while (current_len < total_len) {
    write_len = write_data(ptr, min(total_len - current_len, MAX_PACK_SIZE));
    if (write_len == 0) return false;
    ptr += write_len;
    current_len += write_len;
  }

  return true;
}

inline static bool do_write_arg() {
  printf("#%lu: writ arg, addr: 0x%lx, data: 0x%lx\n", pack_cnt, client.data.arg.addr,
         client.data.arg.data);
  IP_set(client.data.arg.addr, client.data.arg.data);
  server.status = 'o' + ('k' << 8);
  server._reserved = 0;
  server.content_len = 0;
  int len = write_data((uint8_t*)&server, sizeof(server));
  return len == sizeof(server);
}

inline static bool do_read_arg() {
  uint32_t data = IP_get(client.data.arg.addr);
  printf("#%lu: read arg, addr: 0x%lx, data: 0x%lx\n", pack_cnt, client.data.arg.addr,
         data);
  server.status = 'o' + ('k' << 8);
  server._reserved = 0;
  server.content_len = 4;
  int len = write_data((uint8_t*)&server, sizeof(server));
  if (len != sizeof(server)) return false;
  len = write_data((uint8_t*)&data, 4);
  return len == 4;
}

void worker_main() {
  printf("worker start\n");
  IP_init();
  printf("IP init done\n");

  start_server();
  printf("server start\n");

  bool client_connected;

  while (1) {
    printf("waiting for client\n");
    accept_client();
    client_connected = true;

    while (client_connected) {
      uint32_t len = read_data((uint8_t*)&client, sizeof(client));
      ++pack_cnt;
      if (len != sizeof(client)) {
        printf(
            "read client failed, want %u bytes, but get %lu bytes. "
            "Disconnect.\n",
            sizeof(client), len);
        break;
      }
      switch (client.identifier) {
        case ID_WRITE_IMG:
          client_connected = do_recv_img(client);
          break;
        case ID_READ_IMG:
        	client_connected = do_send_img(client);
          break;
        case ID_WRITE_ARG:
        	client_connected = do_write_arg(client);
          break;
        case ID_READ_ARG:
        	client_connected = do_read_arg(client);
          break;
        default:
          break;
      }
    }
    close_client();
  }
}
