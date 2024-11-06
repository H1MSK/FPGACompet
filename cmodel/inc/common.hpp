#pragma once

#include <cstdint>

using float_t = float;

constexpr int MAX_CHANNEL = 32;
constexpr int MAX_WIDTH = 1280;
constexpr int MAX_HEIGHT = 720;

extern "C" {

typedef struct Net Net;
Net load(const char* filename);

}
