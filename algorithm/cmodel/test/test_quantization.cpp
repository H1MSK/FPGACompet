#include <cassert>
#include <chrono>
#include "flow_data.hpp"
#include "net.hpp"
#include "quantized_flow_data.hpp"
#include "quantized_net.hpp"

Net net;
QuantizedNet quant_net;
FlowData input, output, expected;
QuantizedFlowData quant_input, quant_output;

int main() {
  net = load("model.bin");
  printf("Net:\n");
  printNet(net);
  quant_net = net.quantize(13);
  printf("Quantized Net:\n");
  printQuantizedNet(quant_net);

  FILE* fp = fopen("input.bin", "rb");
  assert(fp != NULL);
  input.loadFromFp(fp);
  fclose(fp);

  fp = fopen("input_quant.bin", "rb");
  assert(fp != NULL);
  quant_input.loadFromFp(fp);
  fclose(fp);

  fp = fopen("output.bin", "rb");
  assert(fp != NULL);
  expected.loadFromFp(fp);
  fclose(fp);

  auto start_time = std::chrono::high_resolution_clock::now();
  output = net.apply(input);
  auto end_time = std::chrono::high_resolution_clock::now();
  printf(
      "Floating model took %f ms\n",
      std::chrono::duration<double, std::milli>(end_time - start_time).count());

  assert(output.data.size() == expected.data.size());
  assert(output.width == expected.width && output.height == expected.height);

  for (int i = 0, _end = (int)output.data.size(); i < _end; i++) {
    for (int r = 0; r < output.height; r++) {
      for (int c = 0; c < output.width; c++) {
        if (abs(output[i][r][c] - expected[i][r][c]) > 0.0001) {
          printf("Mismatch at %d,%d,%d: %f != %f\n", i, r, c, output[i][r][c],
                 expected[i][r][c]);
          return 1;
        }
      }
    }
  }

  printf("Floating model test passed!\n");

  start_time = std::chrono::high_resolution_clock::now();
  quant_output = quant_net.apply(quant_input);
  end_time = std::chrono::high_resolution_clock::now();
  printf(
      "Quantized model took %f ms\n",
      std::chrono::duration<double, std::milli>(end_time - start_time).count());

  assert(output.data.size() == quant_output.data.size());
  assert(output.width == quant_output.width &&
         output.height == quant_output.height);
  assert(quant_output.bitwidth == 8);

  float_point max_error = 0;
  for (int i = 0, _end = (int)output.data.size(); i < _end; i++) {
    for (int r = 0; r < output.height; r++) {
      for (int c = 0; c < output.width; c++) {
        auto this_error =
            abs(output[i][r][c] - quant_output[i][r][c] * quant_output.scale);
        max_error = std::max(max_error, this_error);
        // if (this_error > 0.05) {
        //   printf("Mismatch at %d,%d,%d: %f != %d(%f)\n", i, r, c,
        //          output[i][r][c], quant_output[i][r][c],
        //          quant_output[i][r][c] * quant_output.scale);
        //   return 1;
        // }
      }
    }
  }

  printf("Quantized model test max error = %f\n", max_error);

  return 0;
}
