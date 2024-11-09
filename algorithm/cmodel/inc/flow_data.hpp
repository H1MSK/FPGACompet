#pragma once

#include <array>
#include <vector>

#include "common.hpp"

struct SingleChannelFlowData {
  using RowArrayType = std::array<float_point, MAX_WIDTH>;
  using DataArrayType = std::array<RowArrayType, MAX_HEIGHT>;
  DataArrayType data;

  SingleChannelFlowData() : data() {}

  RowArrayType& operator[] (int i) { return data[(size_t)i]; }
  const RowArrayType& operator[] (int i) const { return data[(size_t)i]; }

  void loadFromFp(int width, int height, FILE *fp);
  QuantizedSingleChannelFlowData quantize(int bitwidth) const;

  DataArrayType::iterator begin() { return data.begin(); }
  DataArrayType::iterator end() { return data.end(); }

  SingleChannelFlowData& operator+=(const SingleChannelFlowData& other) {
    for (int i = 0; i < MAX_HEIGHT; i++) {
      for (int j = 0; j < MAX_WIDTH; j++) {
        data[i][j] += other[i][j];
      }
    }
    return *this;
  }
};

struct FlowData {
  using DataArrayType = std::vector<SingleChannelFlowData>;
  int width, height;
  DataArrayType data;

  FlowData() : width(0), height(0), data() {}

  SingleChannelFlowData& operator[] (int i) { return data[(size_t)i]; }
  const SingleChannelFlowData& operator[] (int i) const { return data[(size_t)i]; }

  void loadFromFp(FILE *fp);
  QuantizedFlowData quantize(int bitwidth) const;

  DataArrayType::iterator begin() { return data.begin(); }
  DataArrayType::iterator end() { return data.end(); }
  DataArrayType::const_iterator begin() const { return data.begin(); }
  DataArrayType::const_iterator end() const { return data.end(); }
};
