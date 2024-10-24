# FPGACompet.Comm

FPGA竞赛的上位机及板级软件。

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
