#include <algorithm>
#include <cassert>
#include "common.hpp"
#include "net.hpp"

Net net;
FlowData in, out;
FlowData expected;
int main() {
  printf("Testing order\n");

  net = load("model.bin");

  printf("Net:\n");
  printNet(net, 2);
  printf("Loaded net with %d blocks\n", (int)net.blocks.size());

  FILE* fp = fopen("input.bin", "rb");
  assert(fp != NULL);
  in.loadFromFp(fp);
  fclose(fp);
  printf("Input loaded.\n");
  // printFlowData(in, 2);
  fp = NULL;
  printf("Loaded input with %d channels, %d rows, %d cols\n",
         (int)in.data.size(), in.height, in.width);

  out = net.apply(in);
  printf("Output loaded.\n");
  // printFlowData(out, 2);
  printf(
      "Applied core to input, got output with %d channels, %d rows, %d cols\n",
      (int)out.data.size(), out.height, out.width);

  fp = fopen("py_out.bin", "rb");
  assert(fp != NULL);
  expected.loadFromFp(fp);
  fclose(fp);
  printf("Expected loaded.\n");
  // printFlowData(expected, 2);
  fp = NULL;
  printf("Loaded expected output with %d channels, %d rows, %d cols\n",
         (int)expected.data.size(), expected.height, expected.width);


  for (int i = 0, _end = (int)out.data.size(); i < _end; i++) {
    for (int r = 0; r < out.height; r++) {
      for (int c = 0; c < out.width; c++) {
        if (abs(out[i][r][c] - expected[i][r][c]) > 0.0001) {
          printf("Mismatch at %d,%d,%d: %f != %f\n", i, r, c, out[i][r][c],
                 expected[i][r][c]);
          return 1;
        }
      }
    }
  }
  printf("Success!\n");
  return 0;
}
