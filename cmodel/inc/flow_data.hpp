#pragma once

#include <array>
#include <vector>

#include "common.hpp"

struct SingleChannelFlowData {
  using RowArrayType = std::array<float_t, MAX_WIDTH>;
  using DataArrayType = std::array<RowArrayType, MAX_HEIGHT>;
  DataArrayType data;

  RowArrayType& operator[] (int i) { return data[i]; }
  const RowArrayType& operator[] (int i) const { return data[i]; }

  void loadFromFp(int width, int height, FILE *fp);

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

  SingleChannelFlowData& operator[] (int i) { return data[i]; }
  const SingleChannelFlowData& operator[] (int i) const { return data[i]; }

  void loadFromFp(FILE *fp);

  DataArrayType::iterator begin() { return data.begin(); }
  DataArrayType::iterator end() { return data.end(); }
};
