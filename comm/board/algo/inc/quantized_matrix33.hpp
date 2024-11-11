#pragma once

#include <array>
#include <cstdio>
#include "common.hpp"
#include "flow_data.hpp"

struct QuantizedMatrix33 {
  QuantizedMatrix33() : data() {}
  ~QuantizedMatrix33() {}

  void macApply(int width,
                int height,
                const QuantizedSingleChannelFlowData& input,
                QuantizedSingleChannelFlowData& output) const;

  std::array<int, 9> data;
};
