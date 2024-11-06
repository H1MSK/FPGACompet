#include "common.hpp"
#include "conv_core.hpp"

void testOrder() {
  ConvCore core;
  FILE* fp = fopen("../conv_core.bin", "rb");
  core.loadFromFp(fp);
  fclose(fp);
  FlowData in;
  fp = fopen("../input.bin", "rb");
  in.loadFromFp(fp);
  fclose(fp);
  FlowData out = core.apply(in);
  FlowData expected;
  fp = fopen("../output.bin", "rb");
  expected.loadFromFp(fp);
  fclose(fp);
  for (int i = 0; i < out.data.size(); i++) {
    for (int r = 0; r < out.height; r++) {
      for (int c = 0; c < out.width; c++) {
        if (abs(out[i][r][c] - expected[i][r][c]) > 0.0001) {
          printf("Mismatch at %d,%d,%d: %f != %f\n", i, r, c, out[i][r][c],
                 expected[i][r][c]);
          return;
        }
      }
    }
  }
}