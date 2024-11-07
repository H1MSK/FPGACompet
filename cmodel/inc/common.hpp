#pragma once

#include <cstdint>

using float_point = float;

constexpr int MAX_CHANNEL = 32;
constexpr int MAX_WIDTH = 1280;
constexpr int MAX_HEIGHT = 720;

extern "C" {

typedef struct Net Net;
typedef struct ConvCore ConvCore;
typedef struct SingleChannelFlowData SingleChannelFlowData;
typedef struct FlowData FlowData;

Net load(const char* filename);

void printNet(const Net& net, int leading_space = 0);
void printConvCoreData(const ConvCore& core, int leading_space = 0);
void printSingleChannelFlowData(int width,
                                int height,
                                const SingleChannelFlowData& data,
                                int leading_space = 0);
void printFlowData(const FlowData& data, int leading_space = 0);
}
