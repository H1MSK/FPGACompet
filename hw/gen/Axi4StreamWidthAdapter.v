// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : Axi4StreamWidthAdapter
// Git hash  : ac106a508d16e27cfe6f32162015da1ba0ee7336

`timescale 1ns/1ps 
module Axi4StreamWidthAdapter (
  input  wire          io_axis_s_valid,
  output reg           io_axis_s_ready,
  input  wire [7:0]    io_axis_s_payload_data,
  input  wire [0:0]    io_axis_s_payload_keep,
  input  wire          io_axis_s_payload_last,
  output wire          io_axis_m_valid,
  input  wire          io_axis_m_ready,
  output wire [31:0]   io_axis_m_payload_data,
  output wire [3:0]    io_axis_m_payload_keep,
  output wire          io_axis_m_payload_last,
  input  wire          clk,
  input  wire          resetn
);

  wire       [2:0]    _zz_fillLevel_next_2;
  reg        [0:0]    _zz__zz_writeBufferValid_3;
  wire       [3:0]    _zz__zz_writeBufferValid_3_1;
  reg        [7:0]    _zz__zz_writeBuffer_data;
  reg        [0:0]    _zz_writeBufferValid_28;
  reg        [0:0]    _zz__zz_writeBuffer_keep;
  reg        [1:0]    _zz__zz_writeBufferValid_6;
  wire       [3:0]    _zz__zz_writeBufferValid_6_1;
  reg        [7:0]    _zz__zz_writeBuffer_data_1;
  reg        [0:0]    _zz_writeBufferValid_29;
  reg        [0:0]    _zz__zz_writeBuffer_keep_1;
  reg        [1:0]    _zz__zz_writeBufferValid_9;
  wire       [3:0]    _zz__zz_writeBufferValid_9_1;
  reg        [7:0]    _zz__zz_writeBuffer_data_2;
  reg        [0:0]    _zz_writeBufferValid_30;
  reg        [0:0]    _zz__zz_writeBuffer_keep_2;
  reg        [1:0]    _zz__zz_writeBufferValid_12;
  wire       [3:0]    _zz__zz_writeBufferValid_12_1;
  reg        [7:0]    _zz__zz_writeBuffer_data_3;
  reg        [0:0]    _zz_writeBufferValid_31;
  reg        [0:0]    _zz__zz_writeBuffer_keep_3;
  reg        [1:0]    _zz__zz_writeBufferValid_15;
  wire       [3:0]    _zz__zz_writeBufferValid_15_1;
  reg        [7:0]    _zz__zz_writeBuffer_data_4;
  reg        [0:0]    _zz_writeBufferValid_32;
  reg        [0:0]    _zz__zz_writeBuffer_keep_4;
  reg        [1:0]    _zz__zz_writeBufferValid_18;
  wire       [3:0]    _zz__zz_writeBufferValid_18_1;
  reg        [7:0]    _zz__zz_writeBuffer_data_5;
  reg        [0:0]    _zz_writeBufferValid_33;
  reg        [0:0]    _zz__zz_writeBuffer_keep_5;
  reg        [1:0]    _zz__zz_writeBufferValid_21;
  wire       [3:0]    _zz__zz_writeBufferValid_21_1;
  reg        [7:0]    _zz__zz_writeBuffer_data_6;
  reg        [0:0]    _zz_writeBufferValid_34;
  reg        [0:0]    _zz__zz_writeBuffer_keep_6;
  reg        [1:0]    _zz__zz_writeBufferValid_24;
  wire       [3:0]    _zz__zz_writeBufferValid_24_1;
  reg        [7:0]    _zz__zz_writeBuffer_data_7;
  reg        [0:0]    _zz_writeBufferValid_35;
  reg        [0:0]    _zz__zz_writeBuffer_keep_7;
  reg        [1:0]    _zz__zz_writeBufferValid_27;
  wire       [3:0]    _zz__zz_writeBufferValid_27_1;
  reg        [7:0]    _zz__zz_writeBuffer_data_8;
  reg        [0:0]    _zz_writeBufferValid_36;
  reg        [0:0]    _zz__zz_writeBuffer_keep_8;
  reg        [7:0]    _zz__zz_readWriteBuffer_0_data;
  reg        [0:0]    _zz_readWriteBuffer_1_5;
  reg        [0:0]    _zz__zz_readWriteBuffer_0_keep;
  reg        [7:0]    _zz__zz_readWriteBuffer_0_data_1;
  reg        [0:0]    _zz_readWriteBuffer_1_6;
  reg        [0:0]    _zz__zz_readWriteBuffer_0_keep_1;
  reg        [7:0]    _zz__zz_readWriteBuffer_0_data_2;
  reg        [0:0]    _zz_readWriteBuffer_1_7;
  reg        [0:0]    _zz__zz_readWriteBuffer_0_keep_2;
  reg        [7:0]    _zz__zz_readWriteBuffer_0_data_3;
  reg        [0:0]    _zz_readWriteBuffer_1_8;
  reg        [0:0]    _zz__zz_readWriteBuffer_0_keep_3;
  reg        [7:0]    _zz__zz_readWriteBuffer_0_data_4;
  reg        [0:0]    _zz_readWriteBuffer_1_9;
  reg        [0:0]    _zz__zz_readWriteBuffer_0_keep_4;
  wire       [7:0]    _zz_canWrite;
  reg        [2:0]    fillLevel_next_2;
  reg        [2:0]    fillLevel_next_1;
  reg        [0:0]    writeBytes_preReg_1;
  reg        [63:0]   buffer_data;
  reg        [7:0]    buffer_keep;
  reg        [7:0]    _zz_buffer_keep;
  reg        [7:0]    bufferValid;
  reg                 bufferLast;
  reg                 start;
  wire                inCompact_valid;
  reg                 inCompact_ready;
  wire       [7:0]    inCompact_payload_data;
  wire       [0:0]    inCompact_payload_keep;
  wire                inCompact_payload_last;
  reg                 io_axis_s_rValid;
  reg        [7:0]    io_axis_s_rData_data;
  reg        [0:0]    io_axis_s_rData_keep;
  reg                 io_axis_s_rData_last;
  wire                when_Stream_l375;
  wire                inStage_valid;
  wire                inStage_ready;
  wire       [7:0]    inStage_payload_data;
  wire       [0:0]    inStage_payload_keep;
  wire                inStage_payload_last;
  reg                 inCompact_rValid;
  reg        [7:0]    inCompact_rData_data;
  reg        [0:0]    inCompact_rData_keep;
  reg                 inCompact_rData_last;
  wire                when_Stream_l375_1;
  wire       [0:0]    writeBytes_preReg;
  wire                inCompact_fire;
  reg        [0:0]    writeBytes;
  wire                outStream_valid;
  wire                outStream_ready;
  wire       [31:0]   outStream_payload_data;
  wire       [3:0]    outStream_payload_keep;
  wire                outStream_payload_last;
  reg        [2:0]    fillLevel;
  wire       [2:0]    fillLevel_next;
  wire                outStream_fire;
  wire                inStage_fire;
  wire                when_Axi4StreamWidthAdapter_l195;
  reg        [71:0]   _zz_writeBuffer_data;
  reg        [8:0]    writeBufferValid;
  reg        [8:0]    _zz_writeBuffer_keep;
  wire       [7:0]    _zz_writeBuffer_data_1;
  wire                _zz_writeBufferValid;
  wire                _zz_writeBuffer_keep_1;
  wire       [23:0]   _zz_writeBuffer_data_2;
  wire       [0:0]    _zz_writeBufferValid_1;
  wire       [2:0]    _zz_writeBufferValid_2;
  wire       [2:0]    _zz_writeBuffer_keep_2;
  reg        [1:0]    _zz_writeBufferValid_3;
  wire       [23:0]   _zz_writeBuffer_data_3;
  wire       [0:0]    _zz_writeBufferValid_4;
  wire       [2:0]    _zz_writeBufferValid_5;
  wire       [2:0]    _zz_writeBuffer_keep_3;
  reg        [1:0]    _zz_writeBufferValid_6;
  wire       [23:0]   _zz_writeBuffer_data_4;
  wire       [0:0]    _zz_writeBufferValid_7;
  wire       [2:0]    _zz_writeBufferValid_8;
  wire       [2:0]    _zz_writeBuffer_keep_4;
  reg        [1:0]    _zz_writeBufferValid_9;
  wire       [23:0]   _zz_writeBuffer_data_5;
  wire       [0:0]    _zz_writeBufferValid_10;
  wire       [2:0]    _zz_writeBufferValid_11;
  wire       [2:0]    _zz_writeBuffer_keep_5;
  reg        [1:0]    _zz_writeBufferValid_12;
  wire       [23:0]   _zz_writeBuffer_data_6;
  wire       [0:0]    _zz_writeBufferValid_13;
  wire       [2:0]    _zz_writeBufferValid_14;
  wire       [2:0]    _zz_writeBuffer_keep_6;
  reg        [1:0]    _zz_writeBufferValid_15;
  wire       [23:0]   _zz_writeBuffer_data_7;
  wire       [0:0]    _zz_writeBufferValid_16;
  wire       [2:0]    _zz_writeBufferValid_17;
  wire       [2:0]    _zz_writeBuffer_keep_7;
  reg        [1:0]    _zz_writeBufferValid_18;
  wire       [23:0]   _zz_writeBuffer_data_8;
  wire       [0:0]    _zz_writeBufferValid_19;
  wire       [2:0]    _zz_writeBufferValid_20;
  wire       [2:0]    _zz_writeBuffer_keep_8;
  reg        [1:0]    _zz_writeBufferValid_21;
  wire       [23:0]   _zz_writeBuffer_data_9;
  wire       [0:0]    _zz_writeBufferValid_22;
  wire       [2:0]    _zz_writeBufferValid_23;
  wire       [2:0]    _zz_writeBuffer_keep_9;
  reg        [1:0]    _zz_writeBufferValid_24;
  wire       [23:0]   _zz_writeBuffer_data_10;
  wire       [0:0]    _zz_writeBufferValid_25;
  wire       [2:0]    _zz_writeBufferValid_26;
  wire       [2:0]    _zz_writeBuffer_keep_10;
  reg        [1:0]    _zz_writeBufferValid_27;
  wire       [71:0]   writeBuffer_data;
  wire       [8:0]    writeBuffer_keep;
  wire                when_Axi4StreamWidthAdapter_l201;
  wire                when_Axi4StreamWidthAdapter_l203;
  wire                when_Axi4StreamWidthAdapter_l205;
  reg        [39:0]   _zz_readWriteBuffer_0_data;
  reg        [4:0]    readWriteBuffer_1;
  reg        [4:0]    _zz_readWriteBuffer_0_keep;
  reg        [3:0]    _zz_readWriteBuffer_1;
  reg        [3:0]    _zz_readWriteBuffer_1_1;
  reg        [3:0]    _zz_readWriteBuffer_1_2;
  reg        [3:0]    _zz_readWriteBuffer_1_3;
  reg        [3:0]    _zz_readWriteBuffer_1_4;
  wire       [39:0]   readWriteBuffer_0_data;
  wire       [4:0]    readWriteBuffer_0_keep;
  wire                when_Axi4StreamWidthAdapter_l216;
  wire                when_Axi4StreamWidthAdapter_l218;
  wire                canWrite;
  wire                canWriteWhenRead;
  wire                outStream_s2mPipe_valid;
  reg                 outStream_s2mPipe_ready;
  wire       [31:0]   outStream_s2mPipe_payload_data;
  wire       [3:0]    outStream_s2mPipe_payload_keep;
  wire                outStream_s2mPipe_payload_last;
  reg                 outStream_rValidN;
  reg        [31:0]   outStream_rData_data;
  reg        [3:0]    outStream_rData_keep;
  reg                 outStream_rData_last;
  wire                outBuffer_valid;
  wire                outBuffer_ready;
  wire       [31:0]   outBuffer_payload_data;
  wire       [3:0]    outBuffer_payload_keep;
  wire                outBuffer_payload_last;
  reg                 outStream_s2mPipe_rValid;
  reg        [31:0]   outStream_s2mPipe_rData_data;
  reg        [3:0]    outStream_s2mPipe_rData_keep;
  reg                 outStream_s2mPipe_rData_last;
  wire                when_Stream_l375_2;
  function [7:0] zz__zz_buffer_keep(input dummy);
    begin
      zz__zz_buffer_keep[0] = 1'b0;
      zz__zz_buffer_keep[1] = 1'b0;
      zz__zz_buffer_keep[2] = 1'b0;
      zz__zz_buffer_keep[3] = 1'b0;
      zz__zz_buffer_keep[4] = 1'b0;
      zz__zz_buffer_keep[5] = 1'b0;
      zz__zz_buffer_keep[6] = 1'b0;
      zz__zz_buffer_keep[7] = 1'b0;
    end
  endfunction
  wire [7:0] _zz_1;

  assign _zz_fillLevel_next_2 = {2'd0, writeBytes};
  assign _zz__zz_writeBufferValid_3_1 = {1'd0, fillLevel};
  assign _zz__zz_writeBufferValid_6_1 = {1'd0, fillLevel};
  assign _zz__zz_writeBufferValid_9_1 = {1'd0, fillLevel};
  assign _zz__zz_writeBufferValid_12_1 = {1'd0, fillLevel};
  assign _zz__zz_writeBufferValid_15_1 = {1'd0, fillLevel};
  assign _zz__zz_writeBufferValid_18_1 = {1'd0, fillLevel};
  assign _zz__zz_writeBufferValid_21_1 = {1'd0, fillLevel};
  assign _zz__zz_writeBufferValid_24_1 = {1'd0, fillLevel};
  assign _zz__zz_writeBufferValid_27_1 = {1'd0, fillLevel};
  assign _zz_canWrite = {bufferValid[0],{bufferValid[1],{bufferValid[2],{bufferValid[3],{bufferValid[4],{bufferValid[5],{bufferValid[6],bufferValid[7]}}}}}}};
  always @(*) begin
    case(_zz__zz_writeBufferValid_3_1)
      4'b0000 : _zz__zz_writeBufferValid_3 = 1'b0;
      4'b0001 : _zz__zz_writeBufferValid_3 = 1'b1;
      4'b0010 : _zz__zz_writeBufferValid_3 = 1'b1;
      4'b0011 : _zz__zz_writeBufferValid_3 = 1'b1;
      4'b0100 : _zz__zz_writeBufferValid_3 = 1'b1;
      4'b0101 : _zz__zz_writeBufferValid_3 = 1'b1;
      4'b0110 : _zz__zz_writeBufferValid_3 = 1'b1;
      4'b0111 : _zz__zz_writeBufferValid_3 = 1'b1;
      default : _zz__zz_writeBufferValid_3 = 1'b1;
    endcase
  end

  always @(*) begin
    case(_zz_writeBufferValid_3)
      2'b00 : begin
        _zz__zz_writeBuffer_data = _zz_writeBuffer_data_2[7 : 0];
        _zz_writeBufferValid_28 = _zz_writeBufferValid_2[0 : 0];
        _zz__zz_writeBuffer_keep = _zz_writeBuffer_keep_2[0 : 0];
      end
      2'b01 : begin
        _zz__zz_writeBuffer_data = _zz_writeBuffer_data_2[15 : 8];
        _zz_writeBufferValid_28 = _zz_writeBufferValid_2[1 : 1];
        _zz__zz_writeBuffer_keep = _zz_writeBuffer_keep_2[1 : 1];
      end
      default : begin
        _zz__zz_writeBuffer_data = _zz_writeBuffer_data_2[23 : 16];
        _zz_writeBufferValid_28 = _zz_writeBufferValid_2[2 : 2];
        _zz__zz_writeBuffer_keep = _zz_writeBuffer_keep_2[2 : 2];
      end
    endcase
  end

  always @(*) begin
    case(_zz__zz_writeBufferValid_6_1)
      4'b0000 : _zz__zz_writeBufferValid_6 = 2'b10;
      4'b0001 : _zz__zz_writeBufferValid_6 = 2'b00;
      4'b0010 : _zz__zz_writeBufferValid_6 = 2'b01;
      4'b0011 : _zz__zz_writeBufferValid_6 = 2'b01;
      4'b0100 : _zz__zz_writeBufferValid_6 = 2'b01;
      4'b0101 : _zz__zz_writeBufferValid_6 = 2'b01;
      4'b0110 : _zz__zz_writeBufferValid_6 = 2'b01;
      4'b0111 : _zz__zz_writeBufferValid_6 = 2'b01;
      default : _zz__zz_writeBufferValid_6 = 2'b01;
    endcase
  end

  always @(*) begin
    case(_zz_writeBufferValid_6)
      2'b00 : begin
        _zz__zz_writeBuffer_data_1 = _zz_writeBuffer_data_3[7 : 0];
        _zz_writeBufferValid_29 = _zz_writeBufferValid_5[0 : 0];
        _zz__zz_writeBuffer_keep_1 = _zz_writeBuffer_keep_3[0 : 0];
      end
      2'b01 : begin
        _zz__zz_writeBuffer_data_1 = _zz_writeBuffer_data_3[15 : 8];
        _zz_writeBufferValid_29 = _zz_writeBufferValid_5[1 : 1];
        _zz__zz_writeBuffer_keep_1 = _zz_writeBuffer_keep_3[1 : 1];
      end
      default : begin
        _zz__zz_writeBuffer_data_1 = _zz_writeBuffer_data_3[23 : 16];
        _zz_writeBufferValid_29 = _zz_writeBufferValid_5[2 : 2];
        _zz__zz_writeBuffer_keep_1 = _zz_writeBuffer_keep_3[2 : 2];
      end
    endcase
  end

  always @(*) begin
    case(_zz__zz_writeBufferValid_9_1)
      4'b0000 : _zz__zz_writeBufferValid_9 = 2'b10;
      4'b0001 : _zz__zz_writeBufferValid_9 = 2'b10;
      4'b0010 : _zz__zz_writeBufferValid_9 = 2'b00;
      4'b0011 : _zz__zz_writeBufferValid_9 = 2'b01;
      4'b0100 : _zz__zz_writeBufferValid_9 = 2'b01;
      4'b0101 : _zz__zz_writeBufferValid_9 = 2'b01;
      4'b0110 : _zz__zz_writeBufferValid_9 = 2'b01;
      4'b0111 : _zz__zz_writeBufferValid_9 = 2'b01;
      default : _zz__zz_writeBufferValid_9 = 2'b01;
    endcase
  end

  always @(*) begin
    case(_zz_writeBufferValid_9)
      2'b00 : begin
        _zz__zz_writeBuffer_data_2 = _zz_writeBuffer_data_4[7 : 0];
        _zz_writeBufferValid_30 = _zz_writeBufferValid_8[0 : 0];
        _zz__zz_writeBuffer_keep_2 = _zz_writeBuffer_keep_4[0 : 0];
      end
      2'b01 : begin
        _zz__zz_writeBuffer_data_2 = _zz_writeBuffer_data_4[15 : 8];
        _zz_writeBufferValid_30 = _zz_writeBufferValid_8[1 : 1];
        _zz__zz_writeBuffer_keep_2 = _zz_writeBuffer_keep_4[1 : 1];
      end
      default : begin
        _zz__zz_writeBuffer_data_2 = _zz_writeBuffer_data_4[23 : 16];
        _zz_writeBufferValid_30 = _zz_writeBufferValid_8[2 : 2];
        _zz__zz_writeBuffer_keep_2 = _zz_writeBuffer_keep_4[2 : 2];
      end
    endcase
  end

  always @(*) begin
    case(_zz__zz_writeBufferValid_12_1)
      4'b0000 : _zz__zz_writeBufferValid_12 = 2'b10;
      4'b0001 : _zz__zz_writeBufferValid_12 = 2'b10;
      4'b0010 : _zz__zz_writeBufferValid_12 = 2'b10;
      4'b0011 : _zz__zz_writeBufferValid_12 = 2'b00;
      4'b0100 : _zz__zz_writeBufferValid_12 = 2'b01;
      4'b0101 : _zz__zz_writeBufferValid_12 = 2'b01;
      4'b0110 : _zz__zz_writeBufferValid_12 = 2'b01;
      4'b0111 : _zz__zz_writeBufferValid_12 = 2'b01;
      default : _zz__zz_writeBufferValid_12 = 2'b01;
    endcase
  end

  always @(*) begin
    case(_zz_writeBufferValid_12)
      2'b00 : begin
        _zz__zz_writeBuffer_data_3 = _zz_writeBuffer_data_5[7 : 0];
        _zz_writeBufferValid_31 = _zz_writeBufferValid_11[0 : 0];
        _zz__zz_writeBuffer_keep_3 = _zz_writeBuffer_keep_5[0 : 0];
      end
      2'b01 : begin
        _zz__zz_writeBuffer_data_3 = _zz_writeBuffer_data_5[15 : 8];
        _zz_writeBufferValid_31 = _zz_writeBufferValid_11[1 : 1];
        _zz__zz_writeBuffer_keep_3 = _zz_writeBuffer_keep_5[1 : 1];
      end
      default : begin
        _zz__zz_writeBuffer_data_3 = _zz_writeBuffer_data_5[23 : 16];
        _zz_writeBufferValid_31 = _zz_writeBufferValid_11[2 : 2];
        _zz__zz_writeBuffer_keep_3 = _zz_writeBuffer_keep_5[2 : 2];
      end
    endcase
  end

  always @(*) begin
    case(_zz__zz_writeBufferValid_15_1)
      4'b0000 : _zz__zz_writeBufferValid_15 = 2'b10;
      4'b0001 : _zz__zz_writeBufferValid_15 = 2'b10;
      4'b0010 : _zz__zz_writeBufferValid_15 = 2'b10;
      4'b0011 : _zz__zz_writeBufferValid_15 = 2'b10;
      4'b0100 : _zz__zz_writeBufferValid_15 = 2'b00;
      4'b0101 : _zz__zz_writeBufferValid_15 = 2'b01;
      4'b0110 : _zz__zz_writeBufferValid_15 = 2'b01;
      4'b0111 : _zz__zz_writeBufferValid_15 = 2'b01;
      default : _zz__zz_writeBufferValid_15 = 2'b01;
    endcase
  end

  always @(*) begin
    case(_zz_writeBufferValid_15)
      2'b00 : begin
        _zz__zz_writeBuffer_data_4 = _zz_writeBuffer_data_6[7 : 0];
        _zz_writeBufferValid_32 = _zz_writeBufferValid_14[0 : 0];
        _zz__zz_writeBuffer_keep_4 = _zz_writeBuffer_keep_6[0 : 0];
      end
      2'b01 : begin
        _zz__zz_writeBuffer_data_4 = _zz_writeBuffer_data_6[15 : 8];
        _zz_writeBufferValid_32 = _zz_writeBufferValid_14[1 : 1];
        _zz__zz_writeBuffer_keep_4 = _zz_writeBuffer_keep_6[1 : 1];
      end
      default : begin
        _zz__zz_writeBuffer_data_4 = _zz_writeBuffer_data_6[23 : 16];
        _zz_writeBufferValid_32 = _zz_writeBufferValid_14[2 : 2];
        _zz__zz_writeBuffer_keep_4 = _zz_writeBuffer_keep_6[2 : 2];
      end
    endcase
  end

  always @(*) begin
    case(_zz__zz_writeBufferValid_18_1)
      4'b0000 : _zz__zz_writeBufferValid_18 = 2'b10;
      4'b0001 : _zz__zz_writeBufferValid_18 = 2'b10;
      4'b0010 : _zz__zz_writeBufferValid_18 = 2'b10;
      4'b0011 : _zz__zz_writeBufferValid_18 = 2'b10;
      4'b0100 : _zz__zz_writeBufferValid_18 = 2'b10;
      4'b0101 : _zz__zz_writeBufferValid_18 = 2'b00;
      4'b0110 : _zz__zz_writeBufferValid_18 = 2'b01;
      4'b0111 : _zz__zz_writeBufferValid_18 = 2'b01;
      default : _zz__zz_writeBufferValid_18 = 2'b01;
    endcase
  end

  always @(*) begin
    case(_zz_writeBufferValid_18)
      2'b00 : begin
        _zz__zz_writeBuffer_data_5 = _zz_writeBuffer_data_7[7 : 0];
        _zz_writeBufferValid_33 = _zz_writeBufferValid_17[0 : 0];
        _zz__zz_writeBuffer_keep_5 = _zz_writeBuffer_keep_7[0 : 0];
      end
      2'b01 : begin
        _zz__zz_writeBuffer_data_5 = _zz_writeBuffer_data_7[15 : 8];
        _zz_writeBufferValid_33 = _zz_writeBufferValid_17[1 : 1];
        _zz__zz_writeBuffer_keep_5 = _zz_writeBuffer_keep_7[1 : 1];
      end
      default : begin
        _zz__zz_writeBuffer_data_5 = _zz_writeBuffer_data_7[23 : 16];
        _zz_writeBufferValid_33 = _zz_writeBufferValid_17[2 : 2];
        _zz__zz_writeBuffer_keep_5 = _zz_writeBuffer_keep_7[2 : 2];
      end
    endcase
  end

  always @(*) begin
    case(_zz__zz_writeBufferValid_21_1)
      4'b0000 : _zz__zz_writeBufferValid_21 = 2'b10;
      4'b0001 : _zz__zz_writeBufferValid_21 = 2'b10;
      4'b0010 : _zz__zz_writeBufferValid_21 = 2'b10;
      4'b0011 : _zz__zz_writeBufferValid_21 = 2'b10;
      4'b0100 : _zz__zz_writeBufferValid_21 = 2'b10;
      4'b0101 : _zz__zz_writeBufferValid_21 = 2'b10;
      4'b0110 : _zz__zz_writeBufferValid_21 = 2'b00;
      4'b0111 : _zz__zz_writeBufferValid_21 = 2'b01;
      default : _zz__zz_writeBufferValid_21 = 2'b01;
    endcase
  end

  always @(*) begin
    case(_zz_writeBufferValid_21)
      2'b00 : begin
        _zz__zz_writeBuffer_data_6 = _zz_writeBuffer_data_8[7 : 0];
        _zz_writeBufferValid_34 = _zz_writeBufferValid_20[0 : 0];
        _zz__zz_writeBuffer_keep_6 = _zz_writeBuffer_keep_8[0 : 0];
      end
      2'b01 : begin
        _zz__zz_writeBuffer_data_6 = _zz_writeBuffer_data_8[15 : 8];
        _zz_writeBufferValid_34 = _zz_writeBufferValid_20[1 : 1];
        _zz__zz_writeBuffer_keep_6 = _zz_writeBuffer_keep_8[1 : 1];
      end
      default : begin
        _zz__zz_writeBuffer_data_6 = _zz_writeBuffer_data_8[23 : 16];
        _zz_writeBufferValid_34 = _zz_writeBufferValid_20[2 : 2];
        _zz__zz_writeBuffer_keep_6 = _zz_writeBuffer_keep_8[2 : 2];
      end
    endcase
  end

  always @(*) begin
    case(_zz__zz_writeBufferValid_24_1)
      4'b0000 : _zz__zz_writeBufferValid_24 = 2'b10;
      4'b0001 : _zz__zz_writeBufferValid_24 = 2'b10;
      4'b0010 : _zz__zz_writeBufferValid_24 = 2'b10;
      4'b0011 : _zz__zz_writeBufferValid_24 = 2'b10;
      4'b0100 : _zz__zz_writeBufferValid_24 = 2'b10;
      4'b0101 : _zz__zz_writeBufferValid_24 = 2'b10;
      4'b0110 : _zz__zz_writeBufferValid_24 = 2'b10;
      4'b0111 : _zz__zz_writeBufferValid_24 = 2'b00;
      default : _zz__zz_writeBufferValid_24 = 2'b01;
    endcase
  end

  always @(*) begin
    case(_zz_writeBufferValid_24)
      2'b00 : begin
        _zz__zz_writeBuffer_data_7 = _zz_writeBuffer_data_9[7 : 0];
        _zz_writeBufferValid_35 = _zz_writeBufferValid_23[0 : 0];
        _zz__zz_writeBuffer_keep_7 = _zz_writeBuffer_keep_9[0 : 0];
      end
      2'b01 : begin
        _zz__zz_writeBuffer_data_7 = _zz_writeBuffer_data_9[15 : 8];
        _zz_writeBufferValid_35 = _zz_writeBufferValid_23[1 : 1];
        _zz__zz_writeBuffer_keep_7 = _zz_writeBuffer_keep_9[1 : 1];
      end
      default : begin
        _zz__zz_writeBuffer_data_7 = _zz_writeBuffer_data_9[23 : 16];
        _zz_writeBufferValid_35 = _zz_writeBufferValid_23[2 : 2];
        _zz__zz_writeBuffer_keep_7 = _zz_writeBuffer_keep_9[2 : 2];
      end
    endcase
  end

  always @(*) begin
    case(_zz__zz_writeBufferValid_27_1)
      4'b0000 : _zz__zz_writeBufferValid_27 = 2'b10;
      4'b0001 : _zz__zz_writeBufferValid_27 = 2'b10;
      4'b0010 : _zz__zz_writeBufferValid_27 = 2'b10;
      4'b0011 : _zz__zz_writeBufferValid_27 = 2'b10;
      4'b0100 : _zz__zz_writeBufferValid_27 = 2'b10;
      4'b0101 : _zz__zz_writeBufferValid_27 = 2'b10;
      4'b0110 : _zz__zz_writeBufferValid_27 = 2'b10;
      4'b0111 : _zz__zz_writeBufferValid_27 = 2'b10;
      default : _zz__zz_writeBufferValid_27 = 2'b00;
    endcase
  end

  always @(*) begin
    case(_zz_writeBufferValid_27)
      2'b00 : begin
        _zz__zz_writeBuffer_data_8 = _zz_writeBuffer_data_10[7 : 0];
        _zz_writeBufferValid_36 = _zz_writeBufferValid_26[0 : 0];
        _zz__zz_writeBuffer_keep_8 = _zz_writeBuffer_keep_10[0 : 0];
      end
      2'b01 : begin
        _zz__zz_writeBuffer_data_8 = _zz_writeBuffer_data_10[15 : 8];
        _zz_writeBufferValid_36 = _zz_writeBufferValid_26[1 : 1];
        _zz__zz_writeBuffer_keep_8 = _zz_writeBuffer_keep_10[1 : 1];
      end
      default : begin
        _zz__zz_writeBuffer_data_8 = _zz_writeBuffer_data_10[23 : 16];
        _zz_writeBufferValid_36 = _zz_writeBufferValid_26[2 : 2];
        _zz__zz_writeBuffer_keep_8 = _zz_writeBuffer_keep_10[2 : 2];
      end
    endcase
  end

  always @(*) begin
    case(_zz_readWriteBuffer_1)
      4'b0000 : begin
        _zz__zz_readWriteBuffer_0_data = writeBuffer_data[7 : 0];
        _zz_readWriteBuffer_1_5 = writeBufferValid[0 : 0];
        _zz__zz_readWriteBuffer_0_keep = writeBuffer_keep[0 : 0];
      end
      4'b0001 : begin
        _zz__zz_readWriteBuffer_0_data = writeBuffer_data[15 : 8];
        _zz_readWriteBuffer_1_5 = writeBufferValid[1 : 1];
        _zz__zz_readWriteBuffer_0_keep = writeBuffer_keep[1 : 1];
      end
      4'b0010 : begin
        _zz__zz_readWriteBuffer_0_data = writeBuffer_data[23 : 16];
        _zz_readWriteBuffer_1_5 = writeBufferValid[2 : 2];
        _zz__zz_readWriteBuffer_0_keep = writeBuffer_keep[2 : 2];
      end
      4'b0011 : begin
        _zz__zz_readWriteBuffer_0_data = writeBuffer_data[31 : 24];
        _zz_readWriteBuffer_1_5 = writeBufferValid[3 : 3];
        _zz__zz_readWriteBuffer_0_keep = writeBuffer_keep[3 : 3];
      end
      4'b0100 : begin
        _zz__zz_readWriteBuffer_0_data = writeBuffer_data[39 : 32];
        _zz_readWriteBuffer_1_5 = writeBufferValid[4 : 4];
        _zz__zz_readWriteBuffer_0_keep = writeBuffer_keep[4 : 4];
      end
      4'b0101 : begin
        _zz__zz_readWriteBuffer_0_data = writeBuffer_data[47 : 40];
        _zz_readWriteBuffer_1_5 = writeBufferValid[5 : 5];
        _zz__zz_readWriteBuffer_0_keep = writeBuffer_keep[5 : 5];
      end
      4'b0110 : begin
        _zz__zz_readWriteBuffer_0_data = writeBuffer_data[55 : 48];
        _zz_readWriteBuffer_1_5 = writeBufferValid[6 : 6];
        _zz__zz_readWriteBuffer_0_keep = writeBuffer_keep[6 : 6];
      end
      4'b0111 : begin
        _zz__zz_readWriteBuffer_0_data = writeBuffer_data[63 : 56];
        _zz_readWriteBuffer_1_5 = writeBufferValid[7 : 7];
        _zz__zz_readWriteBuffer_0_keep = writeBuffer_keep[7 : 7];
      end
      default : begin
        _zz__zz_readWriteBuffer_0_data = writeBuffer_data[71 : 64];
        _zz_readWriteBuffer_1_5 = writeBufferValid[8 : 8];
        _zz__zz_readWriteBuffer_0_keep = writeBuffer_keep[8 : 8];
      end
    endcase
  end

  always @(*) begin
    case(_zz_readWriteBuffer_1_1)
      4'b0000 : begin
        _zz__zz_readWriteBuffer_0_data_1 = writeBuffer_data[7 : 0];
        _zz_readWriteBuffer_1_6 = writeBufferValid[0 : 0];
        _zz__zz_readWriteBuffer_0_keep_1 = writeBuffer_keep[0 : 0];
      end
      4'b0001 : begin
        _zz__zz_readWriteBuffer_0_data_1 = writeBuffer_data[15 : 8];
        _zz_readWriteBuffer_1_6 = writeBufferValid[1 : 1];
        _zz__zz_readWriteBuffer_0_keep_1 = writeBuffer_keep[1 : 1];
      end
      4'b0010 : begin
        _zz__zz_readWriteBuffer_0_data_1 = writeBuffer_data[23 : 16];
        _zz_readWriteBuffer_1_6 = writeBufferValid[2 : 2];
        _zz__zz_readWriteBuffer_0_keep_1 = writeBuffer_keep[2 : 2];
      end
      4'b0011 : begin
        _zz__zz_readWriteBuffer_0_data_1 = writeBuffer_data[31 : 24];
        _zz_readWriteBuffer_1_6 = writeBufferValid[3 : 3];
        _zz__zz_readWriteBuffer_0_keep_1 = writeBuffer_keep[3 : 3];
      end
      4'b0100 : begin
        _zz__zz_readWriteBuffer_0_data_1 = writeBuffer_data[39 : 32];
        _zz_readWriteBuffer_1_6 = writeBufferValid[4 : 4];
        _zz__zz_readWriteBuffer_0_keep_1 = writeBuffer_keep[4 : 4];
      end
      4'b0101 : begin
        _zz__zz_readWriteBuffer_0_data_1 = writeBuffer_data[47 : 40];
        _zz_readWriteBuffer_1_6 = writeBufferValid[5 : 5];
        _zz__zz_readWriteBuffer_0_keep_1 = writeBuffer_keep[5 : 5];
      end
      4'b0110 : begin
        _zz__zz_readWriteBuffer_0_data_1 = writeBuffer_data[55 : 48];
        _zz_readWriteBuffer_1_6 = writeBufferValid[6 : 6];
        _zz__zz_readWriteBuffer_0_keep_1 = writeBuffer_keep[6 : 6];
      end
      4'b0111 : begin
        _zz__zz_readWriteBuffer_0_data_1 = writeBuffer_data[63 : 56];
        _zz_readWriteBuffer_1_6 = writeBufferValid[7 : 7];
        _zz__zz_readWriteBuffer_0_keep_1 = writeBuffer_keep[7 : 7];
      end
      default : begin
        _zz__zz_readWriteBuffer_0_data_1 = writeBuffer_data[71 : 64];
        _zz_readWriteBuffer_1_6 = writeBufferValid[8 : 8];
        _zz__zz_readWriteBuffer_0_keep_1 = writeBuffer_keep[8 : 8];
      end
    endcase
  end

  always @(*) begin
    case(_zz_readWriteBuffer_1_2)
      4'b0000 : begin
        _zz__zz_readWriteBuffer_0_data_2 = writeBuffer_data[7 : 0];
        _zz_readWriteBuffer_1_7 = writeBufferValid[0 : 0];
        _zz__zz_readWriteBuffer_0_keep_2 = writeBuffer_keep[0 : 0];
      end
      4'b0001 : begin
        _zz__zz_readWriteBuffer_0_data_2 = writeBuffer_data[15 : 8];
        _zz_readWriteBuffer_1_7 = writeBufferValid[1 : 1];
        _zz__zz_readWriteBuffer_0_keep_2 = writeBuffer_keep[1 : 1];
      end
      4'b0010 : begin
        _zz__zz_readWriteBuffer_0_data_2 = writeBuffer_data[23 : 16];
        _zz_readWriteBuffer_1_7 = writeBufferValid[2 : 2];
        _zz__zz_readWriteBuffer_0_keep_2 = writeBuffer_keep[2 : 2];
      end
      4'b0011 : begin
        _zz__zz_readWriteBuffer_0_data_2 = writeBuffer_data[31 : 24];
        _zz_readWriteBuffer_1_7 = writeBufferValid[3 : 3];
        _zz__zz_readWriteBuffer_0_keep_2 = writeBuffer_keep[3 : 3];
      end
      4'b0100 : begin
        _zz__zz_readWriteBuffer_0_data_2 = writeBuffer_data[39 : 32];
        _zz_readWriteBuffer_1_7 = writeBufferValid[4 : 4];
        _zz__zz_readWriteBuffer_0_keep_2 = writeBuffer_keep[4 : 4];
      end
      4'b0101 : begin
        _zz__zz_readWriteBuffer_0_data_2 = writeBuffer_data[47 : 40];
        _zz_readWriteBuffer_1_7 = writeBufferValid[5 : 5];
        _zz__zz_readWriteBuffer_0_keep_2 = writeBuffer_keep[5 : 5];
      end
      4'b0110 : begin
        _zz__zz_readWriteBuffer_0_data_2 = writeBuffer_data[55 : 48];
        _zz_readWriteBuffer_1_7 = writeBufferValid[6 : 6];
        _zz__zz_readWriteBuffer_0_keep_2 = writeBuffer_keep[6 : 6];
      end
      4'b0111 : begin
        _zz__zz_readWriteBuffer_0_data_2 = writeBuffer_data[63 : 56];
        _zz_readWriteBuffer_1_7 = writeBufferValid[7 : 7];
        _zz__zz_readWriteBuffer_0_keep_2 = writeBuffer_keep[7 : 7];
      end
      default : begin
        _zz__zz_readWriteBuffer_0_data_2 = writeBuffer_data[71 : 64];
        _zz_readWriteBuffer_1_7 = writeBufferValid[8 : 8];
        _zz__zz_readWriteBuffer_0_keep_2 = writeBuffer_keep[8 : 8];
      end
    endcase
  end

  always @(*) begin
    case(_zz_readWriteBuffer_1_3)
      4'b0000 : begin
        _zz__zz_readWriteBuffer_0_data_3 = writeBuffer_data[7 : 0];
        _zz_readWriteBuffer_1_8 = writeBufferValid[0 : 0];
        _zz__zz_readWriteBuffer_0_keep_3 = writeBuffer_keep[0 : 0];
      end
      4'b0001 : begin
        _zz__zz_readWriteBuffer_0_data_3 = writeBuffer_data[15 : 8];
        _zz_readWriteBuffer_1_8 = writeBufferValid[1 : 1];
        _zz__zz_readWriteBuffer_0_keep_3 = writeBuffer_keep[1 : 1];
      end
      4'b0010 : begin
        _zz__zz_readWriteBuffer_0_data_3 = writeBuffer_data[23 : 16];
        _zz_readWriteBuffer_1_8 = writeBufferValid[2 : 2];
        _zz__zz_readWriteBuffer_0_keep_3 = writeBuffer_keep[2 : 2];
      end
      4'b0011 : begin
        _zz__zz_readWriteBuffer_0_data_3 = writeBuffer_data[31 : 24];
        _zz_readWriteBuffer_1_8 = writeBufferValid[3 : 3];
        _zz__zz_readWriteBuffer_0_keep_3 = writeBuffer_keep[3 : 3];
      end
      4'b0100 : begin
        _zz__zz_readWriteBuffer_0_data_3 = writeBuffer_data[39 : 32];
        _zz_readWriteBuffer_1_8 = writeBufferValid[4 : 4];
        _zz__zz_readWriteBuffer_0_keep_3 = writeBuffer_keep[4 : 4];
      end
      4'b0101 : begin
        _zz__zz_readWriteBuffer_0_data_3 = writeBuffer_data[47 : 40];
        _zz_readWriteBuffer_1_8 = writeBufferValid[5 : 5];
        _zz__zz_readWriteBuffer_0_keep_3 = writeBuffer_keep[5 : 5];
      end
      4'b0110 : begin
        _zz__zz_readWriteBuffer_0_data_3 = writeBuffer_data[55 : 48];
        _zz_readWriteBuffer_1_8 = writeBufferValid[6 : 6];
        _zz__zz_readWriteBuffer_0_keep_3 = writeBuffer_keep[6 : 6];
      end
      4'b0111 : begin
        _zz__zz_readWriteBuffer_0_data_3 = writeBuffer_data[63 : 56];
        _zz_readWriteBuffer_1_8 = writeBufferValid[7 : 7];
        _zz__zz_readWriteBuffer_0_keep_3 = writeBuffer_keep[7 : 7];
      end
      default : begin
        _zz__zz_readWriteBuffer_0_data_3 = writeBuffer_data[71 : 64];
        _zz_readWriteBuffer_1_8 = writeBufferValid[8 : 8];
        _zz__zz_readWriteBuffer_0_keep_3 = writeBuffer_keep[8 : 8];
      end
    endcase
  end

  always @(*) begin
    case(_zz_readWriteBuffer_1_4)
      4'b0000 : begin
        _zz__zz_readWriteBuffer_0_data_4 = writeBuffer_data[7 : 0];
        _zz_readWriteBuffer_1_9 = writeBufferValid[0 : 0];
        _zz__zz_readWriteBuffer_0_keep_4 = writeBuffer_keep[0 : 0];
      end
      4'b0001 : begin
        _zz__zz_readWriteBuffer_0_data_4 = writeBuffer_data[15 : 8];
        _zz_readWriteBuffer_1_9 = writeBufferValid[1 : 1];
        _zz__zz_readWriteBuffer_0_keep_4 = writeBuffer_keep[1 : 1];
      end
      4'b0010 : begin
        _zz__zz_readWriteBuffer_0_data_4 = writeBuffer_data[23 : 16];
        _zz_readWriteBuffer_1_9 = writeBufferValid[2 : 2];
        _zz__zz_readWriteBuffer_0_keep_4 = writeBuffer_keep[2 : 2];
      end
      4'b0011 : begin
        _zz__zz_readWriteBuffer_0_data_4 = writeBuffer_data[31 : 24];
        _zz_readWriteBuffer_1_9 = writeBufferValid[3 : 3];
        _zz__zz_readWriteBuffer_0_keep_4 = writeBuffer_keep[3 : 3];
      end
      4'b0100 : begin
        _zz__zz_readWriteBuffer_0_data_4 = writeBuffer_data[39 : 32];
        _zz_readWriteBuffer_1_9 = writeBufferValid[4 : 4];
        _zz__zz_readWriteBuffer_0_keep_4 = writeBuffer_keep[4 : 4];
      end
      4'b0101 : begin
        _zz__zz_readWriteBuffer_0_data_4 = writeBuffer_data[47 : 40];
        _zz_readWriteBuffer_1_9 = writeBufferValid[5 : 5];
        _zz__zz_readWriteBuffer_0_keep_4 = writeBuffer_keep[5 : 5];
      end
      4'b0110 : begin
        _zz__zz_readWriteBuffer_0_data_4 = writeBuffer_data[55 : 48];
        _zz_readWriteBuffer_1_9 = writeBufferValid[6 : 6];
        _zz__zz_readWriteBuffer_0_keep_4 = writeBuffer_keep[6 : 6];
      end
      4'b0111 : begin
        _zz__zz_readWriteBuffer_0_data_4 = writeBuffer_data[63 : 56];
        _zz_readWriteBuffer_1_9 = writeBufferValid[7 : 7];
        _zz__zz_readWriteBuffer_0_keep_4 = writeBuffer_keep[7 : 7];
      end
      default : begin
        _zz__zz_readWriteBuffer_0_data_4 = writeBuffer_data[71 : 64];
        _zz_readWriteBuffer_1_9 = writeBufferValid[8 : 8];
        _zz__zz_readWriteBuffer_0_keep_4 = writeBuffer_keep[8 : 8];
      end
    endcase
  end

  always @(*) begin
    fillLevel_next_2 = fillLevel_next_1;
    if(inStage_fire) begin
      fillLevel_next_2 = (fillLevel_next_1 + _zz_fillLevel_next_2);
    end
    if(when_Axi4StreamWidthAdapter_l195) begin
      fillLevel_next_2 = 3'b000;
    end
  end

  always @(*) begin
    fillLevel_next_1 = fillLevel_next;
    if(outStream_fire) begin
      fillLevel_next_1 = (fillLevel - 3'b100);
    end
  end

  always @(*) begin
    writeBytes_preReg_1 = writeBytes_preReg;
    if(inCompact_valid) begin
      writeBytes_preReg_1 = 1'b1;
    end
  end

  assign _zz_1 = zz__zz_buffer_keep(1'b0);
  always @(*) _zz_buffer_keep = _zz_1;
  always @(*) begin
    io_axis_s_ready = inCompact_ready;
    if(when_Stream_l375) begin
      io_axis_s_ready = 1'b1;
    end
  end

  assign when_Stream_l375 = (! inCompact_valid);
  assign inCompact_valid = io_axis_s_rValid;
  assign inCompact_payload_data = io_axis_s_rData_data;
  assign inCompact_payload_keep = io_axis_s_rData_keep;
  assign inCompact_payload_last = io_axis_s_rData_last;
  always @(*) begin
    inCompact_ready = inStage_ready;
    if(when_Stream_l375_1) begin
      inCompact_ready = 1'b1;
    end
  end

  assign when_Stream_l375_1 = (! inStage_valid);
  assign inStage_valid = inCompact_rValid;
  assign inStage_payload_data = inCompact_rData_data;
  assign inStage_payload_keep = inCompact_rData_keep;
  assign inStage_payload_last = inCompact_rData_last;
  assign writeBytes_preReg = 1'b0;
  assign inCompact_fire = (inCompact_valid && inCompact_ready);
  assign outStream_valid = (bufferValid[3] || bufferLast);
  assign outStream_payload_data = buffer_data[31 : 0];
  assign outStream_payload_keep = buffer_keep[3 : 0];
  assign outStream_payload_last = (bufferLast && (! bufferValid[4]));
  assign fillLevel_next = fillLevel;
  assign outStream_fire = (outStream_valid && outStream_ready);
  assign inStage_fire = (inStage_valid && inStage_ready);
  assign when_Axi4StreamWidthAdapter_l195 = (outStream_payload_last && outStream_fire);
  assign _zz_writeBuffer_data_1 = 8'h0;
  assign _zz_writeBufferValid = 1'b0;
  assign _zz_writeBuffer_keep_1 = 1'b0;
  assign _zz_writeBuffer_data_2 = {{_zz_writeBuffer_data_1,buffer_data[7 : 0]},inStage_payload_data};
  assign _zz_writeBufferValid_1[0] = 1'b1;
  assign _zz_writeBufferValid_2 = {{_zz_writeBufferValid,bufferValid[0 : 0]},_zz_writeBufferValid_1};
  assign _zz_writeBuffer_keep_2 = {{_zz_writeBuffer_keep_1,buffer_keep[0 : 0]},inStage_payload_keep};
  always @(*) begin
    if(inStage_fire) begin
      _zz_writeBufferValid_3 = {1'd0, _zz__zz_writeBufferValid_3};
    end else begin
      _zz_writeBufferValid_3 = 2'b01;
    end
  end

  always @(*) begin
    _zz_writeBuffer_data[7 : 0] = _zz__zz_writeBuffer_data;
    _zz_writeBuffer_data[15 : 8] = _zz__zz_writeBuffer_data_1;
    _zz_writeBuffer_data[23 : 16] = _zz__zz_writeBuffer_data_2;
    _zz_writeBuffer_data[31 : 24] = _zz__zz_writeBuffer_data_3;
    _zz_writeBuffer_data[39 : 32] = _zz__zz_writeBuffer_data_4;
    _zz_writeBuffer_data[47 : 40] = _zz__zz_writeBuffer_data_5;
    _zz_writeBuffer_data[55 : 48] = _zz__zz_writeBuffer_data_6;
    _zz_writeBuffer_data[63 : 56] = _zz__zz_writeBuffer_data_7;
    _zz_writeBuffer_data[71 : 64] = _zz__zz_writeBuffer_data_8;
  end

  always @(*) begin
    writeBufferValid[0 : 0] = _zz_writeBufferValid_28;
    writeBufferValid[1 : 1] = _zz_writeBufferValid_29;
    writeBufferValid[2 : 2] = _zz_writeBufferValid_30;
    writeBufferValid[3 : 3] = _zz_writeBufferValid_31;
    writeBufferValid[4 : 4] = _zz_writeBufferValid_32;
    writeBufferValid[5 : 5] = _zz_writeBufferValid_33;
    writeBufferValid[6 : 6] = _zz_writeBufferValid_34;
    writeBufferValid[7 : 7] = _zz_writeBufferValid_35;
    writeBufferValid[8 : 8] = _zz_writeBufferValid_36;
  end

  always @(*) begin
    _zz_writeBuffer_keep[0 : 0] = _zz__zz_writeBuffer_keep;
    _zz_writeBuffer_keep[1 : 1] = _zz__zz_writeBuffer_keep_1;
    _zz_writeBuffer_keep[2 : 2] = _zz__zz_writeBuffer_keep_2;
    _zz_writeBuffer_keep[3 : 3] = _zz__zz_writeBuffer_keep_3;
    _zz_writeBuffer_keep[4 : 4] = _zz__zz_writeBuffer_keep_4;
    _zz_writeBuffer_keep[5 : 5] = _zz__zz_writeBuffer_keep_5;
    _zz_writeBuffer_keep[6 : 6] = _zz__zz_writeBuffer_keep_6;
    _zz_writeBuffer_keep[7 : 7] = _zz__zz_writeBuffer_keep_7;
    _zz_writeBuffer_keep[8 : 8] = _zz__zz_writeBuffer_keep_8;
  end

  assign _zz_writeBuffer_data_3 = {{_zz_writeBuffer_data_1,buffer_data[15 : 8]},inStage_payload_data};
  assign _zz_writeBufferValid_4[0] = 1'b1;
  assign _zz_writeBufferValid_5 = {{_zz_writeBufferValid,bufferValid[1 : 1]},_zz_writeBufferValid_4};
  assign _zz_writeBuffer_keep_3 = {{_zz_writeBuffer_keep_1,buffer_keep[1 : 1]},inStage_payload_keep};
  always @(*) begin
    if(inStage_fire) begin
      _zz_writeBufferValid_6 = _zz__zz_writeBufferValid_6;
    end else begin
      _zz_writeBufferValid_6 = 2'b01;
    end
  end

  assign _zz_writeBuffer_data_4 = {{_zz_writeBuffer_data_1,buffer_data[23 : 16]},inStage_payload_data};
  assign _zz_writeBufferValid_7[0] = 1'b1;
  assign _zz_writeBufferValid_8 = {{_zz_writeBufferValid,bufferValid[2 : 2]},_zz_writeBufferValid_7};
  assign _zz_writeBuffer_keep_4 = {{_zz_writeBuffer_keep_1,buffer_keep[2 : 2]},inStage_payload_keep};
  always @(*) begin
    if(inStage_fire) begin
      _zz_writeBufferValid_9 = _zz__zz_writeBufferValid_9;
    end else begin
      _zz_writeBufferValid_9 = 2'b01;
    end
  end

  assign _zz_writeBuffer_data_5 = {{_zz_writeBuffer_data_1,buffer_data[31 : 24]},inStage_payload_data};
  assign _zz_writeBufferValid_10[0] = 1'b1;
  assign _zz_writeBufferValid_11 = {{_zz_writeBufferValid,bufferValid[3 : 3]},_zz_writeBufferValid_10};
  assign _zz_writeBuffer_keep_5 = {{_zz_writeBuffer_keep_1,buffer_keep[3 : 3]},inStage_payload_keep};
  always @(*) begin
    if(inStage_fire) begin
      _zz_writeBufferValid_12 = _zz__zz_writeBufferValid_12;
    end else begin
      _zz_writeBufferValid_12 = 2'b01;
    end
  end

  assign _zz_writeBuffer_data_6 = {{_zz_writeBuffer_data_1,buffer_data[39 : 32]},inStage_payload_data};
  assign _zz_writeBufferValid_13[0] = 1'b1;
  assign _zz_writeBufferValid_14 = {{_zz_writeBufferValid,bufferValid[4 : 4]},_zz_writeBufferValid_13};
  assign _zz_writeBuffer_keep_6 = {{_zz_writeBuffer_keep_1,buffer_keep[4 : 4]},inStage_payload_keep};
  always @(*) begin
    if(inStage_fire) begin
      _zz_writeBufferValid_15 = _zz__zz_writeBufferValid_15;
    end else begin
      _zz_writeBufferValid_15 = 2'b01;
    end
  end

  assign _zz_writeBuffer_data_7 = {{_zz_writeBuffer_data_1,buffer_data[47 : 40]},inStage_payload_data};
  assign _zz_writeBufferValid_16[0] = 1'b1;
  assign _zz_writeBufferValid_17 = {{_zz_writeBufferValid,bufferValid[5 : 5]},_zz_writeBufferValid_16};
  assign _zz_writeBuffer_keep_7 = {{_zz_writeBuffer_keep_1,buffer_keep[5 : 5]},inStage_payload_keep};
  always @(*) begin
    if(inStage_fire) begin
      _zz_writeBufferValid_18 = _zz__zz_writeBufferValid_18;
    end else begin
      _zz_writeBufferValid_18 = 2'b01;
    end
  end

  assign _zz_writeBuffer_data_8 = {{_zz_writeBuffer_data_1,buffer_data[55 : 48]},inStage_payload_data};
  assign _zz_writeBufferValid_19[0] = 1'b1;
  assign _zz_writeBufferValid_20 = {{_zz_writeBufferValid,bufferValid[6 : 6]},_zz_writeBufferValid_19};
  assign _zz_writeBuffer_keep_8 = {{_zz_writeBuffer_keep_1,buffer_keep[6 : 6]},inStage_payload_keep};
  always @(*) begin
    if(inStage_fire) begin
      _zz_writeBufferValid_21 = _zz__zz_writeBufferValid_21;
    end else begin
      _zz_writeBufferValid_21 = 2'b01;
    end
  end

  assign _zz_writeBuffer_data_9 = {{_zz_writeBuffer_data_1,buffer_data[63 : 56]},inStage_payload_data};
  assign _zz_writeBufferValid_22[0] = 1'b1;
  assign _zz_writeBufferValid_23 = {{_zz_writeBufferValid,bufferValid[7 : 7]},_zz_writeBufferValid_22};
  assign _zz_writeBuffer_keep_9 = {{_zz_writeBuffer_keep_1,buffer_keep[7 : 7]},inStage_payload_keep};
  always @(*) begin
    if(inStage_fire) begin
      _zz_writeBufferValid_24 = _zz__zz_writeBufferValid_24;
    end else begin
      _zz_writeBufferValid_24 = 2'b01;
    end
  end

  assign _zz_writeBuffer_data_10 = {{_zz_writeBuffer_data_1,_zz_writeBuffer_data_1},inStage_payload_data};
  assign _zz_writeBufferValid_25[0] = 1'b1;
  assign _zz_writeBufferValid_26 = {{_zz_writeBufferValid,_zz_writeBufferValid},_zz_writeBufferValid_25};
  assign _zz_writeBuffer_keep_10 = {{_zz_writeBuffer_keep_1,_zz_writeBuffer_keep_1},inStage_payload_keep};
  always @(*) begin
    if(inStage_fire) begin
      _zz_writeBufferValid_27 = _zz__zz_writeBufferValid_27;
    end else begin
      _zz_writeBufferValid_27 = 2'b01;
    end
  end

  assign writeBuffer_data = _zz_writeBuffer_data;
  assign writeBuffer_keep = _zz_writeBuffer_keep;
  assign when_Axi4StreamWidthAdapter_l201 = (inStage_payload_last && inStage_fire);
  assign when_Axi4StreamWidthAdapter_l203 = (start && inStage_fire);
  assign when_Axi4StreamWidthAdapter_l205 = (outStream_payload_last && outStream_fire);
  always @(*) begin
    if(outStream_fire) begin
      _zz_readWriteBuffer_1 = 4'b0100;
    end else begin
      _zz_readWriteBuffer_1 = 4'b0000;
    end
  end

  always @(*) begin
    _zz_readWriteBuffer_0_data[7 : 0] = _zz__zz_readWriteBuffer_0_data;
    _zz_readWriteBuffer_0_data[15 : 8] = _zz__zz_readWriteBuffer_0_data_1;
    _zz_readWriteBuffer_0_data[23 : 16] = _zz__zz_readWriteBuffer_0_data_2;
    _zz_readWriteBuffer_0_data[31 : 24] = _zz__zz_readWriteBuffer_0_data_3;
    _zz_readWriteBuffer_0_data[39 : 32] = _zz__zz_readWriteBuffer_0_data_4;
  end

  always @(*) begin
    readWriteBuffer_1[0 : 0] = _zz_readWriteBuffer_1_5;
    readWriteBuffer_1[1 : 1] = _zz_readWriteBuffer_1_6;
    readWriteBuffer_1[2 : 2] = _zz_readWriteBuffer_1_7;
    readWriteBuffer_1[3 : 3] = _zz_readWriteBuffer_1_8;
    readWriteBuffer_1[4 : 4] = _zz_readWriteBuffer_1_9;
  end

  always @(*) begin
    _zz_readWriteBuffer_0_keep[0 : 0] = _zz__zz_readWriteBuffer_0_keep;
    _zz_readWriteBuffer_0_keep[1 : 1] = _zz__zz_readWriteBuffer_0_keep_1;
    _zz_readWriteBuffer_0_keep[2 : 2] = _zz__zz_readWriteBuffer_0_keep_2;
    _zz_readWriteBuffer_0_keep[3 : 3] = _zz__zz_readWriteBuffer_0_keep_3;
    _zz_readWriteBuffer_0_keep[4 : 4] = _zz__zz_readWriteBuffer_0_keep_4;
  end

  always @(*) begin
    if(outStream_fire) begin
      _zz_readWriteBuffer_1_1 = 4'b0101;
    end else begin
      _zz_readWriteBuffer_1_1 = 4'b0001;
    end
  end

  always @(*) begin
    if(outStream_fire) begin
      _zz_readWriteBuffer_1_2 = 4'b0110;
    end else begin
      _zz_readWriteBuffer_1_2 = 4'b0010;
    end
  end

  always @(*) begin
    if(outStream_fire) begin
      _zz_readWriteBuffer_1_3 = 4'b0111;
    end else begin
      _zz_readWriteBuffer_1_3 = 4'b0011;
    end
  end

  always @(*) begin
    if(outStream_fire) begin
      _zz_readWriteBuffer_1_4 = 4'b1000;
    end else begin
      _zz_readWriteBuffer_1_4 = 4'b0100;
    end
  end

  assign readWriteBuffer_0_data = _zz_readWriteBuffer_0_data;
  assign readWriteBuffer_0_keep = _zz_readWriteBuffer_0_keep;
  assign when_Axi4StreamWidthAdapter_l216 = (outStream_payload_last && outStream_fire);
  assign when_Axi4StreamWidthAdapter_l218 = (inStage_fire || outStream_fire);
  assign canWrite = (! _zz_canWrite[writeBytes]);
  assign canWriteWhenRead = 1'b1;
  assign inStage_ready = ((! bufferLast) && (canWrite || (canWriteWhenRead && outStream_fire)));
  assign outStream_ready = outStream_rValidN;
  assign outStream_s2mPipe_valid = (outStream_valid || (! outStream_rValidN));
  assign outStream_s2mPipe_payload_data = (outStream_rValidN ? outStream_payload_data : outStream_rData_data);
  assign outStream_s2mPipe_payload_keep = (outStream_rValidN ? outStream_payload_keep : outStream_rData_keep);
  assign outStream_s2mPipe_payload_last = (outStream_rValidN ? outStream_payload_last : outStream_rData_last);
  always @(*) begin
    outStream_s2mPipe_ready = outBuffer_ready;
    if(when_Stream_l375_2) begin
      outStream_s2mPipe_ready = 1'b1;
    end
  end

  assign when_Stream_l375_2 = (! outBuffer_valid);
  assign outBuffer_valid = outStream_s2mPipe_rValid;
  assign outBuffer_payload_data = outStream_s2mPipe_rData_data;
  assign outBuffer_payload_keep = outStream_s2mPipe_rData_keep;
  assign outBuffer_payload_last = outStream_s2mPipe_rData_last;
  assign io_axis_m_valid = outBuffer_valid;
  assign outBuffer_ready = io_axis_m_ready;
  assign io_axis_m_payload_data = outBuffer_payload_data;
  assign io_axis_m_payload_keep = outBuffer_payload_keep;
  assign io_axis_m_payload_last = outBuffer_payload_last;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      buffer_keep <= _zz_buffer_keep;
      bufferValid <= 8'h0;
      bufferLast <= 1'b0;
      start <= 1'b1;
      io_axis_s_rValid <= 1'b0;
      inCompact_rValid <= 1'b0;
      fillLevel <= 3'b000;
      outStream_rValidN <= 1'b1;
      outStream_s2mPipe_rValid <= 1'b0;
    end else begin
      if(io_axis_s_ready) begin
        io_axis_s_rValid <= io_axis_s_valid;
      end
      if(inCompact_ready) begin
        inCompact_rValid <= inCompact_valid;
      end
      fillLevel <= fillLevel_next_2;
      if(when_Axi4StreamWidthAdapter_l201) begin
        bufferLast <= 1'b1;
      end
      if(when_Axi4StreamWidthAdapter_l203) begin
        start <= 1'b0;
      end
      if(when_Axi4StreamWidthAdapter_l205) begin
        start <= 1'b1;
      end
      if(when_Axi4StreamWidthAdapter_l216) begin
        bufferLast <= 1'b0;
      end
      if(when_Axi4StreamWidthAdapter_l218) begin
        buffer_keep <= {3'd0, readWriteBuffer_0_keep};
        bufferValid <= {3'd0, readWriteBuffer_1};
      end
      if(outStream_valid) begin
        outStream_rValidN <= 1'b0;
      end
      if(outStream_s2mPipe_ready) begin
        outStream_rValidN <= 1'b1;
      end
      if(outStream_s2mPipe_ready) begin
        outStream_s2mPipe_rValid <= outStream_s2mPipe_valid;
      end
    end
  end

  always @(posedge clk) begin
    if(io_axis_s_ready) begin
      io_axis_s_rData_data <= io_axis_s_payload_data;
      io_axis_s_rData_keep <= io_axis_s_payload_keep;
      io_axis_s_rData_last <= io_axis_s_payload_last;
    end
    if(inCompact_ready) begin
      inCompact_rData_data <= inCompact_payload_data;
      inCompact_rData_keep <= inCompact_payload_keep;
      inCompact_rData_last <= inCompact_payload_last;
    end
    if(inCompact_fire) begin
      writeBytes <= writeBytes_preReg_1;
    end
    if(when_Axi4StreamWidthAdapter_l218) begin
      buffer_data <= {24'd0, readWriteBuffer_0_data};
    end
    if(outStream_ready) begin
      outStream_rData_data <= outStream_payload_data;
      outStream_rData_keep <= outStream_payload_keep;
      outStream_rData_last <= outStream_payload_last;
    end
    if(outStream_s2mPipe_ready) begin
      outStream_s2mPipe_rData_data <= outStream_s2mPipe_payload_data;
      outStream_s2mPipe_rData_keep <= outStream_s2mPipe_payload_keep;
      outStream_s2mPipe_rData_last <= outStream_s2mPipe_payload_last;
    end
  end


endmodule
