#include <cassert>
#include "common.hpp"
#include "conv_core.hpp"
#include "flow_data.hpp"
#include "matrix33.hpp"
#include "net.hpp"
#include "quantized_flow_data.hpp"
#include "res_block.hpp"

void Matrix33::loadFromFp(FILE* fp) {
  int cnt = (int)fread(data.data(), sizeof(float_point), 9, fp);
  assert(cnt == 9);
}

void ConvCore::loadFromFp(FILE* fp) {
  uint16_t x[2];
  int cnt = (int)fread(x, sizeof(uint16_t), 2, fp);
  assert(cnt == 2);
  output_channels = x[0];
  input_channels = x[1];

  for (int oc = 0; oc < output_channels; oc++) {
    for (int ic = 0; ic < input_channels; ic++) {
      weights[oc][ic].loadFromFp(fp);
    }
  }
}

void ResBlock::loadFromFp(FILE* fp) {
  conv1.loadFromFp(fp);
  conv2.loadFromFp(fp);
}

void Net::loadFromFp(FILE* fp) {
  int layer_count;
  int cnt = (int)fread(&layer_count, sizeof(int), 1, fp);
  assert(cnt == 1);
  for (int i = 0; i < layer_count; i++) {
    blocks.emplace_back();
    ResBlock& block = blocks.back();
    block.loadFromFp(fp);
  }
}

void SingleChannelFlowData::loadFromFp(int width, int height, FILE* fp) {
  for (int r = 0; r < height; r++) {
    int cnt = (int)fread(data[r].data(), sizeof(float_point), width, fp);
    assert(cnt == width);
  }
}

void FlowData::loadFromFp(FILE* fp) {
  uint16_t x[4];
  int cnt = (int)fread(&x, sizeof(uint16_t), 4, fp);
  assert(cnt == 4 && x[0] == 1);  // we only support batch_size = 1 currently
  int channel_count = x[1];
  height = x[2];
  width = x[3];
  for (int i = 0; i < channel_count; i++) {
    data.emplace_back();
    SingleChannelFlowData& channel = data.back();
    channel.loadFromFp(width, height, fp);
  }
}

void QuantizedSingleChannelFlowData::loadFromFp(int width,
                                                int height,
                                                FILE* fp) {
  static int8_t buf[MAX_WIDTH];
  for (int r = 0; r < height; r++) {
    int cnt = (int)fread(buf, sizeof(int8_t), width, fp);
    assert(cnt == width);
    for (int c = 0; c < width; c++) {
      data[r][c] = buf[c];
    }
  }
}

void QuantizedFlowData::loadFromFp(FILE* fp) {
  uint16_t x[4];
  int cnt = (int)fread(&x, sizeof(uint16_t), 4, fp);
  assert(cnt == 4 && x[0] == 1);

  int channel_count = x[1];
  width = x[3];
  height = x[2];
  bitwidth = 8;
  scale = float_point(1.0) / (1 << (bitwidth - 1));

  for (int i = 0; i < channel_count; i++) {
    data.emplace_back();
    QuantizedSingleChannelFlowData& channel = data.back();
    channel.loadFromFp(width, height, fp);
  }
}

Net load(const char* filename) {
  FILE* fp = fopen(filename, "rb");
  if (fp == NULL) {
    printf("Error: failed to open model.bin\n");
    return Net();
  }
  printf("Loading model data...\n");
  Net net;
  net.loadFromFp(fp);
  return net;
}
