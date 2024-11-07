#pragma once

#include <array>
#include <vector>

#include "common.hpp"

struct QuantizedSingleChannelFlowData {
  using RowArrayType = std::array<int, MAX_WIDTH>;
  using DataArrayType = std::array<RowArrayType, MAX_HEIGHT>;
  DataArrayType data;

  QuantizedSingleChannelFlowData() : data() {}

  RowArrayType& operator[](int i) { return data[(size_t)i]; }
  const RowArrayType& operator[](int i) const { return data[(size_t)i]; }

  DataArrayType::iterator begin() { return data.begin(); }
  DataArrayType::iterator end() { return data.end(); }
  DataArrayType::const_iterator cbegin() const { return data.cbegin(); }
  DataArrayType::const_iterator cend() const { return data.cend(); }
};

struct QuantizedFlowData {
  using DataArrayType = std::vector<QuantizedSingleChannelFlowData>;
  int width, height;
  int bitwidth;
  float_point scale;
  DataArrayType data;

  QuantizedSingleChannelFlowData& operator[](int i) { return data[(size_t)i]; }
  const QuantizedSingleChannelFlowData& operator[](int i) const {
    return data[(size_t)i];
  }

  DataArrayType::iterator begin() { return data.begin(); }
  DataArrayType::iterator end() { return data.end(); }
  DataArrayType::const_iterator cbegin() const { return data.cbegin(); }
  DataArrayType::const_iterator cend() const { return data.cend(); }
};
