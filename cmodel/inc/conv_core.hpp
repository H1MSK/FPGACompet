#pragma once

#include <array>
#include <cstdio>
#include "common.hpp"
#include "matrix33.hpp"
#include "flow_data.hpp"

class ConvCore {
public:
  int input_channels;
  int output_channels;
  std::array<std::array<Matrix33, MAX_CHANNEL>, MAX_CHANNEL> weights;

  void loadFromFp(FILE *fp);

  FlowData apply(const FlowData& input) const;
};
