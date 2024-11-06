#include <cstdio>
#include "net.hpp"

void printConvCoreData(const ConvCore& core) {
    printf("    Input channels: %d\n", core.input_channels);
    printf("    Output channels: %d\n", core.output_channels);
    for (int j = 0, _end2 = core.output_channels; j < _end2; j++) {
      for (int k = 0, _end3 = core.input_channels; k < _end3; k++) {
        printf("    Weight (%d, %d):\n", j, k);
        const Matrix33 &mat = core.weights[j][k];
        printf("      %f %f %f\n", mat.data[0], mat.data[1], mat.data[2]);
        printf("      %f %f %f\n", mat.data[3], mat.data[4], mat.data[5]);
        printf("      %f %f %f\n", mat.data[6], mat.data[7], mat.data[8]);
      }
    }
}

void testLoadData() {
  Net net = load("../model.bin");
  printf("Blocks count: %ld\n", net.blocks.size());
  for (int i = 0, _end = net.blocks.size(); i < _end; i++) {
    printf("Block %d:\n", i);
    printf("  Conv1:\n");
    printConvCoreData(net.blocks[i].conv1);
    printf("  Conv2:\n");
    printConvCoreData(net.blocks[i].conv2);
  }
}
