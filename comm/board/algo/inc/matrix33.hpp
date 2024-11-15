#pragma once

#include <array>
#include <cstdio>
#include "common.hpp"
#include "flow_data.hpp"

class Matrix33 {
 public:
  Matrix33() : data() {}
  ~Matrix33() {}

  void macApply(int width,
                int height,
                const SingleChannelFlowData& input,
                SingleChannelFlowData& output) const;

  void loadFromFp(FILE* fp);
  const uint8_t* loadFromBytes(const uint8_t* bytes);

  std::array<float_point, 9> data;
};
