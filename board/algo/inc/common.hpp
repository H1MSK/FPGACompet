#pragma once

#include <cstdint>
#include <cstdio>

using float_point = float;

constexpr int MAX_CHANNEL = 32;
constexpr int MAX_WIDTH = 1024;
constexpr int MAX_HEIGHT = 1024;

constexpr uint32_t ID_CONV_FLOAT = 0x12345678;
constexpr uint32_t ID_CONV_QUANT = 0x9ABCDEF0;
constexpr uint32_t ID_FLOW_FLOAT = 0x87654321;
constexpr uint32_t ID_FLOW_QUANT = 0x0FEDCBA9;
constexpr uint32_t ID_MODEL = 0x23456789;

extern "C" {

typedef struct Net Net;
typedef struct ResBlock ResBlock;
typedef struct ConvCore ConvCore;
typedef struct SingleChannelFlowData SingleChannelFlowData;
typedef struct FlowData FlowData;

typedef struct QuantizedNet QuantizedNet;
typedef struct QuantizedResBlock QuantizedResBlock;
typedef struct QuantizedConvCore QuantizedConvCore;
typedef struct QuantizedSingleChannelFlowData QuantizedSingleChannelFlowData;
typedef struct QuantizedFlowData QuantizedFlowData;

Net load(const char* filename);

void printNet(const Net& net, int leading_space = 0);
void printConvCore(const ConvCore& core, int leading_space = 0);
void printQuantizedNet(const QuantizedNet& net, int leading_space = 0);
void printQuantizedConvCore(const QuantizedConvCore& core,
                            int leading_space = 0);
void printSingleChannelFlowData(int width,
                                int height,
                                const SingleChannelFlowData& data,
                                int leading_space = 0);
void printFlowData(const FlowData& data, int leading_space = 0);
void printQuantizedSingleChannelFlowData(
    int width,
    int height,
    float_point scale,
    const QuantizedSingleChannelFlowData& data,
    int leading_space);
void printQuantizedFlowData(const QuantizedFlowData& data, int leading_space);
}
