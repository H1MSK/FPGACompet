#pragma once

#include <array>
#include <cstdio>
#include "common.hpp"
#include "flow_data.hpp"
#include "quantized_matrix33.hpp"

struct QuantizedConvCore {
  float_point scale;

  int input_channels;
  int output_channels;
  std::array<std::array<QuantizedMatrix33, MAX_CHANNEL>, MAX_CHANNEL> weights;

  static QuantizedConvCore fromConvCore(const ConvCore& core, int bitwidth);

  // QuantizedFlowData apply(const QuantizedFlowData& input) const;
};
