#include "common.hpp"
#include "conv_core.hpp"
#include "matrix33.hpp"
#include "net.hpp"
#include "res_block.hpp"

SingleChannelFlowData Matrix33::apply(
    int width,
    int height,
    const SingleChannelFlowData& input) const {

  SingleChannelFlowData output;
  output[0][0] = data[4] * input[0][0] + data[5] * input[0][1] +
                 data[7] * input[1][0] + data[8] * input[1][1];
  output[0][width - 1] =
      data[3] * input[0][width - 2] + data[4] * input[0][width - 1] +
      data[6] * input[1][width - 2] + data[7] * input[1][width - 1];
  output[height - 1][0] =
      data[1] * input[height - 2][0] + data[2] * input[height - 2][1] +
      data[4] * input[height - 1][0] + data[5] * input[height - 1][1];
  output[height - 1][width - 1] = data[0] * input[height - 2][width - 2] +
                                  data[1] * input[height - 2][width - 1] +
                                  data[3] * input[height - 1][width - 2] +
                                  data[4] * input[height - 1][width - 1];

#pragma omp parallel sections
  {
#pragma omp section
    {
#pragma omp parallel for
      for (int c = 1; c < width - 1; c++) {
        output[0][c] = data[3] * input[0][c - 1] + data[4] * input[0][c] +
                       data[5] * input[0][c + 1] + data[6] * input[1][c - 1] +
                       data[7] * input[1][c] + data[8] * input[1][c + 1];
      }
    }
#pragma omp section
    {
#pragma omp parallel for
      for (int c = 1; c < width - 1; c++) {
        output[height - 1][c] = data[0] * input[height - 2][c - 1] +
                                data[1] * input[height - 2][c] +
                                data[2] * input[height - 2][c + 1] +
                                data[3] * input[height - 1][c - 1] +
                                data[4] * input[height - 1][c] +
                                data[5] * input[height - 1][c + 1];
      }
    }
#pragma omp section
    {
#pragma omp parallel for
      for (int r = 1; r < height - 1; r++) {
        output[r][0] = data[1] * input[r - 1][0] + data[2] * input[r - 1][1] +
                       data[4] * input[r][0] + data[5] * input[r][1] +
                       data[7] * input[r + 1][0] + data[8] * input[r + 1][1];
      }
    }
#pragma omp section
    {
#pragma omp parallel for
      for (int r = 1; r < height - 1; r++) {
        output[r][width - 1] =
            data[0] * input[r - 1][width - 2] +
            data[1] * input[r - 1][width - 1] + data[3] * input[r][width - 2] +
            data[4] * input[r][width - 1] + data[6] * input[r + 1][width - 2] +
            data[7] * input[r + 1][width - 1];
      }
    }
  }

  for (int r = 1, _end_i = height - 1; r < _end_i; r++) {
#pragma omp parallel for
    for (int c = 1; c < width - 1; c++) {
      float_point sum = 0;
      for (int k = 0; k < 3; k++) {
        for (int l = 0; l < 3; l++) {
          sum += data[k * 3 + l] * input[r + k - 1][c + l - 1];
        }
      }
      output[r][c] = sum;
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
    SingleChannelFlowData& out_channel = flow_data.data.back();
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
        val = std::max(val, (float_point)0);
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
