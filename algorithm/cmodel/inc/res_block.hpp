#pragma once

#include <cstdio>
#include "common.hpp"
#include "conv_core.hpp"

struct ResBlock {
  ConvCore conv1, conv2;

  const uint8_t *loadFromBytes(const uint8_t* bytes);
  void loadFromFp(FILE* fp);

  QuantizedResBlock quantize(int bitwidth) const;

  FlowData apply(bool relu_at_output, const FlowData& input) const;
};
