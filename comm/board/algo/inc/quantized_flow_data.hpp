#pragma once

#include <array>
#include <vector>

#include "common.hpp"

struct QuantizedSingleChannelFlowData {
  using RowArrayType = std::array<int, MAX_WIDTH>;
  using DataArrayType = std::array<RowArrayType, MAX_HEIGHT>;
  DataArrayType data;

  struct FlatAccessor {
    DataArrayType& data;
    int width;
    int& operator[](int x) {
      return data[(size_t)(x / width)][(size_t)(x % width)];
    }
  };

  QuantizedSingleChannelFlowData() : data() {}

  RowArrayType& operator[](int i) { return data[(size_t)i]; }
  const RowArrayType& operator[](int i) const { return data[(size_t)i]; }

  void loadFromFp(int width, int height, FILE* fp);

  FlatAccessor flatAccessor(int width) { return FlatAccessor{data, width}; }
  DataArrayType::iterator begin() { return data.begin(); }
  DataArrayType::iterator end() { return data.end(); }
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

  void loadFromFp(FILE* fp);

  void requantizeTo(int target_bitwidth);

  DataArrayType::iterator begin() { return data.begin(); }
  DataArrayType::iterator end() { return data.end(); }
  DataArrayType::const_iterator begin() const { return data.begin(); }
  DataArrayType::const_iterator end() const { return data.end(); }
};
