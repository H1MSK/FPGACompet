#pragma once

#include <cstdio>
#include "common.hpp"
#include "conv_core.hpp"

struct ResBlock {
  ConvCore conv1, conv2;

  void loadFromFp(FILE* fp);

  QuantizedResBlock quantize(int bitwidth) const;

  FlowData apply(bool relu_at_output, const FlowData& input) const;
};
