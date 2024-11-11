#include <cstdio>
#include <cassert>
#include "common.hpp"
#include "net.hpp"
#include "conv_core.hpp"
#include "flow_data.hpp"

ConvCore conv;
Net net, net1;
FlowData in, out;

void checkEqual(const Matrix33& a, const Matrix33& b) {
  for (int i = 0, _end = (int)a.data.size(); i < _end; i++) {
    assert(a.data[i] == b.data[i]);
  }
}

void checkEqual(const ConvCore& a, const ConvCore& b) {
  assert(a.input_channels == b.input_channels);
  assert(a.output_channels == b.output_channels);
  for (int i = 0, _end = (int)a.weights.size(); i < _end; i++) {
    for (int j = 0, _end2 = (int)a.weights[i].size(); j < _end2; j++) {
      checkEqual(a.weights[i][j], b.weights[i][j]);
    }
  }
}

void checkEqual(const ResBlock& a, const ResBlock& b) {
  checkEqual(a.conv1, b.conv1);
  checkEqual(a.conv2, b.conv2);
}

void checkEqual(const Net& a, const Net& b) {
  assert(a.blocks.size() == b.blocks.size());
  for (int i = 0, _end = (int)a.blocks.size(); i < _end; i++) {
    checkEqual(a.blocks[i].conv1, b.blocks[i].conv1);
  }
}

int main() {
  net = load("model.bin");

  FILE* fp = fopen("model.bin", "rb");
  assert(fp != NULL);
  fseek(fp, 0, SEEK_END);
  uint32_t file_size = ftell(fp);
  fseek(fp, 0, SEEK_SET);
  uint8_t* file_data = new uint8_t[file_size];
  assert(file_data != NULL);
  size_t cnt = fread(file_data, 1, file_size, fp);
  assert(cnt == file_size);
  fclose(fp);
  fp = NULL;
  net1.loadFromBytes(file_data);
  delete[] file_data;
  checkEqual(net, net1);
  printf("Model loaded.\n");

  fp = fopen("input.bin", "rb");
  assert(fp != NULL);
  in.loadFromFp(fp);
  fclose(fp);
  fp = NULL;
  printf("Input loaded.\n");

  fp = fopen("output.bin", "rb");
  assert(fp != NULL);
  out.loadFromFp(fp);
  fclose(fp);
  fp = NULL;
  printf("Output loaded.\n");

  return 0;
}
