#include "common.hpp"
#include "conv_core.hpp"
#include "matrix33.hpp"
#include "res_block.hpp"
#include "net.hpp"

inline float_t bound_pad(int width,
                         int height,
                         const SingleChannelFlowData& input,
                         int r,
                         int c) {
  if (r < 0 || r >= height || c < 0 || c >= width)
    return 0;
  return input[r][c];
}

SingleChannelFlowData Matrix33::apply(
    int width,
    int height,
    const SingleChannelFlowData& input) const {
  SingleChannelFlowData output;
  for (int i = 0; i < height; i++) {
#pragma omp parallel for
    for (int j = 0; j < width; j++) {
      float_t sum = 0;
      for (int k = 0; k < 3; k++) {
        for (int l = 0; l < 3; l++) {
          sum += data[k * 3 + l] *
                 bound_pad(width, height, input, i + k - 1, j + l - 1);
        }
      }
      output[i][j] = sum;
    }
  }
  return output;
}

FlowData ConvCore::apply(const FlowData& input) const {
  FlowData flow_data;
  flow_data.width = input.width;
  flow_data.height = input.height;
  for (int oc = 0; oc < output_channels; oc++) {
    flow_data.data.emplace_back();
    SingleChannelFlowData &out_channel = flow_data.data.back();
    for (auto& row : out_channel)
      row.fill(0);
    for (int ic = 0; ic < input_channels; ic++) {
      SingleChannelFlowData channel =
          weights[oc][ic].apply(input.width, input.height, input[ic]);
      out_channel += channel;
    }
  }
  return flow_data;
}

void ReLu_inplace(FlowData& input) {
  for (auto& channel : input) {
    for (auto& row : channel) {
      for (auto& val : row) {
        val = std::max(val, (float_t)0);
      }
    }
  }
}

FlowData ResBlock::apply(bool relu_at_output, const FlowData& input) const {
  FlowData output = conv1.apply(input);
  ReLu_inplace(output);
  output = conv2.apply(output);
  if (relu_at_output)
    ReLu_inplace(output);
  return output;
}

FlowData Net::apply(const FlowData& input) const {
  FlowData output = input;
  for (int i = 0, _end = (int)blocks.size(); i < _end; ++i)
    output = blocks[i].apply(i + 1 != _end, output);
  return output;
}
