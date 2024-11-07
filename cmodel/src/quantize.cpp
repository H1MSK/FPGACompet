#include <algorithm>
#include <cassert>
#include <cmath>
#include "net.hpp"
#include "quantized_net.hpp"

static float_point quant_error, quant_error_rel;
static int num_conv_core;

QuantizedNet QuantizedNet::fromNet(const Net& net, int bitwidth) {
  QuantizedNet quantized_net;

  quant_error = 0;
  quant_error_rel = 0;
  num_conv_core = 0;

  quantized_net.bitwidth = bitwidth;
  for (auto& block : net.blocks) {
    quantized_net.blocks.push_back(
        QuantizedResBlock::fromResBlock(block, bitwidth));
  }

  printf("Total quantization error: %.5f, %.5f %%\n", quant_error,
         quant_error_rel * 100);

  return quantized_net;
}

QuantizedResBlock QuantizedResBlock::fromResBlock(const ResBlock& block,
                                                  int bitwidth) {
  QuantizedResBlock quantized_block;
  quantized_block.conv1 =
      QuantizedConvCore::fromConvCore(block.conv1, bitwidth);
  quantized_block.conv2 =
      QuantizedConvCore::fromConvCore(block.conv2, bitwidth);
  return quantized_block;
}

QuantizedConvCore QuantizedConvCore::fromConvCore(const ConvCore& core,
                                                  int bitwidth) {
  assert(bitwidth <= 32);
  float_point min = core.weights[0][0].data[0];
  float_point max = min;
#pragma omp parallel for shared(min, max)
  for (int i = 0; i < core.input_channels * core.output_channels; ++i) {
    int in_ch = i / core.output_channels;
    int out_ch = i % core.output_channels;
    float_point this_min = core.weights[in_ch][out_ch].data[0];
    float_point this_max = this_min;
    for (int k = 0; k < 9; ++k) {
      float_point v = core.weights[in_ch][out_ch].data[k];
      this_min = std::min(v, this_min);
      this_max = std::max(v, this_max);
    }
    min = std::min(min, this_min);
    max = std::max(max, this_max);
  }

  max = std::max(max, -min);
  max = std::max(max, 1.0f / (1 << (bitwidth - 1)));  // to avoid 0
  float_point unit = max / (1 << (bitwidth - 1));

  int quant_lb = -(1 << (bitwidth - 1));
  int quant_ub = (1 << (bitwidth - 1)) - 1;

  QuantizedConvCore ret;
  ret.scale = unit;
  ret.input_channels = core.input_channels;
  ret.output_channels = core.output_channels;
  float acc_error = 0;
  float acc_error_rel = 0;
  for (int i = 0; i < core.output_channels; ++i) {
    for (int j = 0; j < core.input_channels; ++j) {
      auto& w = core.weights[i][j];
      auto& qw = ret.weights[i][j];
      for (int k = 0; k < 9; ++k) {
        int v = (int)std::round(w.data[k] / unit);
        qw.data[k] = std::min(std::max(v, quant_lb), quant_ub);

        acc_error += std::abs(w.data[k] - qw.data[k] * unit);
        acc_error_rel +=
            (w.data[k] == 0)
                ? 0
                : std::abs((w.data[k] - qw.data[k] * unit) / w.data[k]);
      }
    }
  }
  quant_error += acc_error;
  quant_error_rel += acc_error_rel;

  ++num_conv_core;
  printf("Conv core #%d quantization error: %.5f, %.5f %%\n", num_conv_core,
         acc_error, acc_error_rel * 100);

  return ret;
}
