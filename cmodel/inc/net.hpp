#pragma once

#include <vector>
#include <cstdio>
#include "res_block.hpp"

struct Net {
  std::vector<ResBlock> blocks;
  
  void loadFromFp(FILE *fp);

  QuantizedNet quantize(int bitwidth) const;

  FlowData apply(const FlowData& input) const;
};
