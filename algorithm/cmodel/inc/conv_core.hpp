#pragma once

#include <array>
#include <cstdio>
#include "common.hpp"
#include "flow_data.hpp"
#include "matrix33.hpp"

struct ConvCore {
  struct ConstFlatAccessor {
    const ConvCore& c;
    const float_point& operator[](int i) const {
      return c.weights[i / (9 * c.input_channels)][i / 9 % c.input_channels]
          .data[i % 9];
    }
  };

  int input_channels;
  int output_channels;
  std::array<std::array<Matrix33, MAX_CHANNEL>, MAX_CHANNEL> weights;

  ConstFlatAccessor flatAccessor() const { return ConstFlatAccessor{*this}; }

  void loadFromFp(FILE* fp);
  const uint8_t *loadFromBytes(const uint8_t* bytes);

  QuantizedConvCore quantize(int bitwidth) const;

  FlowData apply(const FlowData& input) const;
};
