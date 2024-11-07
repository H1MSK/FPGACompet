#include <algorithm>
#include <cassert>
#include "common.hpp"
#include "conv_core.hpp"

int main() {
  ConvCore core;
  printf("Testing order\n");
  FILE* fp = fopen("../conv.bin", "rb");
  assert(fp != NULL);
  core.loadFromFp(fp);
  fclose(fp);
  printf("Loaded core with %d input channels and %d output channels\n",
         core.input_channels, core.output_channels);
  FlowData in;
  fp = fopen("../input.bin", "rb");
  assert(fp != NULL);
  in.loadFromFp(fp);
  fclose(fp);
  printf("Loaded input with %ld channels, %d rows, %d cols\n", in.data.size(),
         in.height, in.width);
  FlowData out = core.apply(in);
  printf("Applied core to input, got output with %ld channels, %d rows, %d cols\n",
         out.data.size(), out.height, out.width);
  FlowData expected;
  fp = fopen("../output.bin", "rb");
  assert(fp != NULL);
  expected.loadFromFp(fp);
  fclose(fp);
  printf("Loaded expected output with %ld channels, %d rows, %d cols\n",
         expected.data.size(), expected.height, expected.width);
  for (int i = 0, _end = out.data.size(); i < _end; i++) {
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
