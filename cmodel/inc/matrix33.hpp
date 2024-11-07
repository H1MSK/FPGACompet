#pragma once

#include <array>
#include <cstdio>
#include "common.hpp"
#include "flow_data.hpp"

class Matrix33
{
public:
  Matrix33(): data() {}
  ~Matrix33() {}

  SingleChannelFlowData apply(int width, int height, const SingleChannelFlowData& input) const;

  void loadFromFp(FILE *fp);

  std::array<float_t, 9> data;
};
