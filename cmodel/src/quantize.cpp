#include <algorithm>
#include <cassert>
#include <cmath>
#include <stdexcept>
#include "net.hpp"
#include "quantized_net.hpp"

static float_point quant_error, quant_error_rel;
static int num_conv_core;

QuantizedNet Net::quantize(int bitwidth) const {
  QuantizedNet quantized_net;

  quant_error = 0;
  quant_error_rel = 0;
  num_conv_core = 0;

  quantized_net.bitwidth = bitwidth;
  for (auto& block : blocks) {
    quantized_net.blocks.push_back(block.quantize(bitwidth));
  }

  printf("Total quantization error: %.5f, %.5f %%\n", quant_error,
         quant_error_rel * 100);

  return quantized_net;
}

QuantizedResBlock ResBlock::quantize(int bitwidth) const {
  QuantizedResBlock quantized_block;
  quantized_block.conv1 = conv1.quantize(bitwidth);
  quantized_block.conv2 = conv2.quantize(bitwidth);
  return quantized_block;
}

template <typename Accessor, typename T>
void getMinMax(Accessor begin, int len, T& min, T& max) {
  T this_min = begin[0];
  T this_max = begin[0];
#pragma omp parallel for reduction(min : this_min) reduction(max : this_max)
  for (int i = 1; i < len; i++) {
    T val = begin[i];
    this_min = std::min(this_min, val);
    this_max = std::max(this_max, val);
  }
  min = this_min;
  max = this_max;
}

template <typename Accessor1, typename Accessor2>
void quantizeRange(Accessor1 src,
                   Accessor2 dst,
                   int len,
                   float_point unit,
                   int lb,
                   int ub,
                   float_point& error,
                   float_point& error_rel) {
  float_point this_error = 0, this_error_rel = 0;
#pragma omp parallel for reduction(+ : this_error, this_error_rel)
  for (int i = 0; i < len; i++) {
    auto val = src[i];
    int rounded = (int)std::round((float_point)val / unit);
    int quanted = std::min(std::max(rounded, lb), ub);
    dst[i] = quanted;
    this_error += std::abs(val - quanted * unit);
    this_error_rel += std::abs((float_point)val - quanted * unit) /
                      std::max(std::abs((float_point)val), float_point(1e-6f));
  }
  error += this_error;
  error_rel += this_error_rel;
}

QuantizedConvCore ConvCore::quantize(int bitwidth) const {
  assert(bitwidth <= 32);
  float_point min;
  float_point max;

  getMinMax(flatAccessor(), input_channels * output_channels * 9, min, max);

  max = std::max(max, -min);
  max = std::max(max, 1.0f / (1 << (bitwidth - 1)));  // to avoid 0
  float_point unit = max / (1 << (bitwidth - 1));

  int quant_lb = -(1 << (bitwidth - 1));
  int quant_ub = (1 << (bitwidth - 1)) - 1;

  QuantizedConvCore ret;
  ret.scale = unit;
  ret.input_channels = input_channels;
  ret.output_channels = output_channels;
  float acc_error = 0;
  float acc_error_rel = 0;
  quantizeRange(flatAccessor(), ret.flatAccessor(),
                9 * input_channels * output_channels, unit, quant_lb, quant_ub,
                acc_error, acc_error_rel);
  quant_error += acc_error;
  quant_error_rel += acc_error_rel;

  ++num_conv_core;
  printf("Conv core #%d quantization error: %.5f, %.5f %%\n", num_conv_core,
         acc_error, acc_error_rel * 100);

  return ret;
}

void QuantizedFlowData::requantizeTo(int target_bitwidth) {
  int min, max;
  getMinMax(data[0].flatAccessor(width), width * height, min, max);
  for (int i = 1, _end = (int)data.size(); i < _end; ++i) {
    int this_min, this_max;
    getMinMax(data[i].flatAccessor(width), width * height, this_min, this_max);
    min = std::min(min, this_min);
    max = std::max(max, this_max);
  }
  max = std::max(max, -min);
  int requant_lb = -(1 << (target_bitwidth - 1));
  int requant_ub = (1 << (target_bitwidth - 1)) - 1;
  scale = (scale * max) / requant_ub;
  float_point error = 0, error_rel = 0;
  for (auto& channel : data) {
    quantizeRange(channel.flatAccessor(width), channel.flatAccessor(width),
                  width * height, (float_point)max / requant_ub, requant_lb,
                  requant_ub, error, error_rel);
  }
  error /= max;
  bitwidth = target_bitwidth;
  // printf("Requantize error: %.5f %.5f%%\n", error, error_rel * 100);
}
