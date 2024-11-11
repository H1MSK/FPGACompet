#include <cassert>
#include "common.hpp"
#include "conv_core.hpp"
#include "flow_data.hpp"
#include "matrix33.hpp"
#include "net.hpp"
#include "quantized_flow_data.hpp"
#include "res_block.hpp"

const uint8_t* Matrix33::loadFromBytes(const uint8_t* bytes) {
  auto fptr = (const float_point*)bytes;
  for (int i = 0; i < 9; i++) {
    data[i] = *fptr++;
  }
  return (uint8_t*)fptr;
}

void Matrix33::loadFromFp(FILE* fp) {
  int cnt = (int)fread(data.data(), sizeof(float_point), 9, fp);
  assert(cnt == 9);
}

const uint8_t* ConvCore::loadFromBytes(const uint8_t* bytes) {
  auto iptr = (const uint32_t*)bytes;
  int magic = *iptr++;
  assert(magic == ID_CONV_FLOAT);
  auto sptr = (const uint16_t*)iptr;
  output_channels = *sptr++;
  input_channels = *sptr++;

  auto bptr = (const uint8_t*)sptr;
  for (int oc = 0; oc < output_channels; oc++) {
    for (int ic = 0; ic < input_channels; ic++) {
      bptr = weights[oc][ic].loadFromBytes(bptr);
    }
  }
  return bptr;
}

void ConvCore::loadFromFp(FILE* fp) {
  uint32_t magic;
  int cnt = (int)fread(&magic, sizeof(uint32_t), 1, fp);
  assert(cnt == 1 && magic == ID_CONV_FLOAT);
  uint16_t x[2];
  cnt = (int)fread(x, sizeof(uint16_t), 2, fp);
  assert(cnt == 2);
  output_channels = x[0];
  input_channels = x[1];

  for (int oc = 0; oc < output_channels; oc++) {
    for (int ic = 0; ic < input_channels; ic++) {
      weights[oc][ic].loadFromFp(fp);
    }
  }
}

const uint8_t* ResBlock::loadFromBytes(const uint8_t* bytes) {
  bytes = conv1.loadFromBytes(bytes);
  bytes = conv2.loadFromBytes(bytes);
  return bytes;
}

void ResBlock::loadFromFp(FILE* fp) {
  conv1.loadFromFp(fp);
  conv2.loadFromFp(fp);
}

const uint8_t* Net::loadFromBytes(const uint8_t* bytes) {
  auto iptr = (const uint32_t*)bytes;
  int magic = *iptr++;
  assert(magic == ID_MODEL);
  int layer_count;
  layer_count = *iptr++;
  blocks.reserve(layer_count);
  auto bptr = (const uint8_t*)iptr;
  for (int i = 0; i < layer_count; i++) {
    blocks.emplace_back();
    ResBlock& block = blocks.back();
    bptr = block.loadFromBytes(bptr);
  }
  return bptr;
}

void Net::loadFromFp(FILE* fp) {
  uint32_t magic;
  int cnt = (int)fread(&magic, sizeof(uint32_t), 1, fp);
  assert(cnt == 1 && magic == ID_MODEL);
  int layer_count;
  cnt = (int)fread(&layer_count, sizeof(int), 1, fp);
  assert(cnt == 1);
  blocks.reserve(layer_count);
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
  uint16_t x[6];
  int cnt = (int)fread(&x, sizeof(uint16_t), 6, fp);
  assert(cnt == 6);
  uint32_t magic = *((uint32_t*)x);
  assert(magic == ID_FLOW_FLOAT);
  assert(x[2] == 1);  // we only support batch_size = 1 currently
  int channel_count = x[3];
  height = x[4];
  width = x[5];
  data.reserve(channel_count);
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
  uint16_t x[6];
  int cnt = (int)fread(&x, sizeof(uint16_t), 6, fp);
  assert(cnt == 6 && x[2] == 1);

  uint32_t magic = *((uint32_t*)x);
  assert(magic == ID_FLOW_QUANT);

  int channel_count = x[3];
  width = x[5];
  height = x[4];
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
