#pragma once

#include <cstdio>
#include "common.hpp"
#include "quantized_conv_core.hpp"
#include "quantized_flow_data.hpp"

struct QuantizedResBlock {
  QuantizedConvCore conv1, conv2;

  QuantizedFlowData apply(bool relu_at_output,
                          int bitwidth,
                          const QuantizedFlowData& input) const;
};
