#pragma once

#include <array>
#include <cstdio>
#include "common.hpp"
#include "flow_data.hpp"
#include "quantized_matrix33.hpp"

struct QuantizedConvCore {
  struct FlatAccessor {
    QuantizedConvCore& c;
    int& operator[](int i) {
      return c.weights[i / (9 * c.input_channels)][i / 9 % c.input_channels]
          .data[i % 9];
    }
  };

  float_point scale;

  int input_channels;
  int output_channels;
  std::array<std::array<QuantizedMatrix33, MAX_CHANNEL>, MAX_CHANNEL> weights;

  FlatAccessor flatAccessor() { return FlatAccessor{*this}; }
  // Iterator end() { return Iterator{*this, output_channels, 0, 0}; }

  QuantizedFlowData apply(int bitwidth, const QuantizedFlowData& input) const;
};
