#include <cassert>
#include "matrix33.hpp"
#include "conv_core.hpp"
#include "res_block.hpp"
#include "net.hpp"

void Matrix33::loadFromFp(FILE *fp) {
  int cnt = fread(data.data(), sizeof(float_t), 9, fp);
  assert(cnt == 9);
}

void ConvCore::loadFromFp(FILE *fp) {
  uint16_t x;
  int cnt = fread(&x, 2, 1, fp);
  output_channels = x;
  assert(cnt == 2);
  cnt = fread(&x, 2, 1, fp);
  input_channels = x;
  assert(cnt == 2);

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

Net load(const char* filename) {
  FILE *fp = fopen(filename, "rb");
  if (fp == NULL) {
    printf("Error: failed to open model.bin\n");
    return;
  }
  printf("Loading model data...\n");
  Net net;
  int layer_count;
  int cnt = fread(&layer_count, sizeof(int), 1, fp);
  assert(cnt == sizeof(int));
  for (int i = 0; i < layer_count; i++) {
    ResBlock block;
    block.loadFromFp(fp);
    net.blocks.push_back(block);
  }
}