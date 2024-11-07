#include <cstdio>
#include "common.hpp"
#include "net.hpp"

int main() {
  Net net = load("../model.bin");
  printf("Blocks count: %ld\n", net.blocks.size());
  for (int i = 0, _end = net.blocks.size(); i < _end; i++) {
    printf("Block %d:\n", i);
    printf("  Conv1:\n");
    printConvCoreData(net.blocks[i].conv1);
    printf("  Conv2:\n");
    printConvCoreData(net.blocks[i].conv2);
  }
  return 0;
}
