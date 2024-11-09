#include <cstdio>
#include "common.hpp"
#include "conv_core.hpp"
#include "flow_data.hpp"
#include "net.hpp"
#include "quantized_conv_core.hpp"
#include "quantized_net.hpp"

void printConvCore(const ConvCore& core, int leading_space) {
  printf("%*sCore: ch=%d-%d\n", leading_space, "", core.input_channels,
         core.output_channels);
  for (int j = 0, _end2 = core.output_channels; j < _end2; j++) {
    for (int k = 0, _end3 = core.input_channels; k < _end3; k++) {
      printf("%*sWeight (%d, %d):\n", leading_space, "", j, k);
      const Matrix33& mat = core.weights[j][k];
      printf("%*s  %f %f %f\n", leading_space, "", mat.data[0], mat.data[1],
             mat.data[2]);
      printf("%*s  %f %f %f\n", leading_space, "", mat.data[3], mat.data[4],
             mat.data[5]);
      printf("%*s  %f %f %f\n", leading_space, "", mat.data[6], mat.data[7],
             mat.data[8]);
    }
  }
}

void printNet(const Net& net, int leading_space) {
  printf("%*sNet: %d blocks\n", leading_space, "", (int)net.blocks.size());
  for (int i = 0, _end = (int)net.blocks.size(); i < _end; i++) {
    auto& block = net.blocks[i];
    printf("%*sBlock %d: channels=%d-%d-%d\n", leading_space + 2, "", i,
           block.conv1.input_channels, block.conv1.output_channels,
           block.conv2.output_channels);
    printConvCore(block.conv1, leading_space + 4);
    printConvCore(block.conv2, leading_space + 4);
  }
}

void printQuantizedConvCore(const QuantizedConvCore& core, int leading_space) {
  printf("%*sCore: scale=%f, ch=%d-%d\n", leading_space, "", core.scale,
         core.input_channels, core.output_channels);
  for (int j = 0, _end2 = core.output_channels; j < _end2; j++) {
    for (int k = 0, _end3 = core.input_channels; k < _end3; k++) {
      printf("%*sWeight (%d, %d):\n", leading_space, "", j, k);
      const QuantizedMatrix33& mat = core.weights[j][k];
      printf("%*s  %d(%f) %d(%f) %d(%f)\n", leading_space, "", mat.data[0],
             mat.data[0] * core.scale, mat.data[1], mat.data[1] * core.scale,
             mat.data[2], mat.data[2] * core.scale);
      printf("%*s  %d(%f) %d(%f) %d(%f)\n", leading_space, "", mat.data[3],
             mat.data[3] * core.scale, mat.data[4], mat.data[4] * core.scale,
             mat.data[5], mat.data[5] * core.scale);
      printf("%*s  %d(%f) %d(%f) %d(%f)\n", leading_space, "", mat.data[6],
             mat.data[6] * core.scale, mat.data[7], mat.data[7] * core.scale,
             mat.data[8], mat.data[8] * core.scale);
    }
  }
}

void printQuantizedNet(const QuantizedNet& net, int leading_space) {
  printf("%*sNet: %d blocks, bitwidth=%d\n", leading_space, "",
         (int)net.blocks.size(), net.bitwidth);
  for (int i = 0, _end = (int)net.blocks.size(); i < _end; i++) {
    auto& block = net.blocks[i];
    printf("%*sBlock %d: channels=%d-%d-%d\n", leading_space + 2, "", i,
           block.conv1.input_channels, block.conv1.output_channels,
           block.conv2.output_channels);
    printQuantizedConvCore(block.conv1, leading_space + 4);
    printQuantizedConvCore(block.conv2, leading_space + 4);
  }
}

void printSingleChannelFlowData(int width,
                                int height,
                                const SingleChannelFlowData& data,
                                int leading_space) {
  for (int row = 0; row < height; row++) {
    printf("%*s", leading_space, "");
    for (int col = 0; col < width; col++) {
      printf("%f ", data[row][col]);
    }
    printf("\n");
  }
}

void printFlowData(const FlowData& data, int leading_space) {
  printf("%*sFlowData: %d chs, %d x %d\n", leading_space, "",
         (int)data.data.size(), data.width, data.height);
  for (auto it = data.begin(); it != data.end(); ++it) {
    auto& ch = *it;
    printf("%*sChannel %d:\n", leading_space, "", (int)(it - data.begin()));
    printSingleChannelFlowData(data.width, data.height, ch, leading_space + 2);
  }
}

void printQuantizedSingleChannelFlowData(
    int width,
    int height,
    float_point scale,
    const QuantizedSingleChannelFlowData& data,
    int leading_space) {
  for (int row = 0; row < height; row++) {
    printf("%*s", leading_space, "");
    for (int col = 0; col < width; col++) {
      printf("%d(%f) ", data[row][col], data[row][col] * scale);
    }
    printf("\n");
  }
}

void printQuantizedFlowData(const QuantizedFlowData& data, int leading_space) {
  printf("%*sFlowData: %d chs, %d bits, %d x %d\n", leading_space, "",
         (int)data.data.size(), data.bitwidth, data.width, data.height);
  for (auto it = data.begin(); it != data.end(); ++it) {
    auto& ch = *it;
    printf("%*sChannel %d:\n", leading_space, "", (int)(it - data.begin()));
    printQuantizedSingleChannelFlowData(data.width, data.height, data.scale, ch,
                                        leading_space + 2);
  }
}
