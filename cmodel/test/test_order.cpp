#include <algorithm>
#include <cassert>
#include "common.hpp"
#include "conv_core.hpp"

ConvCore core;
FlowData in, out;
FlowData expected;
int main() {
  printf("Testing order\n");

  FILE* fp = fopen("conv.bin", "rb");
  assert(fp != NULL);
  core.loadFromFp(fp);
  fclose(fp);
  printf("Core:\n");
  printConvCore(core, 2);
  fp = NULL;
  printf("Loaded core with %d input channels and %d output channels\n",
         core.input_channels, core.output_channels);

  fp = fopen("input.bin", "rb");
  assert(fp != NULL);
  in.loadFromFp(fp);
  fclose(fp);
  printf("Input:\n");
  printFlowData(in, 2);
  fp = NULL;
  printf("Loaded input with %d channels, %d rows, %d cols\n",
         (int)in.data.size(), in.height, in.width);

  out = core.apply(in);
  printf("Out:\n");
  printFlowData(out, 2);
  printf(
      "Applied core to input, got output with %d channels, %d rows, %d cols\n",
      (int)out.data.size(), out.height, out.width);

  fp = fopen("output.bin", "rb");
  assert(fp != NULL);
  expected.loadFromFp(fp);
  fclose(fp);
  printf("Expected:\n");
  printFlowData(expected, 2);
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
