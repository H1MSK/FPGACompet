# FPGACompet.Comm

FPGA竞赛的上位机及板级软件。

## 架构介绍

硬件上使用了 Xilinx 的 ZYNQ 架构芯片，图像算法实现在 PL 端。 PS 端通过算法 IP 引出的 AXI-Lite 接口进行参数配置。算法 IP 通过 AXI 总线从 PS DDR 中读取图像进行处理，并通过同一 AXI 总线将处理后的图像写回 DDR。

PS 端通过网络与上位机进行交互，具体实现方法为：PS 端实现基于 FreeRTOS 及 LwIP 实现网络协议栈，建立 TCP 服务端等待上位机连接。上位机作为 TCP 客户端，主动连接 FPGA 的服务端，并通过简易数据交互协议与服务端进行通信，进行参数配置及图像传输。

### 简易数据交互协议

为了简化 FPGA 的处理逻辑，协议定义数据传输的字节序为小端序，并且一次有效传输的起始为上位机（下称客户端）向FPGA 硬件（下称服务端）发送16字节的数据包头，以及可选的包体。

包头的结构，以及不同数据包的包头数据如下所示。

```plaintext

位域定义：
0                 4                 8                 12                16 bytes
+-----------------+-----------------+-----------------+-----------------+---------
|   identifier    |             head data             | content length  | content...
+-----------------+-----------------+-----------------+-----------------+---------

写图像:
0                 4        6        8                 12                16   16+height*width bytes
+-----------------+--------+--------+-----------------+-----------------+---------....----+
|   0x01234567    | height |  width |    reserved     |= height * width |  image data...  | 
+-----------------+-----------------+-----------------+-----------------+---------....----+

读图像:
0                 4        6        8                 12                16 bytes
+-----------------+--------+--------+-----------------+-----------------+
|   0x76543210    | height |  width |    reserved     |       = 0       |
+-----------------+-----------------+-----------------+-----------------+

写参数:
0                 4        6        8                 12                16 bytes
+-----------------+--------+--------+-----------------+-----------------+
|   0x89ABCDEF    |     address     |      data       |       = 0       |
+-----------------+-----------------+-----------------+-----------------+

读参数:
0                 4        6        8                 12                16 bytes
+-----------------+--------+--------+-----------------+-----------------+
|   0xFEDCBA98    |     address     |       = 0       |       = 0       |
+-----------------+-----------------+-----------------+-----------------+

```

在接收到客户端发送的包体数据后，服务端会首先回复6字节的包头，表示操作是否成功。然后根据客户端发送的数据包类型，服务端选择回复不同长度的数据包体，其定义分别如下。

```plaintext

位域定义：

0        2                 6 bytes
+--------+-----------------+--------
| status | content length  | content...
+--------+-----------------+--------


写图像:
0        2                 6 bytes
+--------+-----------------+
|  "ok"  |       = 0       |
+--------+-----------------+

读图像:
0        2                 6     6+height*width bytes
+--------+-----------------+---------....----+
|  "ok"  |= width * height | image data...   |
+--------+-----------------+---------....----+

写参数:
0        2                 6 bytes
+--------+-----------------+
|  "ok"  |       = 0       |
+--------+-----------------+

读参数:
0        2                 6                10 bytes
+--------+-----------------+-----------------+
|  "ok"  |       = 4       |      data       |
+--------+-----------------+-----------------+
```

## 代码组织

- `host`: 上位机源码
- `board`: FPGA源码
  - `board/common`: 与上位机及PL端沟通的通用代码
  - `board/sim`: 仿真相关代码

## 快速开始

### 上位机配置

1. 安装python
2. 安装依赖库：`pip install -r host/requirements.txt`
3. 启动上位机：`cd host && python main.py`

### 板级仿真配置

以debian系统为例

1. 安装C语言工具链（CMake、Makefile、GCC等）：`sudo apt install build-essential cmake`
2. 进入FPGA源码目录，新建构建目录：`cd board && mkdir build && cd build`
3. 使用CMake生成Makefile：`cmake ..`
4. 编译：`make`
5. 启动：`./sim`
