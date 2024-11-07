#pragma once

#include <array>
#include <cstdio>
#include "common.hpp"
#include "flow_data.hpp"

struct QuantizedMatrix33 {
  QuantizedMatrix33() : data() {}
  ~QuantizedMatrix33() {}

  // SingleChannelFlowData apply(int width,
  //                             int height,
  //                             int zero_point,
  //                             int bitwidth,
  //                             const QuantizedSingleChannelFlowData& input,
  //                             int input_zero_point,
  //                             int input_quantized_len) const;

  // void macApply(int width,
  //               int height,
  //               int zero_point,
  //               int bitwidth,
  //               const QuantizedSingleChannelFlowData& input,
  //               int input_zero_point,
  //               int input_quantized_len,
  //               QuantizedSingleChannelFlowData& output) const;

  std::array<int, 9> data;
};
