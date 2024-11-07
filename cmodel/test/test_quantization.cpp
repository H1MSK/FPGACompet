#include "net.hpp"
#include "quantized_net.hpp"

Net net;
QuantizedNet quant_net;

int main() {
  net = load("model.bin");
  printf("Net:\n");
  printNet(net);
  quant_net = QuantizedNet::fromNet(net, 13);
  printf("Quantized Net:\n");
  printQuantizedNet(quant_net);

  return 0;
}
