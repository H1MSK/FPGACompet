#include <cstdio>
#include "common.hpp"
#include "conv_core.hpp"

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
