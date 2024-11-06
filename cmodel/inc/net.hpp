#pragma once

#include <vector>
#include <cstdio>
#include "res_block.hpp"

struct Net {
  std::vector<ResBlock> blocks;
  
  void loadFromFp(FILE *fp);

  FlowData apply(const FlowData& input) const;
};
