#include <cstdio>
#include <cassert>
#include "common.hpp"
#include "net.hpp"
#include "conv_core.hpp"
#include "flow_data.hpp"

ConvCore conv;
Net net;
FlowData in, out;

int main() {
  net = load("model.bin");
  printf("Blocks count: %d\n", (int)net.blocks.size());
  for (int i = 0, _end = (int)net.blocks.size(); i < _end; i++) {
    printf("Block %d:\n", i);
    printf("  Conv1:\n");
    printConvCore(net.blocks[i].conv1, 4);
    printf("  Conv2:\n");
    printConvCore(net.blocks[i].conv2, 4);
  }

  FILE* fp = fopen("conv.bin", "rb");
  assert(fp != NULL);
  conv.loadFromFp(fp);
  printConvCore(conv);
  fclose(fp);
  fp = NULL;

  fp = fopen("input.bin", "rb");
  assert(fp != NULL);
  in.loadFromFp(fp);
  printFlowData(in);
  fclose(fp);
  fp = NULL;

  fp = fopen("output.bin", "rb");
  assert(fp != NULL);
  out.loadFromFp(fp);
  printFlowData(out);
  fclose(fp);
  fp = NULL;

  return 0;
}
