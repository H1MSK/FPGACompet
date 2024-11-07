#pragma once

#include <cstdio>
#include <vector>
#include "quantized_res_block.hpp"

struct QuantizedNet {
  int bitwidth;
  std::vector<QuantizedResBlock> blocks;

  static QuantizedNet fromNet(const Net& net, int bitwidth);

  // FlowData apply(const FlowData& input) const;
};
