#pragma once

#include <cstdio>
#include <vector>
#include "quantized_res_block.hpp"

struct QuantizedNet {
  int bitwidth;
  std::vector<QuantizedResBlock> blocks;

  QuantizedFlowData apply(const QuantizedFlowData& input) const;
};
