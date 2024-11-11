#include "common.hpp"
#include "net.hpp"

int main(int argc, char **argv) {
  Net net = load(argv[1]);
  return 0;
}