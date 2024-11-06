#pragma once

#include <array>
#include <cstdio>
#include "common.hpp"
#include "flow_data.hpp"
#include "matrix33.hpp"

struct ConvCore {
  int input_channels;
  int output_channels;
  std::array<std::array<Matrix33, MAX_CHANNEL>, MAX_CHANNEL> weights;

  void loadFromFp(FILE* fp);

  FlowData apply(const FlowData& input) const;
};
