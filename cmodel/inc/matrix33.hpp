#pragma once

#include <array>
#include <cstdio>
#include "common.hpp"
#include "flow_data.hpp"

class Matrix33 {
 public:
  Matrix33() : data() {}
  ~Matrix33() {}

  SingleChannelFlowData apply(int width,
                              int height,
                              const SingleChannelFlowData& input) const;
  void macApply(int width,
                int height,
                const SingleChannelFlowData& input,
                SingleChannelFlowData& output) const;

  void loadFromFp(FILE* fp);

  std::array<float_point, 9> data;
};
