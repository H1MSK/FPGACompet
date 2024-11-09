#pragma once

#include <vector>
#include <cstdio>
#include "res_block.hpp"

struct Net {
  std::vector<ResBlock> blocks;
  
  const uint8_t* loadFromBytes(const uint8_t* bytes);
  void loadFromFp(FILE *fp);

  QuantizedNet quantize(int bitwidth) const;

  FlowData apply(const FlowData& input) const;
};
