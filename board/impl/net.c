#include "../common/pal.h"
#include "lwip/sockets.h"
#include "xil_printf.h"

const int worker_port = 10240;

int server_sock;
int client_sock;

void start_server() {
	struct sockaddr_in address;
	int ret;
	memset(&address, 0, sizeof(address));

	server_sock = lwip_socket(AF_INET, SOCK_STREAM, 0);
	if (server_sock < 0){
		xil_printf("lwip_socket error: %d\r\n", server_sock);
		return;
	}

	address.sin_family = AF_INET;
	address.sin_port = htons(worker_port);
	address.sin_addr.s_addr = INADDR_ANY;

	ret = lwip_bind(server_sock, (struct sockaddr *)&address, sizeof (address));
	if (ret < 0) {
		xil_printf("lwip_bind error: %d\r\n", ret);
		return;
	}

	lwip_listen(server_sock, 0);

}

void accept_client() {
	struct sockaddr_in remote;
	int size = sizeof(remote);

	while (1) {
		client_sock = lwip_accept(server_sock, (struct sockaddr *)&remote, (socklen_t *)&size);
		if (client_sock > 0) break;
		xil_printf("lwip_accept error: %d\r\n", client_sock);
	}
}

void close_client() {
	close(client_sock);
}

uint32_t read_data(uint8_t* data, uint32_t len) {
	int n = read(client_sock, data, len);
	if (n < 0) {
		xil_printf("read error: %d\r\n", n);
		n = 0;
	}
	return n;
}

uint32_t write_data(const uint8_t* data, uint32_t len) {
	int n = write(client_sock, data, len);
	if (n < 0) {
		xil_printf("read error: %d\r\n", n);
		n = 0;
	}
	return n;
}
