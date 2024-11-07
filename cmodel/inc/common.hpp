#pragma once

#include <cstdint>

using float_t = float;

constexpr int MAX_CHANNEL = 32;
constexpr int MAX_WIDTH = 1280;
constexpr int MAX_HEIGHT = 720;

extern "C" {

typedef struct Net Net;
Net load(const char* filename);

typedef struct ConvCore ConvCore;
void printConvCoreData(const ConvCore& core, int leading_space = 0);

void printNet(const Net& net, int leading_space = 0);

typedef struct SingleChannelFlowData SingleChannelFlowData;
void printSingleChannelFlowData(int width,
                                int height,
                                const SingleChannelFlowData& data,
                                int leading_space = 0);

typedef struct FlowData FlowData;
void printFlowData(const FlowData& data, int leading_space = 0);
}
