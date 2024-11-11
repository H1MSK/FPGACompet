#include "worker.h"
#include <cassert>
#include <cstdbool>
#include <cstdio>
#include "common.h"
#include "net.hpp"
#include "pack.h"
#include "pal.h"
#include "quantized_flow_data.hpp"
#include "quantized_net.hpp"

QuantizedFlowData in_img;
QuantizedFlowData out_img;

static uint32_t pack_cnt;

static ClientPackHeader client;
static ServerPackHeader server;

static Net net;
static QuantizedNet qnet;

inline static uint32_t min(uint32_t a, uint32_t b) {
  return a < b ? a : b;
}

inline static bool do_recv_img() {
  in_img.width = client.data.img_size.width;
  in_img.height = client.data.img_size.height;
  in_img.bitwidth = 8;
  in_img.scale = 1 / 127.f;
  in_img.data.resize(3);
  uint32_t total_len = client.content_len;

  assert(total_len == in_img.width * in_img.height);

  printf("#%u: recv img, size: %d x %d, content length: %u\n",
         (unsigned)pack_cnt, client.data.img_size.width,
         client.data.img_size.height, (unsigned)total_len);

  uint8_t* buf = new uint8_t[in_img.width];
  for (int r = 0; r < in_img.height; ++r) {
    read_data(buf, in_img.width);
    for (int c = 0; c < in_img.width; ++c) {
      in_img[0][r][c] = buf[c] - 128;
      in_img[1][r][c] = buf[c] - 128;
      in_img[2][r][c] = buf[c] - 128;
    }
  }
  delete[] buf;

  server.status = 'o' + ('k' << 8);
  server._reserved = 0;
  server.content_len = 0;
  write_data((uint8_t*)&server, sizeof(server));

  return true;
}

inline static bool do_send_img() {
  printf("#%u: send img, size: %d x %d\n", (unsigned)pack_cnt,
         client.data.img_size.width, client.data.img_size.height);

  uint32_t total_len = 1024 * 1024;

  server.status = 'o' + ('k' << 8);
  server._reserved = 0;
  server.content_len = total_len;
  uint32_t current_len = 0, write_len;

  write_len = write_data((uint8_t*)&server, sizeof(server));
  if (write_len == 0)
    return false;

  uint8_t* buf = new uint8_t[in_img.width];
  auto& ch = out_img[0];
  for (int r = 0; r < out_img.height; ++r) {
    for (int c = 0; c < out_img.width; ++c)
      buf[c] = ch[r][c] + 128;
    write_data(buf, out_img.width);
  }
  delete[] buf;

  return true;
}

inline static bool do_write_arg() {
  printf("#%u: writ arg, addr: 0x%x, data: %d\n", (unsigned)pack_cnt,
         (unsigned)client.data.arg.addr, (unsigned)client.data.arg.data);
  IP_set(client.data.arg.addr, client.data.arg.data);
  server.status = 'o' + ('k' << 8);
  server._reserved = 0;
  server.content_len = 0;
  int len = write_data((uint8_t*)&server, sizeof(server));
  return len == sizeof(server);
}

inline static bool do_read_arg() {
  uint32_t data = IP_get(client.data.arg.addr);
  printf("#%u: read arg, addr: 0x%x, data: %d\n", (unsigned)pack_cnt,
         (unsigned)client.data.arg.addr, (unsigned)data);
  server.status = 'o' + ('k' << 8);
  server._reserved = 0;
  server.content_len = 4;
  int len = write_data((uint8_t*)&server, sizeof(server));
  if (len != sizeof(server))
    return false;
  len = write_data((uint8_t*)&data, 4);
  return len == 4;
}

inline static bool do_write_model() {
  uint8_t* bytes = new uint8_t[client.content_len];

  uint32_t total_len = client.content_len;
  printf("#%u: recv weights, content length: %u\n", (unsigned)pack_cnt,
         (unsigned)total_len);

  uint32_t current_len = 0, read_len;
  uint8_t* ptr = bytes;
  while (current_len < total_len) {
    read_len = read_data(ptr, min(total_len - current_len, MAX_PACK_SIZE));
    if (read_len == 0)
      return false;
    ptr += read_len;
    current_len += read_len;
  }

  net.loadFromBytes(bytes);
  delete bytes;
  qnet = net.quantize(13);

  server.status = 'o' + ('k' << 8);
  server._reserved = 0;
  server.content_len = 0;
  int len = write_data((uint8_t*)&server, sizeof(server));
  return len == sizeof(server);
}

extern "C" void do_net_apply() {
  out_img = qnet.apply(in_img);
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
    printf("connected\n");
    client_connected = true;

    while (client_connected) {
      uint32_t len = read_data((uint8_t*)&client, sizeof(client));
      ++pack_cnt;
      if (len != sizeof(client)) {
        printf(
            "read client header failed, want %u bytes, but get %u bytes. "
            "Disconnect.\n",
            (unsigned)sizeof(client), (unsigned)len);
        break;
      }
      switch (client.identifier) {
        case ID_WRITE_IMG:
          client_connected = do_recv_img();
          if (!client_connected) {
            printf("Receive image failed. Disconnect.\n");
          }
          break;
        case ID_READ_IMG:
          client_connected = do_send_img();
          if (!client_connected) {
            printf("Send image failed. Disconnect.\n");
          }
          break;
        case ID_WRITE_ARG:
          client_connected = do_write_arg();
          if (!client_connected) {
            printf("Receive argument failed. Disconnect.\n");
          }
          break;
        case ID_READ_ARG:
          client_connected = do_read_arg();
          if (!client_connected) {
            printf("Send argument failed. Disconnect.\n");
          }
          break;
        case ID_WRITE_MODEL:
          client_connected = do_write_model();
          if (!client_connected) {
            printf("Receive model failed. Disconnect.\n");
          }
          break;
        default:
          break;
      }
    }
    close_client();
  }
}
