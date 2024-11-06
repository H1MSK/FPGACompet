#include <cassert>
#include "common.hpp"
#include "matrix33.hpp"
#include "conv_core.hpp"
#include "res_block.hpp"
#include "net.hpp"
#include "flow_data.hpp"

void Matrix33::loadFromFp(FILE *fp) {
  int cnt = fread(data.data(), sizeof(float_t), 9, fp);
  assert(cnt == 9);
}

void ConvCore::loadFromFp(FILE *fp) {
  uint16_t x;
  int cnt = fread(&x, 2, 1, fp);
  output_channels = x;
  assert(cnt == 1);
  cnt = fread(&x, 2, 1, fp);
  input_channels = x;
  assert(cnt == 1);

  for (int oc = 0; oc < output_channels; oc++) {
    for (int ic = 0; ic < input_channels; ic++) {
      weights[oc][ic].loadFromFp(fp);
    }
  }
}

void ResBlock::loadFromFp(FILE *fp) {
  conv1.loadFromFp(fp);
  conv2.loadFromFp(fp);
}

void Net::loadFromFp(FILE *fp) {
  for (auto& block : blocks) {
    block.loadFromFp(fp);
  }
}

void SingleChannelFlowData::loadFromFp(int width, int height, FILE *fp) {
  for (int r = 0; r < height; r++) {
    int cnt = fread(data[r].data(), sizeof(float_t), width, fp);
    assert(cnt == width);
  }
}

void FlowData::loadFromFp(FILE *fp) {
  uint16_t x[4];
  int cnt = fread(&x, 2, 4, fp);
  assert(cnt == 4 && x[0] == 1);  // we only support batch_size = 1 currently
  int channel_count = x[1];
  width = x[2];
  height = x[3];
  for(int i = 0; i < channel_count; i++) {
    SingleChannelFlowData channel;
    channel.loadFromFp(width, height, fp);
    data.push_back(channel);
  }
}

Net load(const char* filename) {
  FILE *fp = fopen(filename, "rb");
  if (fp == NULL) {
    printf("Error: failed to open model.bin\n");
    return Net();
  }
  printf("Loading model data...\n");
  Net net;
  int layer_count;
  int cnt = fread(&layer_count, sizeof(int), 1, fp);
  assert(cnt == 1);
  for (int i = 0; i < layer_count; i++) {
    ResBlock block;
    block.loadFromFp(fp);
    net.blocks.push_back(block);
  }
  return net;
}
