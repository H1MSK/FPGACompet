#include <errno.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include "pal.h"

#define PORT 10240

int socket_fd, connect_fd;

void start_server() {
  struct sockaddr_in server_addr;
  socket_fd = socket(AF_INET, SOCK_STREAM, 0);
  if (socket_fd < 0) {
    printf("Error creating socket: %s(errno: %d)\n", strerror(errno), errno);
    exit(1);
  }
  printf("Socket created.\n");
  memset(&server_addr, 0, sizeof(server_addr));
  server_addr.sin_family = AF_INET;
  server_addr.sin_addr.s_addr = htonl(INADDR_ANY);
  server_addr.sin_port = htons(PORT);

  if (bind(socket_fd, (struct sockaddr*)&server_addr, sizeof(server_addr)) <
      0) {
    printf("Error binding socket: %s(errno: %d)\n", strerror(errno), errno);
    exit(1);
  }
  printf("Socket binded.\n");

  if (listen(socket_fd, 1) < 0) {
    printf("Error listening: %s(errno: %d)\n", strerror(errno), errno);
    exit(1);
  }
  printf("Socket listening.\n");
}

void accept_client() {
  struct sockaddr_in client_addr;
  socklen_t client_addr_len = sizeof(client_addr);
  while (1) {
    connect_fd =
        accept(socket_fd, (struct sockaddr*)&client_addr, &client_addr_len);
    if (connect_fd < 0) {
      printf("Error accepting connection: %s(errno: %d)\n", strerror(errno),
             errno);
      continue;
    }
    printf("Client %d.%d.%d.%d:%d connected.\n",
           client_addr.sin_addr.s_addr & 0xff,
           (client_addr.sin_addr.s_addr >> 8) & 0xff,
           (client_addr.sin_addr.s_addr >> 16) & 0xff,
           (client_addr.sin_addr.s_addr >> 24) & 0xff,
           ntohs(client_addr.sin_port));
    break;
  }
}

void close_client() {
  close(connect_fd);
}

uint32_t read_data(uint8_t* data, uint32_t len) {
  int n = recv(connect_fd, data, len, 0);
  if (n < 0) {
    printf("Error receiving data: %s(errno: %d)\n", strerror(errno), errno);
    exit(1);
  }
  return n;
}

uint32_t write_data(const uint8_t* data, uint32_t len) {
  // printf("Sending %d bytes of data:", len);
  // for (int i = 0; i < len; ++i)
  //   printf("%d%c", data[i], ",\n"[i + 1 == len]);
  int n = send(connect_fd, data, len, 0);
  if (n < 0) {
    printf("Error sending data: %s(errno: %d)\n", strerror(errno), errno);
    exit(1);
  }
  return n;
}
