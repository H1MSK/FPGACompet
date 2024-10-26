#include <assert.h>
#include <stdbool.h>
#include "../common/pal.h"
#include "FreeRTOS.h"
#include "task.h"
#include "xaxidma.h"
#include "xil_io.h"
#include "xparameters.h"

XAxiDma AxiDma;

void IP_init() {
  // from xaxidma_example_simple_poll.c
  XAxiDma_Config* CfgPtr;
  int Status;

#ifndef SDT
  u32 DeviceId = XPAR_AXIDMA_0_DEVICE_ID;
  CfgPtr = XAxiDma_LookupConfig(DeviceId);
  if (!CfgPtr) {
    xil_printf("No config found for %d\r\n", DeviceId);
    return;
  }
#else
  UINTPTR BaseAddress = XPAR_AXIDMA_0_BASEADDR;
  CfgPtr = XAxiDma_LookupConfig(BaseAddress);
  if (!CfgPtr) {
    xil_printf("No config found for %d\r\n", BaseAddress);
    return XST_FAILURE;
  }
#endif

  Status = XAxiDma_CfgInitialize(&AxiDma, CfgPtr);
  if (Status != XST_SUCCESS) {
    xil_printf("Initialization failed %d\r\n", Status);
    return;
  }

  if (XAxiDma_HasSg(&AxiDma)) {
    xil_printf("Device configured as SG mode \r\n");
    return;
  }

  /* Disable interrupts, we use polling mode
   */
  XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DEVICE_TO_DMA);
  XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DMA_TO_DEVICE);
}

inline static uint32_t min(uint32_t a, uint32_t b) {
  return a < b ? a : b;
}

void thread_data_io(bool to_device,
                    uint8_t* data,
                    volatile uint32_t* len,
                    volatile bool* finish) {
  static const char lut_s[2][5] = {"from", "to"};
  static const uint8_t lut_dir[2] = {XAXIDMA_DEVICE_TO_DMA,
                                     XAXIDMA_DMA_TO_DEVICE};
  static uint32_t* lut_max_len_ptr[2] = {&AxiDma.RxBdRing->MaxTransferLen,
                                         &AxiDma.TxBdRing.MaxTransferLen};
  uint32_t opt_len = *len;  // to make use of register
  uint8_t* ptr = data;
  const char* s = lut_s[to_device];
  uint8_t dir = lut_dir[to_device];
  uint32_t max_packet_len = *lut_max_len_ptr[to_device];
  while (opt_len > 0) {
    uint32_t this_len = min(max_packet_len, opt_len);

    Xil_DCacheFlushRange((UINTPTR)ptr, this_len);
    int Status = XAxiDma_SimpleTransfer(&AxiDma, (UINTPTR)ptr, this_len, dir);
    if (Status != XST_SUCCESS) {
      xil_printf(
          "XAxiDma_SimpleTransfer %s device failed with %d, "
          "%d bytes left\r\n",
          s, Status, opt_len);
      *finish = true;
      vTaskDelete(NULL);
      return;
    }
    while (XAxiDma_Busy(&AxiDma, dir))
      taskYIELD();
    *len -= this_len;
    opt_len -= this_len;
    ptr += this_len;
  }
  *finish = true;
  vTaskDelete(NULL);
}

typedef struct {
  bool to_device;
  uint8_t* data;
  volatile uint32_t len;
  volatile bool finish;
} DataIoThreadParamPack;

void TaskEntry(void* param) {
  DataIoThreadParamPack* pack = param;
  thread_data_io(pack->to_device, pack->data, &pack->len, &pack->finish);
}

#define THREAD_STACKSIZE 1024
#define DEFAULT_THREAD_PRIO 2

void IP_process(uint16_t width,
                uint16_t height,
                const uint8_t* in,
                uint8_t* out) {
  uint32_t total_len = width * (uint32_t)height;
  DataIoThreadParamPack in_param = {.to_device = true,
                                    .data = (uint8_t*)in,
                                    .len = total_len,
                                    .finish = false};
  DataIoThreadParamPack out_param = {
      .to_device = false, .data = out, .len = total_len, .finish = false};
  xTaskHandle in_thread, out_thread;

  BaseType_t status;
  status = xTaskCreate(TaskEntry, "IpDmaIn", THREAD_STACKSIZE, &in_param,
                       DEFAULT_THREAD_PRIO, &in_thread);
  if (status != pdPASS) {
    xil_printf("xTaskCreate IpDmaIn failed with %d\r\n", status);
    return;
  }
  status = xTaskCreate(TaskEntry, "IpDmaOut", THREAD_STACKSIZE, &out_param,
                       DEFAULT_THREAD_PRIO, &out_thread);
  if (status != pdPASS) {
    xil_printf("xTaskCreate IpDmaIn failed with %d\r\n", status);
    return;
  }
  while (!out_param.finish || !in_param.finish)
    taskYIELD();

  if (in_param.len != 0 || out_param.len != 0) {
    xil_printf(
        "Transfer incomplete, want %u bytes, sent %u, received %u bytes\r\n",
        total_len, total_len - in_param.len, total_len - out_param.len);
    return;
  } else {
    xil_printf("Transfer complete\r\n");
  }
}

void IP_set(uint32_t addr, uint32_t val) {
  UINTPTR actual_addr = addr + XPAR_AXILITEREGS_0_BASEADDR;
  assert(XPAR_AXILITEREGS_0_BASEADDR <= actual_addr &&
         XPAR_AXILITEREGS_0_HIGHADDR >= actual_addr);
  Xil_Out32(actual_addr, val);

  // When client requests to run, start the dma
  if (addr == 0 && val == 1) IP_process(1024, 1024, in_img, out_img);
}

uint32_t IP_get(uint32_t addr) {
  UINTPTR actual_addr = addr + XPAR_AXILITEREGS_0_BASEADDR;
  assert(XPAR_AXILITEREGS_0_BASEADDR <= actual_addr &&
         XPAR_AXILITEREGS_0_HIGHADDR >= actual_addr);
  uint32_t dat = Xil_In32(actual_addr);
  return dat;
}
