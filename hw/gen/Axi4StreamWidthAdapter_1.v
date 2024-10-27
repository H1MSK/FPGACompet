// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : Axi4StreamWidthAdapter_1
// Git hash  : ac0494d18a5b48ded8fc83c7b055311a95923fb8

`timescale 1ns/1ps 
module Axi4StreamWidthAdapter_1 (
  input  wire          io_axis_s_valid,
  output reg           io_axis_s_ready,
  input  wire [31:0]   io_axis_s_payload_data,
  input  wire [3:0]    io_axis_s_payload_keep,
  input  wire          io_axis_s_payload_last,
  output wire          io_axis_m_valid,
  input  wire          io_axis_m_ready,
  output wire [7:0]    io_axis_m_payload_data,
  output wire [0:0]    io_axis_m_payload_keep,
  output wire          io_axis_m_payload_last,
  input  wire          clk,
  input  wire          reset
);

  reg        [2:0]    _zz__zz_writeBufferValid_3;
  wire       [3:0]    _zz__zz_writeBufferValid_3_1;
  reg        [7:0]    _zz__zz_writeBuffer_data;
  reg        [0:0]    _zz_writeBufferValid_28;
  reg        [0:0]    _zz__zz_writeBuffer_keep;
  reg        [2:0]    _zz__zz_writeBufferValid_6;
  wire       [3:0]    _zz__zz_writeBufferValid_6_1;
  reg        [7:0]    _zz__zz_writeBuffer_data_1;
  reg        [0:0]    _zz_writeBufferValid_29;
  reg        [0:0]    _zz__zz_writeBuffer_keep_1;
  reg        [2:0]    _zz__zz_writeBufferValid_9;
  wire       [3:0]    _zz__zz_writeBufferValid_9_1;
  reg        [7:0]    _zz__zz_writeBuffer_data_2;
  reg        [0:0]    _zz_writeBufferValid_30;
  reg        [0:0]    _zz__zz_writeBuffer_keep_2;
  reg        [2:0]    _zz__zz_writeBufferValid_12;
  wire       [3:0]    _zz__zz_writeBufferValid_12_1;
  reg        [7:0]    _zz__zz_writeBuffer_data_3;
  reg        [0:0]    _zz_writeBufferValid_31;
  reg        [0:0]    _zz__zz_writeBuffer_keep_3;
  reg        [2:0]    _zz__zz_writeBufferValid_15;
  wire       [3:0]    _zz__zz_writeBufferValid_15_1;
  reg        [7:0]    _zz__zz_writeBuffer_data_4;
  reg        [0:0]    _zz_writeBufferValid_32;
  reg        [0:0]    _zz__zz_writeBuffer_keep_4;
  reg        [2:0]    _zz__zz_writeBufferValid_18;
  wire       [3:0]    _zz__zz_writeBufferValid_18_1;
  reg        [7:0]    _zz__zz_writeBuffer_data_5;
  reg        [0:0]    _zz_writeBufferValid_33;
  reg        [0:0]    _zz__zz_writeBuffer_keep_5;
  reg        [2:0]    _zz__zz_writeBufferValid_21;
  wire       [3:0]    _zz__zz_writeBufferValid_21_1;
  reg        [7:0]    _zz__zz_writeBuffer_data_6;
  reg        [0:0]    _zz_writeBufferValid_34;
  reg        [0:0]    _zz__zz_writeBuffer_keep_6;
  reg        [2:0]    _zz__zz_writeBufferValid_24;
  wire       [3:0]    _zz__zz_writeBufferValid_24_1;
  reg        [7:0]    _zz__zz_writeBuffer_data_7;
  reg        [0:0]    _zz_writeBufferValid_35;
  reg        [0:0]    _zz__zz_writeBuffer_keep_7;
  reg        [2:0]    _zz__zz_writeBufferValid_27;
  wire       [3:0]    _zz__zz_writeBufferValid_27_1;
  reg        [7:0]    _zz__zz_writeBuffer_data_8;
  reg        [0:0]    _zz_writeBufferValid_36;
  reg        [0:0]    _zz__zz_writeBuffer_keep_8;
  reg        [7:0]    _zz__zz_readWriteBuffer_0_data;
  reg        [0:0]    _zz_readWriteBuffer_1_8;
  reg        [0:0]    _zz__zz_readWriteBuffer_0_keep;
  reg        [7:0]    _zz__zz_readWriteBuffer_0_data_1;
  reg        [0:0]    _zz_readWriteBuffer_1_9;
  reg        [0:0]    _zz__zz_readWriteBuffer_0_keep_1;
  reg        [7:0]    _zz__zz_readWriteBuffer_0_data_2;
  reg        [0:0]    _zz_readWriteBuffer_1_10;
  reg        [0:0]    _zz__zz_readWriteBuffer_0_keep_2;
  reg        [7:0]    _zz__zz_readWriteBuffer_0_data_3;
  reg        [0:0]    _zz_readWriteBuffer_1_11;
  reg        [0:0]    _zz__zz_readWriteBuffer_0_keep_3;
  reg        [7:0]    _zz__zz_readWriteBuffer_0_data_4;
  reg        [0:0]    _zz_readWriteBuffer_1_12;
  reg        [0:0]    _zz__zz_readWriteBuffer_0_keep_4;
  reg        [7:0]    _zz__zz_readWriteBuffer_0_data_5;
  reg        [0:0]    _zz_readWriteBuffer_1_13;
  reg        [0:0]    _zz__zz_readWriteBuffer_0_keep_5;
  reg        [7:0]    _zz__zz_readWriteBuffer_0_data_6;
  reg        [0:0]    _zz_readWriteBuffer_1_14;
  reg        [0:0]    _zz__zz_readWriteBuffer_0_keep_6;
  reg        [7:0]    _zz__zz_readWriteBuffer_0_data_7;
  reg        [0:0]    _zz_readWriteBuffer_1_15;
  reg        [0:0]    _zz__zz_readWriteBuffer_0_keep_7;
  wire       [7:0]    _zz_canWrite;
  reg        [2:0]    fillLevel_next_2;
  reg        [2:0]    fillLevel_next_1;
  reg        [2:0]    writeBytes_preReg_1;
  reg        [63:0]   buffer_data;
  reg        [7:0]    buffer_keep;
  reg        [7:0]    _zz_buffer_keep;
  reg        [7:0]    bufferValid;
  reg                 bufferLast;
  reg                 start;
  wire                inCompact_valid;
  reg                 inCompact_ready;
  wire       [31:0]   inCompact_payload_data;
  wire       [3:0]    inCompact_payload_keep;
  wire                inCompact_payload_last;
  reg                 io_axis_s_rValid;
  reg        [31:0]   io_axis_s_rData_data;
  reg        [3:0]    io_axis_s_rData_keep;
  reg                 io_axis_s_rData_last;
  wire                when_Stream_l375;
  wire                inStage_valid;
  wire                inStage_ready;
  wire       [31:0]   inStage_payload_data;
  wire       [3:0]    inStage_payload_keep;
  wire                inStage_payload_last;
  reg                 inCompact_rValid;
  reg        [31:0]   inCompact_rData_data;
  reg        [3:0]    inCompact_rData_keep;
  reg                 inCompact_rData_last;
  wire                when_Stream_l375_1;
  wire       [2:0]    writeBytes_preReg;
  wire                inCompact_fire;
  reg        [2:0]    writeBytes;
  wire                outStream_valid;
  wire                outStream_ready;
  wire       [7:0]    outStream_payload_data;
  wire       [0:0]    outStream_payload_keep;
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
  wire       [47:0]   _zz_writeBuffer_data_2;
  reg        [3:0]    _zz_writeBufferValid_1;
  wire       [5:0]    _zz_writeBufferValid_2;
  wire       [5:0]    _zz_writeBuffer_keep_2;
  reg        [2:0]    _zz_writeBufferValid_3;
  wire       [47:0]   _zz_writeBuffer_data_3;
  reg        [3:0]    _zz_writeBufferValid_4;
  wire       [5:0]    _zz_writeBufferValid_5;
  wire       [5:0]    _zz_writeBuffer_keep_3;
  reg        [2:0]    _zz_writeBufferValid_6;
  wire       [47:0]   _zz_writeBuffer_data_4;
  reg        [3:0]    _zz_writeBufferValid_7;
  wire       [5:0]    _zz_writeBufferValid_8;
  wire       [5:0]    _zz_writeBuffer_keep_4;
  reg        [2:0]    _zz_writeBufferValid_9;
  wire       [47:0]   _zz_writeBuffer_data_5;
  reg        [3:0]    _zz_writeBufferValid_10;
  wire       [5:0]    _zz_writeBufferValid_11;
  wire       [5:0]    _zz_writeBuffer_keep_5;
  reg        [2:0]    _zz_writeBufferValid_12;
  wire       [47:0]   _zz_writeBuffer_data_6;
  reg        [3:0]    _zz_writeBufferValid_13;
  wire       [5:0]    _zz_writeBufferValid_14;
  wire       [5:0]    _zz_writeBuffer_keep_6;
  reg        [2:0]    _zz_writeBufferValid_15;
  wire       [47:0]   _zz_writeBuffer_data_7;
  reg        [3:0]    _zz_writeBufferValid_16;
  wire       [5:0]    _zz_writeBufferValid_17;
  wire       [5:0]    _zz_writeBuffer_keep_7;
  reg        [2:0]    _zz_writeBufferValid_18;
  wire       [47:0]   _zz_writeBuffer_data_8;
  reg        [3:0]    _zz_writeBufferValid_19;
  wire       [5:0]    _zz_writeBufferValid_20;
  wire       [5:0]    _zz_writeBuffer_keep_8;
  reg        [2:0]    _zz_writeBufferValid_21;
  wire       [47:0]   _zz_writeBuffer_data_9;
  reg        [3:0]    _zz_writeBufferValid_22;
  wire       [5:0]    _zz_writeBufferValid_23;
  wire       [5:0]    _zz_writeBuffer_keep_9;
  reg        [2:0]    _zz_writeBufferValid_24;
  wire       [47:0]   _zz_writeBuffer_data_10;
  reg        [3:0]    _zz_writeBufferValid_25;
  wire       [5:0]    _zz_writeBufferValid_26;
  wire       [5:0]    _zz_writeBuffer_keep_10;
  reg        [2:0]    _zz_writeBufferValid_27;
  wire       [71:0]   writeBuffer_data;
  wire       [8:0]    writeBuffer_keep;
  wire                when_Axi4StreamWidthAdapter_l201;
  wire                when_Axi4StreamWidthAdapter_l203;
  wire                when_Axi4StreamWidthAdapter_l205;
  reg        [63:0]   _zz_readWriteBuffer_0_data;
  reg        [7:0]    readWriteBuffer_1;
  reg        [7:0]    _zz_readWriteBuffer_0_keep;
  reg        [3:0]    _zz_readWriteBuffer_1;
  reg        [3:0]    _zz_readWriteBuffer_1_1;
  reg        [3:0]    _zz_readWriteBuffer_1_2;
  reg        [3:0]    _zz_readWriteBuffer_1_3;
  reg        [3:0]    _zz_readWriteBuffer_1_4;
  reg        [3:0]    _zz_readWriteBuffer_1_5;
  reg        [3:0]    _zz_readWriteBuffer_1_6;
  reg        [3:0]    _zz_readWriteBuffer_1_7;
  wire       [63:0]   readWriteBuffer_0_data;
  wire       [7:0]    readWriteBuffer_0_keep;
  wire                when_Axi4StreamWidthAdapter_l216;
  wire                when_Axi4StreamWidthAdapter_l218;
  wire                canWrite;
  wire                canWriteWhenRead;
  wire                outStream_s2mPipe_valid;
  reg                 outStream_s2mPipe_ready;
  wire       [7:0]    outStream_s2mPipe_payload_data;
  wire       [0:0]    outStream_s2mPipe_payload_keep;
  wire                outStream_s2mPipe_payload_last;
  reg                 outStream_rValidN;
  reg        [7:0]    outStream_rData_data;
  reg        [0:0]    outStream_rData_keep;
  reg                 outStream_rData_last;
  wire                outBuffer_valid;
  wire                outBuffer_ready;
  wire       [7:0]    outBuffer_payload_data;
  wire       [0:0]    outBuffer_payload_keep;
  wire                outBuffer_payload_last;
  reg                 outStream_s2mPipe_rValid;
  reg        [7:0]    outStream_s2mPipe_rData_data;
  reg        [0:0]    outStream_s2mPipe_rData_keep;
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
  function [3:0] zz__zz_writeBufferValid_1(input dummy);
    begin
      zz__zz_writeBufferValid_1[0] = 1'b1;
      zz__zz_writeBufferValid_1[1] = 1'b1;
      zz__zz_writeBufferValid_1[2] = 1'b1;
      zz__zz_writeBufferValid_1[3] = 1'b1;
    end
  endfunction
  wire [3:0] _zz_2;
  function [3:0] zz__zz_writeBufferValid_4(input dummy);
    begin
      zz__zz_writeBufferValid_4[0] = 1'b1;
      zz__zz_writeBufferValid_4[1] = 1'b1;
      zz__zz_writeBufferValid_4[2] = 1'b1;
      zz__zz_writeBufferValid_4[3] = 1'b1;
    end
  endfunction
  wire [3:0] _zz_3;
  function [3:0] zz__zz_writeBufferValid_7(input dummy);
    begin
      zz__zz_writeBufferValid_7[0] = 1'b1;
      zz__zz_writeBufferValid_7[1] = 1'b1;
      zz__zz_writeBufferValid_7[2] = 1'b1;
      zz__zz_writeBufferValid_7[3] = 1'b1;
    end
  endfunction
  wire [3:0] _zz_4;
  function [3:0] zz__zz_writeBufferValid_10(input dummy);
    begin
      zz__zz_writeBufferValid_10[0] = 1'b1;
      zz__zz_writeBufferValid_10[1] = 1'b1;
      zz__zz_writeBufferValid_10[2] = 1'b1;
      zz__zz_writeBufferValid_10[3] = 1'b1;
    end
  endfunction
  wire [3:0] _zz_5;
  function [3:0] zz__zz_writeBufferValid_13(input dummy);
    begin
      zz__zz_writeBufferValid_13[0] = 1'b1;
      zz__zz_writeBufferValid_13[1] = 1'b1;
      zz__zz_writeBufferValid_13[2] = 1'b1;
      zz__zz_writeBufferValid_13[3] = 1'b1;
    end
  endfunction
  wire [3:0] _zz_6;
  function [3:0] zz__zz_writeBufferValid_16(input dummy);
    begin
      zz__zz_writeBufferValid_16[0] = 1'b1;
      zz__zz_writeBufferValid_16[1] = 1'b1;
      zz__zz_writeBufferValid_16[2] = 1'b1;
      zz__zz_writeBufferValid_16[3] = 1'b1;
    end
  endfunction
  wire [3:0] _zz_7;
  function [3:0] zz__zz_writeBufferValid_19(input dummy);
    begin
      zz__zz_writeBufferValid_19[0] = 1'b1;
      zz__zz_writeBufferValid_19[1] = 1'b1;
      zz__zz_writeBufferValid_19[2] = 1'b1;
      zz__zz_writeBufferValid_19[3] = 1'b1;
    end
  endfunction
  wire [3:0] _zz_8;
  function [3:0] zz__zz_writeBufferValid_22(input dummy);
    begin
      zz__zz_writeBufferValid_22[0] = 1'b1;
      zz__zz_writeBufferValid_22[1] = 1'b1;
      zz__zz_writeBufferValid_22[2] = 1'b1;
      zz__zz_writeBufferValid_22[3] = 1'b1;
    end
  endfunction
  wire [3:0] _zz_9;
  function [3:0] zz__zz_writeBufferValid_25(input dummy);
    begin
      zz__zz_writeBufferValid_25[0] = 1'b1;
      zz__zz_writeBufferValid_25[1] = 1'b1;
      zz__zz_writeBufferValid_25[2] = 1'b1;
      zz__zz_writeBufferValid_25[3] = 1'b1;
    end
  endfunction
  wire [3:0] _zz_10;

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
      4'b0000 : _zz__zz_writeBufferValid_3 = 3'b000;
      4'b0001 : _zz__zz_writeBufferValid_3 = 3'b100;
      4'b0010 : _zz__zz_writeBufferValid_3 = 3'b100;
      4'b0011 : _zz__zz_writeBufferValid_3 = 3'b100;
      4'b0100 : _zz__zz_writeBufferValid_3 = 3'b100;
      4'b0101 : _zz__zz_writeBufferValid_3 = 3'b100;
      4'b0110 : _zz__zz_writeBufferValid_3 = 3'b100;
      4'b0111 : _zz__zz_writeBufferValid_3 = 3'b100;
      default : _zz__zz_writeBufferValid_3 = 3'b100;
    endcase
  end

  always @(*) begin
    case(_zz_writeBufferValid_3)
      3'b000 : begin
        _zz__zz_writeBuffer_data = _zz_writeBuffer_data_2[7 : 0];
        _zz_writeBufferValid_28 = _zz_writeBufferValid_2[0 : 0];
        _zz__zz_writeBuffer_keep = _zz_writeBuffer_keep_2[0 : 0];
      end
      3'b001 : begin
        _zz__zz_writeBuffer_data = _zz_writeBuffer_data_2[15 : 8];
        _zz_writeBufferValid_28 = _zz_writeBufferValid_2[1 : 1];
        _zz__zz_writeBuffer_keep = _zz_writeBuffer_keep_2[1 : 1];
      end
      3'b010 : begin
        _zz__zz_writeBuffer_data = _zz_writeBuffer_data_2[23 : 16];
        _zz_writeBufferValid_28 = _zz_writeBufferValid_2[2 : 2];
        _zz__zz_writeBuffer_keep = _zz_writeBuffer_keep_2[2 : 2];
      end
      3'b011 : begin
        _zz__zz_writeBuffer_data = _zz_writeBuffer_data_2[31 : 24];
        _zz_writeBufferValid_28 = _zz_writeBufferValid_2[3 : 3];
        _zz__zz_writeBuffer_keep = _zz_writeBuffer_keep_2[3 : 3];
      end
      3'b100 : begin
        _zz__zz_writeBuffer_data = _zz_writeBuffer_data_2[39 : 32];
        _zz_writeBufferValid_28 = _zz_writeBufferValid_2[4 : 4];
        _zz__zz_writeBuffer_keep = _zz_writeBuffer_keep_2[4 : 4];
      end
      default : begin
        _zz__zz_writeBuffer_data = _zz_writeBuffer_data_2[47 : 40];
        _zz_writeBufferValid_28 = _zz_writeBufferValid_2[5 : 5];
        _zz__zz_writeBuffer_keep = _zz_writeBuffer_keep_2[5 : 5];
      end
    endcase
  end

  always @(*) begin
    case(_zz__zz_writeBufferValid_6_1)
      4'b0000 : _zz__zz_writeBufferValid_6 = 3'b001;
      4'b0001 : _zz__zz_writeBufferValid_6 = 3'b000;
      4'b0010 : _zz__zz_writeBufferValid_6 = 3'b100;
      4'b0011 : _zz__zz_writeBufferValid_6 = 3'b100;
      4'b0100 : _zz__zz_writeBufferValid_6 = 3'b100;
      4'b0101 : _zz__zz_writeBufferValid_6 = 3'b100;
      4'b0110 : _zz__zz_writeBufferValid_6 = 3'b100;
      4'b0111 : _zz__zz_writeBufferValid_6 = 3'b100;
      default : _zz__zz_writeBufferValid_6 = 3'b100;
    endcase
  end

  always @(*) begin
    case(_zz_writeBufferValid_6)
      3'b000 : begin
        _zz__zz_writeBuffer_data_1 = _zz_writeBuffer_data_3[7 : 0];
        _zz_writeBufferValid_29 = _zz_writeBufferValid_5[0 : 0];
        _zz__zz_writeBuffer_keep_1 = _zz_writeBuffer_keep_3[0 : 0];
      end
      3'b001 : begin
        _zz__zz_writeBuffer_data_1 = _zz_writeBuffer_data_3[15 : 8];
        _zz_writeBufferValid_29 = _zz_writeBufferValid_5[1 : 1];
        _zz__zz_writeBuffer_keep_1 = _zz_writeBuffer_keep_3[1 : 1];
      end
      3'b010 : begin
        _zz__zz_writeBuffer_data_1 = _zz_writeBuffer_data_3[23 : 16];
        _zz_writeBufferValid_29 = _zz_writeBufferValid_5[2 : 2];
        _zz__zz_writeBuffer_keep_1 = _zz_writeBuffer_keep_3[2 : 2];
      end
      3'b011 : begin
        _zz__zz_writeBuffer_data_1 = _zz_writeBuffer_data_3[31 : 24];
        _zz_writeBufferValid_29 = _zz_writeBufferValid_5[3 : 3];
        _zz__zz_writeBuffer_keep_1 = _zz_writeBuffer_keep_3[3 : 3];
      end
      3'b100 : begin
        _zz__zz_writeBuffer_data_1 = _zz_writeBuffer_data_3[39 : 32];
        _zz_writeBufferValid_29 = _zz_writeBufferValid_5[4 : 4];
        _zz__zz_writeBuffer_keep_1 = _zz_writeBuffer_keep_3[4 : 4];
      end
      default : begin
        _zz__zz_writeBuffer_data_1 = _zz_writeBuffer_data_3[47 : 40];
        _zz_writeBufferValid_29 = _zz_writeBufferValid_5[5 : 5];
        _zz__zz_writeBuffer_keep_1 = _zz_writeBuffer_keep_3[5 : 5];
      end
    endcase
  end

  always @(*) begin
    case(_zz__zz_writeBufferValid_9_1)
      4'b0000 : _zz__zz_writeBufferValid_9 = 3'b010;
      4'b0001 : _zz__zz_writeBufferValid_9 = 3'b001;
      4'b0010 : _zz__zz_writeBufferValid_9 = 3'b000;
      4'b0011 : _zz__zz_writeBufferValid_9 = 3'b100;
      4'b0100 : _zz__zz_writeBufferValid_9 = 3'b100;
      4'b0101 : _zz__zz_writeBufferValid_9 = 3'b100;
      4'b0110 : _zz__zz_writeBufferValid_9 = 3'b100;
      4'b0111 : _zz__zz_writeBufferValid_9 = 3'b100;
      default : _zz__zz_writeBufferValid_9 = 3'b100;
    endcase
  end

  always @(*) begin
    case(_zz_writeBufferValid_9)
      3'b000 : begin
        _zz__zz_writeBuffer_data_2 = _zz_writeBuffer_data_4[7 : 0];
        _zz_writeBufferValid_30 = _zz_writeBufferValid_8[0 : 0];
        _zz__zz_writeBuffer_keep_2 = _zz_writeBuffer_keep_4[0 : 0];
      end
      3'b001 : begin
        _zz__zz_writeBuffer_data_2 = _zz_writeBuffer_data_4[15 : 8];
        _zz_writeBufferValid_30 = _zz_writeBufferValid_8[1 : 1];
        _zz__zz_writeBuffer_keep_2 = _zz_writeBuffer_keep_4[1 : 1];
      end
      3'b010 : begin
        _zz__zz_writeBuffer_data_2 = _zz_writeBuffer_data_4[23 : 16];
        _zz_writeBufferValid_30 = _zz_writeBufferValid_8[2 : 2];
        _zz__zz_writeBuffer_keep_2 = _zz_writeBuffer_keep_4[2 : 2];
      end
      3'b011 : begin
        _zz__zz_writeBuffer_data_2 = _zz_writeBuffer_data_4[31 : 24];
        _zz_writeBufferValid_30 = _zz_writeBufferValid_8[3 : 3];
        _zz__zz_writeBuffer_keep_2 = _zz_writeBuffer_keep_4[3 : 3];
      end
      3'b100 : begin
        _zz__zz_writeBuffer_data_2 = _zz_writeBuffer_data_4[39 : 32];
        _zz_writeBufferValid_30 = _zz_writeBufferValid_8[4 : 4];
        _zz__zz_writeBuffer_keep_2 = _zz_writeBuffer_keep_4[4 : 4];
      end
      default : begin
        _zz__zz_writeBuffer_data_2 = _zz_writeBuffer_data_4[47 : 40];
        _zz_writeBufferValid_30 = _zz_writeBufferValid_8[5 : 5];
        _zz__zz_writeBuffer_keep_2 = _zz_writeBuffer_keep_4[5 : 5];
      end
    endcase
  end

  always @(*) begin
    case(_zz__zz_writeBufferValid_12_1)
      4'b0000 : _zz__zz_writeBufferValid_12 = 3'b011;
      4'b0001 : _zz__zz_writeBufferValid_12 = 3'b010;
      4'b0010 : _zz__zz_writeBufferValid_12 = 3'b001;
      4'b0011 : _zz__zz_writeBufferValid_12 = 3'b000;
      4'b0100 : _zz__zz_writeBufferValid_12 = 3'b100;
      4'b0101 : _zz__zz_writeBufferValid_12 = 3'b100;
      4'b0110 : _zz__zz_writeBufferValid_12 = 3'b100;
      4'b0111 : _zz__zz_writeBufferValid_12 = 3'b100;
      default : _zz__zz_writeBufferValid_12 = 3'b100;
    endcase
  end

  always @(*) begin
    case(_zz_writeBufferValid_12)
      3'b000 : begin
        _zz__zz_writeBuffer_data_3 = _zz_writeBuffer_data_5[7 : 0];
        _zz_writeBufferValid_31 = _zz_writeBufferValid_11[0 : 0];
        _zz__zz_writeBuffer_keep_3 = _zz_writeBuffer_keep_5[0 : 0];
      end
      3'b001 : begin
        _zz__zz_writeBuffer_data_3 = _zz_writeBuffer_data_5[15 : 8];
        _zz_writeBufferValid_31 = _zz_writeBufferValid_11[1 : 1];
        _zz__zz_writeBuffer_keep_3 = _zz_writeBuffer_keep_5[1 : 1];
      end
      3'b010 : begin
        _zz__zz_writeBuffer_data_3 = _zz_writeBuffer_data_5[23 : 16];
        _zz_writeBufferValid_31 = _zz_writeBufferValid_11[2 : 2];
        _zz__zz_writeBuffer_keep_3 = _zz_writeBuffer_keep_5[2 : 2];
      end
      3'b011 : begin
        _zz__zz_writeBuffer_data_3 = _zz_writeBuffer_data_5[31 : 24];
        _zz_writeBufferValid_31 = _zz_writeBufferValid_11[3 : 3];
        _zz__zz_writeBuffer_keep_3 = _zz_writeBuffer_keep_5[3 : 3];
      end
      3'b100 : begin
        _zz__zz_writeBuffer_data_3 = _zz_writeBuffer_data_5[39 : 32];
        _zz_writeBufferValid_31 = _zz_writeBufferValid_11[4 : 4];
        _zz__zz_writeBuffer_keep_3 = _zz_writeBuffer_keep_5[4 : 4];
      end
      default : begin
        _zz__zz_writeBuffer_data_3 = _zz_writeBuffer_data_5[47 : 40];
        _zz_writeBufferValid_31 = _zz_writeBufferValid_11[5 : 5];
        _zz__zz_writeBuffer_keep_3 = _zz_writeBuffer_keep_5[5 : 5];
      end
    endcase
  end

  always @(*) begin
    case(_zz__zz_writeBufferValid_15_1)
      4'b0000 : _zz__zz_writeBufferValid_15 = 3'b101;
      4'b0001 : _zz__zz_writeBufferValid_15 = 3'b011;
      4'b0010 : _zz__zz_writeBufferValid_15 = 3'b010;
      4'b0011 : _zz__zz_writeBufferValid_15 = 3'b001;
      4'b0100 : _zz__zz_writeBufferValid_15 = 3'b000;
      4'b0101 : _zz__zz_writeBufferValid_15 = 3'b100;
      4'b0110 : _zz__zz_writeBufferValid_15 = 3'b100;
      4'b0111 : _zz__zz_writeBufferValid_15 = 3'b100;
      default : _zz__zz_writeBufferValid_15 = 3'b100;
    endcase
  end

  always @(*) begin
    case(_zz_writeBufferValid_15)
      3'b000 : begin
        _zz__zz_writeBuffer_data_4 = _zz_writeBuffer_data_6[7 : 0];
        _zz_writeBufferValid_32 = _zz_writeBufferValid_14[0 : 0];
        _zz__zz_writeBuffer_keep_4 = _zz_writeBuffer_keep_6[0 : 0];
      end
      3'b001 : begin
        _zz__zz_writeBuffer_data_4 = _zz_writeBuffer_data_6[15 : 8];
        _zz_writeBufferValid_32 = _zz_writeBufferValid_14[1 : 1];
        _zz__zz_writeBuffer_keep_4 = _zz_writeBuffer_keep_6[1 : 1];
      end
      3'b010 : begin
        _zz__zz_writeBuffer_data_4 = _zz_writeBuffer_data_6[23 : 16];
        _zz_writeBufferValid_32 = _zz_writeBufferValid_14[2 : 2];
        _zz__zz_writeBuffer_keep_4 = _zz_writeBuffer_keep_6[2 : 2];
      end
      3'b011 : begin
        _zz__zz_writeBuffer_data_4 = _zz_writeBuffer_data_6[31 : 24];
        _zz_writeBufferValid_32 = _zz_writeBufferValid_14[3 : 3];
        _zz__zz_writeBuffer_keep_4 = _zz_writeBuffer_keep_6[3 : 3];
      end
      3'b100 : begin
        _zz__zz_writeBuffer_data_4 = _zz_writeBuffer_data_6[39 : 32];
        _zz_writeBufferValid_32 = _zz_writeBufferValid_14[4 : 4];
        _zz__zz_writeBuffer_keep_4 = _zz_writeBuffer_keep_6[4 : 4];
      end
      default : begin
        _zz__zz_writeBuffer_data_4 = _zz_writeBuffer_data_6[47 : 40];
        _zz_writeBufferValid_32 = _zz_writeBufferValid_14[5 : 5];
        _zz__zz_writeBuffer_keep_4 = _zz_writeBuffer_keep_6[5 : 5];
      end
    endcase
  end

  always @(*) begin
    case(_zz__zz_writeBufferValid_18_1)
      4'b0000 : _zz__zz_writeBufferValid_18 = 3'b101;
      4'b0001 : _zz__zz_writeBufferValid_18 = 3'b101;
      4'b0010 : _zz__zz_writeBufferValid_18 = 3'b011;
      4'b0011 : _zz__zz_writeBufferValid_18 = 3'b010;
      4'b0100 : _zz__zz_writeBufferValid_18 = 3'b001;
      4'b0101 : _zz__zz_writeBufferValid_18 = 3'b000;
      4'b0110 : _zz__zz_writeBufferValid_18 = 3'b100;
      4'b0111 : _zz__zz_writeBufferValid_18 = 3'b100;
      default : _zz__zz_writeBufferValid_18 = 3'b100;
    endcase
  end

  always @(*) begin
    case(_zz_writeBufferValid_18)
      3'b000 : begin
        _zz__zz_writeBuffer_data_5 = _zz_writeBuffer_data_7[7 : 0];
        _zz_writeBufferValid_33 = _zz_writeBufferValid_17[0 : 0];
        _zz__zz_writeBuffer_keep_5 = _zz_writeBuffer_keep_7[0 : 0];
      end
      3'b001 : begin
        _zz__zz_writeBuffer_data_5 = _zz_writeBuffer_data_7[15 : 8];
        _zz_writeBufferValid_33 = _zz_writeBufferValid_17[1 : 1];
        _zz__zz_writeBuffer_keep_5 = _zz_writeBuffer_keep_7[1 : 1];
      end
      3'b010 : begin
        _zz__zz_writeBuffer_data_5 = _zz_writeBuffer_data_7[23 : 16];
        _zz_writeBufferValid_33 = _zz_writeBufferValid_17[2 : 2];
        _zz__zz_writeBuffer_keep_5 = _zz_writeBuffer_keep_7[2 : 2];
      end
      3'b011 : begin
        _zz__zz_writeBuffer_data_5 = _zz_writeBuffer_data_7[31 : 24];
        _zz_writeBufferValid_33 = _zz_writeBufferValid_17[3 : 3];
        _zz__zz_writeBuffer_keep_5 = _zz_writeBuffer_keep_7[3 : 3];
      end
      3'b100 : begin
        _zz__zz_writeBuffer_data_5 = _zz_writeBuffer_data_7[39 : 32];
        _zz_writeBufferValid_33 = _zz_writeBufferValid_17[4 : 4];
        _zz__zz_writeBuffer_keep_5 = _zz_writeBuffer_keep_7[4 : 4];
      end
      default : begin
        _zz__zz_writeBuffer_data_5 = _zz_writeBuffer_data_7[47 : 40];
        _zz_writeBufferValid_33 = _zz_writeBufferValid_17[5 : 5];
        _zz__zz_writeBuffer_keep_5 = _zz_writeBuffer_keep_7[5 : 5];
      end
    endcase
  end

  always @(*) begin
    case(_zz__zz_writeBufferValid_21_1)
      4'b0000 : _zz__zz_writeBufferValid_21 = 3'b101;
      4'b0001 : _zz__zz_writeBufferValid_21 = 3'b101;
      4'b0010 : _zz__zz_writeBufferValid_21 = 3'b101;
      4'b0011 : _zz__zz_writeBufferValid_21 = 3'b011;
      4'b0100 : _zz__zz_writeBufferValid_21 = 3'b010;
      4'b0101 : _zz__zz_writeBufferValid_21 = 3'b001;
      4'b0110 : _zz__zz_writeBufferValid_21 = 3'b000;
      4'b0111 : _zz__zz_writeBufferValid_21 = 3'b100;
      default : _zz__zz_writeBufferValid_21 = 3'b100;
    endcase
  end

  always @(*) begin
    case(_zz_writeBufferValid_21)
      3'b000 : begin
        _zz__zz_writeBuffer_data_6 = _zz_writeBuffer_data_8[7 : 0];
        _zz_writeBufferValid_34 = _zz_writeBufferValid_20[0 : 0];
        _zz__zz_writeBuffer_keep_6 = _zz_writeBuffer_keep_8[0 : 0];
      end
      3'b001 : begin
        _zz__zz_writeBuffer_data_6 = _zz_writeBuffer_data_8[15 : 8];
        _zz_writeBufferValid_34 = _zz_writeBufferValid_20[1 : 1];
        _zz__zz_writeBuffer_keep_6 = _zz_writeBuffer_keep_8[1 : 1];
      end
      3'b010 : begin
        _zz__zz_writeBuffer_data_6 = _zz_writeBuffer_data_8[23 : 16];
        _zz_writeBufferValid_34 = _zz_writeBufferValid_20[2 : 2];
        _zz__zz_writeBuffer_keep_6 = _zz_writeBuffer_keep_8[2 : 2];
      end
      3'b011 : begin
        _zz__zz_writeBuffer_data_6 = _zz_writeBuffer_data_8[31 : 24];
        _zz_writeBufferValid_34 = _zz_writeBufferValid_20[3 : 3];
        _zz__zz_writeBuffer_keep_6 = _zz_writeBuffer_keep_8[3 : 3];
      end
      3'b100 : begin
        _zz__zz_writeBuffer_data_6 = _zz_writeBuffer_data_8[39 : 32];
        _zz_writeBufferValid_34 = _zz_writeBufferValid_20[4 : 4];
        _zz__zz_writeBuffer_keep_6 = _zz_writeBuffer_keep_8[4 : 4];
      end
      default : begin
        _zz__zz_writeBuffer_data_6 = _zz_writeBuffer_data_8[47 : 40];
        _zz_writeBufferValid_34 = _zz_writeBufferValid_20[5 : 5];
        _zz__zz_writeBuffer_keep_6 = _zz_writeBuffer_keep_8[5 : 5];
      end
    endcase
  end

  always @(*) begin
    case(_zz__zz_writeBufferValid_24_1)
      4'b0000 : _zz__zz_writeBufferValid_24 = 3'b101;
      4'b0001 : _zz__zz_writeBufferValid_24 = 3'b101;
      4'b0010 : _zz__zz_writeBufferValid_24 = 3'b101;
      4'b0011 : _zz__zz_writeBufferValid_24 = 3'b101;
      4'b0100 : _zz__zz_writeBufferValid_24 = 3'b011;
      4'b0101 : _zz__zz_writeBufferValid_24 = 3'b010;
      4'b0110 : _zz__zz_writeBufferValid_24 = 3'b001;
      4'b0111 : _zz__zz_writeBufferValid_24 = 3'b000;
      default : _zz__zz_writeBufferValid_24 = 3'b100;
    endcase
  end

  always @(*) begin
    case(_zz_writeBufferValid_24)
      3'b000 : begin
        _zz__zz_writeBuffer_data_7 = _zz_writeBuffer_data_9[7 : 0];
        _zz_writeBufferValid_35 = _zz_writeBufferValid_23[0 : 0];
        _zz__zz_writeBuffer_keep_7 = _zz_writeBuffer_keep_9[0 : 0];
      end
      3'b001 : begin
        _zz__zz_writeBuffer_data_7 = _zz_writeBuffer_data_9[15 : 8];
        _zz_writeBufferValid_35 = _zz_writeBufferValid_23[1 : 1];
        _zz__zz_writeBuffer_keep_7 = _zz_writeBuffer_keep_9[1 : 1];
      end
      3'b010 : begin
        _zz__zz_writeBuffer_data_7 = _zz_writeBuffer_data_9[23 : 16];
        _zz_writeBufferValid_35 = _zz_writeBufferValid_23[2 : 2];
        _zz__zz_writeBuffer_keep_7 = _zz_writeBuffer_keep_9[2 : 2];
      end
      3'b011 : begin
        _zz__zz_writeBuffer_data_7 = _zz_writeBuffer_data_9[31 : 24];
        _zz_writeBufferValid_35 = _zz_writeBufferValid_23[3 : 3];
        _zz__zz_writeBuffer_keep_7 = _zz_writeBuffer_keep_9[3 : 3];
      end
      3'b100 : begin
        _zz__zz_writeBuffer_data_7 = _zz_writeBuffer_data_9[39 : 32];
        _zz_writeBufferValid_35 = _zz_writeBufferValid_23[4 : 4];
        _zz__zz_writeBuffer_keep_7 = _zz_writeBuffer_keep_9[4 : 4];
      end
      default : begin
        _zz__zz_writeBuffer_data_7 = _zz_writeBuffer_data_9[47 : 40];
        _zz_writeBufferValid_35 = _zz_writeBufferValid_23[5 : 5];
        _zz__zz_writeBuffer_keep_7 = _zz_writeBuffer_keep_9[5 : 5];
      end
    endcase
  end

  always @(*) begin
    case(_zz__zz_writeBufferValid_27_1)
      4'b0000 : _zz__zz_writeBufferValid_27 = 3'b101;
      4'b0001 : _zz__zz_writeBufferValid_27 = 3'b101;
      4'b0010 : _zz__zz_writeBufferValid_27 = 3'b101;
      4'b0011 : _zz__zz_writeBufferValid_27 = 3'b101;
      4'b0100 : _zz__zz_writeBufferValid_27 = 3'b101;
      4'b0101 : _zz__zz_writeBufferValid_27 = 3'b011;
      4'b0110 : _zz__zz_writeBufferValid_27 = 3'b010;
      4'b0111 : _zz__zz_writeBufferValid_27 = 3'b001;
      default : _zz__zz_writeBufferValid_27 = 3'b000;
    endcase
  end

  always @(*) begin
    case(_zz_writeBufferValid_27)
      3'b000 : begin
        _zz__zz_writeBuffer_data_8 = _zz_writeBuffer_data_10[7 : 0];
        _zz_writeBufferValid_36 = _zz_writeBufferValid_26[0 : 0];
        _zz__zz_writeBuffer_keep_8 = _zz_writeBuffer_keep_10[0 : 0];
      end
      3'b001 : begin
        _zz__zz_writeBuffer_data_8 = _zz_writeBuffer_data_10[15 : 8];
        _zz_writeBufferValid_36 = _zz_writeBufferValid_26[1 : 1];
        _zz__zz_writeBuffer_keep_8 = _zz_writeBuffer_keep_10[1 : 1];
      end
      3'b010 : begin
        _zz__zz_writeBuffer_data_8 = _zz_writeBuffer_data_10[23 : 16];
        _zz_writeBufferValid_36 = _zz_writeBufferValid_26[2 : 2];
        _zz__zz_writeBuffer_keep_8 = _zz_writeBuffer_keep_10[2 : 2];
      end
      3'b011 : begin
        _zz__zz_writeBuffer_data_8 = _zz_writeBuffer_data_10[31 : 24];
        _zz_writeBufferValid_36 = _zz_writeBufferValid_26[3 : 3];
        _zz__zz_writeBuffer_keep_8 = _zz_writeBuffer_keep_10[3 : 3];
      end
      3'b100 : begin
        _zz__zz_writeBuffer_data_8 = _zz_writeBuffer_data_10[39 : 32];
        _zz_writeBufferValid_36 = _zz_writeBufferValid_26[4 : 4];
        _zz__zz_writeBuffer_keep_8 = _zz_writeBuffer_keep_10[4 : 4];
      end
      default : begin
        _zz__zz_writeBuffer_data_8 = _zz_writeBuffer_data_10[47 : 40];
        _zz_writeBufferValid_36 = _zz_writeBufferValid_26[5 : 5];
        _zz__zz_writeBuffer_keep_8 = _zz_writeBuffer_keep_10[5 : 5];
      end
    endcase
  end

  always @(*) begin
    case(_zz_readWriteBuffer_1)
      4'b0000 : begin
        _zz__zz_readWriteBuffer_0_data = writeBuffer_data[7 : 0];
        _zz_readWriteBuffer_1_8 = writeBufferValid[0 : 0];
        _zz__zz_readWriteBuffer_0_keep = writeBuffer_keep[0 : 0];
      end
      4'b0001 : begin
        _zz__zz_readWriteBuffer_0_data = writeBuffer_data[15 : 8];
        _zz_readWriteBuffer_1_8 = writeBufferValid[1 : 1];
        _zz__zz_readWriteBuffer_0_keep = writeBuffer_keep[1 : 1];
      end
      4'b0010 : begin
        _zz__zz_readWriteBuffer_0_data = writeBuffer_data[23 : 16];
        _zz_readWriteBuffer_1_8 = writeBufferValid[2 : 2];
        _zz__zz_readWriteBuffer_0_keep = writeBuffer_keep[2 : 2];
      end
      4'b0011 : begin
        _zz__zz_readWriteBuffer_0_data = writeBuffer_data[31 : 24];
        _zz_readWriteBuffer_1_8 = writeBufferValid[3 : 3];
        _zz__zz_readWriteBuffer_0_keep = writeBuffer_keep[3 : 3];
      end
      4'b0100 : begin
        _zz__zz_readWriteBuffer_0_data = writeBuffer_data[39 : 32];
        _zz_readWriteBuffer_1_8 = writeBufferValid[4 : 4];
        _zz__zz_readWriteBuffer_0_keep = writeBuffer_keep[4 : 4];
      end
      4'b0101 : begin
        _zz__zz_readWriteBuffer_0_data = writeBuffer_data[47 : 40];
        _zz_readWriteBuffer_1_8 = writeBufferValid[5 : 5];
        _zz__zz_readWriteBuffer_0_keep = writeBuffer_keep[5 : 5];
      end
      4'b0110 : begin
        _zz__zz_readWriteBuffer_0_data = writeBuffer_data[55 : 48];
        _zz_readWriteBuffer_1_8 = writeBufferValid[6 : 6];
        _zz__zz_readWriteBuffer_0_keep = writeBuffer_keep[6 : 6];
      end
      4'b0111 : begin
        _zz__zz_readWriteBuffer_0_data = writeBuffer_data[63 : 56];
        _zz_readWriteBuffer_1_8 = writeBufferValid[7 : 7];
        _zz__zz_readWriteBuffer_0_keep = writeBuffer_keep[7 : 7];
      end
      default : begin
        _zz__zz_readWriteBuffer_0_data = writeBuffer_data[71 : 64];
        _zz_readWriteBuffer_1_8 = writeBufferValid[8 : 8];
        _zz__zz_readWriteBuffer_0_keep = writeBuffer_keep[8 : 8];
      end
    endcase
  end

  always @(*) begin
    case(_zz_readWriteBuffer_1_1)
      4'b0000 : begin
        _zz__zz_readWriteBuffer_0_data_1 = writeBuffer_data[7 : 0];
        _zz_readWriteBuffer_1_9 = writeBufferValid[0 : 0];
        _zz__zz_readWriteBuffer_0_keep_1 = writeBuffer_keep[0 : 0];
      end
      4'b0001 : begin
        _zz__zz_readWriteBuffer_0_data_1 = writeBuffer_data[15 : 8];
        _zz_readWriteBuffer_1_9 = writeBufferValid[1 : 1];
        _zz__zz_readWriteBuffer_0_keep_1 = writeBuffer_keep[1 : 1];
      end
      4'b0010 : begin
        _zz__zz_readWriteBuffer_0_data_1 = writeBuffer_data[23 : 16];
        _zz_readWriteBuffer_1_9 = writeBufferValid[2 : 2];
        _zz__zz_readWriteBuffer_0_keep_1 = writeBuffer_keep[2 : 2];
      end
      4'b0011 : begin
        _zz__zz_readWriteBuffer_0_data_1 = writeBuffer_data[31 : 24];
        _zz_readWriteBuffer_1_9 = writeBufferValid[3 : 3];
        _zz__zz_readWriteBuffer_0_keep_1 = writeBuffer_keep[3 : 3];
      end
      4'b0100 : begin
        _zz__zz_readWriteBuffer_0_data_1 = writeBuffer_data[39 : 32];
        _zz_readWriteBuffer_1_9 = writeBufferValid[4 : 4];
        _zz__zz_readWriteBuffer_0_keep_1 = writeBuffer_keep[4 : 4];
      end
      4'b0101 : begin
        _zz__zz_readWriteBuffer_0_data_1 = writeBuffer_data[47 : 40];
        _zz_readWriteBuffer_1_9 = writeBufferValid[5 : 5];
        _zz__zz_readWriteBuffer_0_keep_1 = writeBuffer_keep[5 : 5];
      end
      4'b0110 : begin
        _zz__zz_readWriteBuffer_0_data_1 = writeBuffer_data[55 : 48];
        _zz_readWriteBuffer_1_9 = writeBufferValid[6 : 6];
        _zz__zz_readWriteBuffer_0_keep_1 = writeBuffer_keep[6 : 6];
      end
      4'b0111 : begin
        _zz__zz_readWriteBuffer_0_data_1 = writeBuffer_data[63 : 56];
        _zz_readWriteBuffer_1_9 = writeBufferValid[7 : 7];
        _zz__zz_readWriteBuffer_0_keep_1 = writeBuffer_keep[7 : 7];
      end
      default : begin
        _zz__zz_readWriteBuffer_0_data_1 = writeBuffer_data[71 : 64];
        _zz_readWriteBuffer_1_9 = writeBufferValid[8 : 8];
        _zz__zz_readWriteBuffer_0_keep_1 = writeBuffer_keep[8 : 8];
      end
    endcase
  end

  always @(*) begin
    case(_zz_readWriteBuffer_1_2)
      4'b0000 : begin
        _zz__zz_readWriteBuffer_0_data_2 = writeBuffer_data[7 : 0];
        _zz_readWriteBuffer_1_10 = writeBufferValid[0 : 0];
        _zz__zz_readWriteBuffer_0_keep_2 = writeBuffer_keep[0 : 0];
      end
      4'b0001 : begin
        _zz__zz_readWriteBuffer_0_data_2 = writeBuffer_data[15 : 8];
        _zz_readWriteBuffer_1_10 = writeBufferValid[1 : 1];
        _zz__zz_readWriteBuffer_0_keep_2 = writeBuffer_keep[1 : 1];
      end
      4'b0010 : begin
        _zz__zz_readWriteBuffer_0_data_2 = writeBuffer_data[23 : 16];
        _zz_readWriteBuffer_1_10 = writeBufferValid[2 : 2];
        _zz__zz_readWriteBuffer_0_keep_2 = writeBuffer_keep[2 : 2];
      end
      4'b0011 : begin
        _zz__zz_readWriteBuffer_0_data_2 = writeBuffer_data[31 : 24];
        _zz_readWriteBuffer_1_10 = writeBufferValid[3 : 3];
        _zz__zz_readWriteBuffer_0_keep_2 = writeBuffer_keep[3 : 3];
      end
      4'b0100 : begin
        _zz__zz_readWriteBuffer_0_data_2 = writeBuffer_data[39 : 32];
        _zz_readWriteBuffer_1_10 = writeBufferValid[4 : 4];
        _zz__zz_readWriteBuffer_0_keep_2 = writeBuffer_keep[4 : 4];
      end
      4'b0101 : begin
        _zz__zz_readWriteBuffer_0_data_2 = writeBuffer_data[47 : 40];
        _zz_readWriteBuffer_1_10 = writeBufferValid[5 : 5];
        _zz__zz_readWriteBuffer_0_keep_2 = writeBuffer_keep[5 : 5];
      end
      4'b0110 : begin
        _zz__zz_readWriteBuffer_0_data_2 = writeBuffer_data[55 : 48];
        _zz_readWriteBuffer_1_10 = writeBufferValid[6 : 6];
        _zz__zz_readWriteBuffer_0_keep_2 = writeBuffer_keep[6 : 6];
      end
      4'b0111 : begin
        _zz__zz_readWriteBuffer_0_data_2 = writeBuffer_data[63 : 56];
        _zz_readWriteBuffer_1_10 = writeBufferValid[7 : 7];
        _zz__zz_readWriteBuffer_0_keep_2 = writeBuffer_keep[7 : 7];
      end
      default : begin
        _zz__zz_readWriteBuffer_0_data_2 = writeBuffer_data[71 : 64];
        _zz_readWriteBuffer_1_10 = writeBufferValid[8 : 8];
        _zz__zz_readWriteBuffer_0_keep_2 = writeBuffer_keep[8 : 8];
      end
    endcase
  end

  always @(*) begin
    case(_zz_readWriteBuffer_1_3)
      4'b0000 : begin
        _zz__zz_readWriteBuffer_0_data_3 = writeBuffer_data[7 : 0];
        _zz_readWriteBuffer_1_11 = writeBufferValid[0 : 0];
        _zz__zz_readWriteBuffer_0_keep_3 = writeBuffer_keep[0 : 0];
      end
      4'b0001 : begin
        _zz__zz_readWriteBuffer_0_data_3 = writeBuffer_data[15 : 8];
        _zz_readWriteBuffer_1_11 = writeBufferValid[1 : 1];
        _zz__zz_readWriteBuffer_0_keep_3 = writeBuffer_keep[1 : 1];
      end
      4'b0010 : begin
        _zz__zz_readWriteBuffer_0_data_3 = writeBuffer_data[23 : 16];
        _zz_readWriteBuffer_1_11 = writeBufferValid[2 : 2];
        _zz__zz_readWriteBuffer_0_keep_3 = writeBuffer_keep[2 : 2];
      end
      4'b0011 : begin
        _zz__zz_readWriteBuffer_0_data_3 = writeBuffer_data[31 : 24];
        _zz_readWriteBuffer_1_11 = writeBufferValid[3 : 3];
        _zz__zz_readWriteBuffer_0_keep_3 = writeBuffer_keep[3 : 3];
      end
      4'b0100 : begin
        _zz__zz_readWriteBuffer_0_data_3 = writeBuffer_data[39 : 32];
        _zz_readWriteBuffer_1_11 = writeBufferValid[4 : 4];
        _zz__zz_readWriteBuffer_0_keep_3 = writeBuffer_keep[4 : 4];
      end
      4'b0101 : begin
        _zz__zz_readWriteBuffer_0_data_3 = writeBuffer_data[47 : 40];
        _zz_readWriteBuffer_1_11 = writeBufferValid[5 : 5];
        _zz__zz_readWriteBuffer_0_keep_3 = writeBuffer_keep[5 : 5];
      end
      4'b0110 : begin
        _zz__zz_readWriteBuffer_0_data_3 = writeBuffer_data[55 : 48];
        _zz_readWriteBuffer_1_11 = writeBufferValid[6 : 6];
        _zz__zz_readWriteBuffer_0_keep_3 = writeBuffer_keep[6 : 6];
      end
      4'b0111 : begin
        _zz__zz_readWriteBuffer_0_data_3 = writeBuffer_data[63 : 56];
        _zz_readWriteBuffer_1_11 = writeBufferValid[7 : 7];
        _zz__zz_readWriteBuffer_0_keep_3 = writeBuffer_keep[7 : 7];
      end
      default : begin
        _zz__zz_readWriteBuffer_0_data_3 = writeBuffer_data[71 : 64];
        _zz_readWriteBuffer_1_11 = writeBufferValid[8 : 8];
        _zz__zz_readWriteBuffer_0_keep_3 = writeBuffer_keep[8 : 8];
      end
    endcase
  end

  always @(*) begin
    case(_zz_readWriteBuffer_1_4)
      4'b0000 : begin
        _zz__zz_readWriteBuffer_0_data_4 = writeBuffer_data[7 : 0];
        _zz_readWriteBuffer_1_12 = writeBufferValid[0 : 0];
        _zz__zz_readWriteBuffer_0_keep_4 = writeBuffer_keep[0 : 0];
      end
      4'b0001 : begin
        _zz__zz_readWriteBuffer_0_data_4 = writeBuffer_data[15 : 8];
        _zz_readWriteBuffer_1_12 = writeBufferValid[1 : 1];
        _zz__zz_readWriteBuffer_0_keep_4 = writeBuffer_keep[1 : 1];
      end
      4'b0010 : begin
        _zz__zz_readWriteBuffer_0_data_4 = writeBuffer_data[23 : 16];
        _zz_readWriteBuffer_1_12 = writeBufferValid[2 : 2];
        _zz__zz_readWriteBuffer_0_keep_4 = writeBuffer_keep[2 : 2];
      end
      4'b0011 : begin
        _zz__zz_readWriteBuffer_0_data_4 = writeBuffer_data[31 : 24];
        _zz_readWriteBuffer_1_12 = writeBufferValid[3 : 3];
        _zz__zz_readWriteBuffer_0_keep_4 = writeBuffer_keep[3 : 3];
      end
      4'b0100 : begin
        _zz__zz_readWriteBuffer_0_data_4 = writeBuffer_data[39 : 32];
        _zz_readWriteBuffer_1_12 = writeBufferValid[4 : 4];
        _zz__zz_readWriteBuffer_0_keep_4 = writeBuffer_keep[4 : 4];
      end
      4'b0101 : begin
        _zz__zz_readWriteBuffer_0_data_4 = writeBuffer_data[47 : 40];
        _zz_readWriteBuffer_1_12 = writeBufferValid[5 : 5];
        _zz__zz_readWriteBuffer_0_keep_4 = writeBuffer_keep[5 : 5];
      end
      4'b0110 : begin
        _zz__zz_readWriteBuffer_0_data_4 = writeBuffer_data[55 : 48];
        _zz_readWriteBuffer_1_12 = writeBufferValid[6 : 6];
        _zz__zz_readWriteBuffer_0_keep_4 = writeBuffer_keep[6 : 6];
      end
      4'b0111 : begin
        _zz__zz_readWriteBuffer_0_data_4 = writeBuffer_data[63 : 56];
        _zz_readWriteBuffer_1_12 = writeBufferValid[7 : 7];
        _zz__zz_readWriteBuffer_0_keep_4 = writeBuffer_keep[7 : 7];
      end
      default : begin
        _zz__zz_readWriteBuffer_0_data_4 = writeBuffer_data[71 : 64];
        _zz_readWriteBuffer_1_12 = writeBufferValid[8 : 8];
        _zz__zz_readWriteBuffer_0_keep_4 = writeBuffer_keep[8 : 8];
      end
    endcase
  end

  always @(*) begin
    case(_zz_readWriteBuffer_1_5)
      4'b0000 : begin
        _zz__zz_readWriteBuffer_0_data_5 = writeBuffer_data[7 : 0];
        _zz_readWriteBuffer_1_13 = writeBufferValid[0 : 0];
        _zz__zz_readWriteBuffer_0_keep_5 = writeBuffer_keep[0 : 0];
      end
      4'b0001 : begin
        _zz__zz_readWriteBuffer_0_data_5 = writeBuffer_data[15 : 8];
        _zz_readWriteBuffer_1_13 = writeBufferValid[1 : 1];
        _zz__zz_readWriteBuffer_0_keep_5 = writeBuffer_keep[1 : 1];
      end
      4'b0010 : begin
        _zz__zz_readWriteBuffer_0_data_5 = writeBuffer_data[23 : 16];
        _zz_readWriteBuffer_1_13 = writeBufferValid[2 : 2];
        _zz__zz_readWriteBuffer_0_keep_5 = writeBuffer_keep[2 : 2];
      end
      4'b0011 : begin
        _zz__zz_readWriteBuffer_0_data_5 = writeBuffer_data[31 : 24];
        _zz_readWriteBuffer_1_13 = writeBufferValid[3 : 3];
        _zz__zz_readWriteBuffer_0_keep_5 = writeBuffer_keep[3 : 3];
      end
      4'b0100 : begin
        _zz__zz_readWriteBuffer_0_data_5 = writeBuffer_data[39 : 32];
        _zz_readWriteBuffer_1_13 = writeBufferValid[4 : 4];
        _zz__zz_readWriteBuffer_0_keep_5 = writeBuffer_keep[4 : 4];
      end
      4'b0101 : begin
        _zz__zz_readWriteBuffer_0_data_5 = writeBuffer_data[47 : 40];
        _zz_readWriteBuffer_1_13 = writeBufferValid[5 : 5];
        _zz__zz_readWriteBuffer_0_keep_5 = writeBuffer_keep[5 : 5];
      end
      4'b0110 : begin
        _zz__zz_readWriteBuffer_0_data_5 = writeBuffer_data[55 : 48];
        _zz_readWriteBuffer_1_13 = writeBufferValid[6 : 6];
        _zz__zz_readWriteBuffer_0_keep_5 = writeBuffer_keep[6 : 6];
      end
      4'b0111 : begin
        _zz__zz_readWriteBuffer_0_data_5 = writeBuffer_data[63 : 56];
        _zz_readWriteBuffer_1_13 = writeBufferValid[7 : 7];
        _zz__zz_readWriteBuffer_0_keep_5 = writeBuffer_keep[7 : 7];
      end
      default : begin
        _zz__zz_readWriteBuffer_0_data_5 = writeBuffer_data[71 : 64];
        _zz_readWriteBuffer_1_13 = writeBufferValid[8 : 8];
        _zz__zz_readWriteBuffer_0_keep_5 = writeBuffer_keep[8 : 8];
      end
    endcase
  end

  always @(*) begin
    case(_zz_readWriteBuffer_1_6)
      4'b0000 : begin
        _zz__zz_readWriteBuffer_0_data_6 = writeBuffer_data[7 : 0];
        _zz_readWriteBuffer_1_14 = writeBufferValid[0 : 0];
        _zz__zz_readWriteBuffer_0_keep_6 = writeBuffer_keep[0 : 0];
      end
      4'b0001 : begin
        _zz__zz_readWriteBuffer_0_data_6 = writeBuffer_data[15 : 8];
        _zz_readWriteBuffer_1_14 = writeBufferValid[1 : 1];
        _zz__zz_readWriteBuffer_0_keep_6 = writeBuffer_keep[1 : 1];
      end
      4'b0010 : begin
        _zz__zz_readWriteBuffer_0_data_6 = writeBuffer_data[23 : 16];
        _zz_readWriteBuffer_1_14 = writeBufferValid[2 : 2];
        _zz__zz_readWriteBuffer_0_keep_6 = writeBuffer_keep[2 : 2];
      end
      4'b0011 : begin
        _zz__zz_readWriteBuffer_0_data_6 = writeBuffer_data[31 : 24];
        _zz_readWriteBuffer_1_14 = writeBufferValid[3 : 3];
        _zz__zz_readWriteBuffer_0_keep_6 = writeBuffer_keep[3 : 3];
      end
      4'b0100 : begin
        _zz__zz_readWriteBuffer_0_data_6 = writeBuffer_data[39 : 32];
        _zz_readWriteBuffer_1_14 = writeBufferValid[4 : 4];
        _zz__zz_readWriteBuffer_0_keep_6 = writeBuffer_keep[4 : 4];
      end
      4'b0101 : begin
        _zz__zz_readWriteBuffer_0_data_6 = writeBuffer_data[47 : 40];
        _zz_readWriteBuffer_1_14 = writeBufferValid[5 : 5];
        _zz__zz_readWriteBuffer_0_keep_6 = writeBuffer_keep[5 : 5];
      end
      4'b0110 : begin
        _zz__zz_readWriteBuffer_0_data_6 = writeBuffer_data[55 : 48];
        _zz_readWriteBuffer_1_14 = writeBufferValid[6 : 6];
        _zz__zz_readWriteBuffer_0_keep_6 = writeBuffer_keep[6 : 6];
      end
      4'b0111 : begin
        _zz__zz_readWriteBuffer_0_data_6 = writeBuffer_data[63 : 56];
        _zz_readWriteBuffer_1_14 = writeBufferValid[7 : 7];
        _zz__zz_readWriteBuffer_0_keep_6 = writeBuffer_keep[7 : 7];
      end
      default : begin
        _zz__zz_readWriteBuffer_0_data_6 = writeBuffer_data[71 : 64];
        _zz_readWriteBuffer_1_14 = writeBufferValid[8 : 8];
        _zz__zz_readWriteBuffer_0_keep_6 = writeBuffer_keep[8 : 8];
      end
    endcase
  end

  always @(*) begin
    case(_zz_readWriteBuffer_1_7)
      4'b0000 : begin
        _zz__zz_readWriteBuffer_0_data_7 = writeBuffer_data[7 : 0];
        _zz_readWriteBuffer_1_15 = writeBufferValid[0 : 0];
        _zz__zz_readWriteBuffer_0_keep_7 = writeBuffer_keep[0 : 0];
      end
      4'b0001 : begin
        _zz__zz_readWriteBuffer_0_data_7 = writeBuffer_data[15 : 8];
        _zz_readWriteBuffer_1_15 = writeBufferValid[1 : 1];
        _zz__zz_readWriteBuffer_0_keep_7 = writeBuffer_keep[1 : 1];
      end
      4'b0010 : begin
        _zz__zz_readWriteBuffer_0_data_7 = writeBuffer_data[23 : 16];
        _zz_readWriteBuffer_1_15 = writeBufferValid[2 : 2];
        _zz__zz_readWriteBuffer_0_keep_7 = writeBuffer_keep[2 : 2];
      end
      4'b0011 : begin
        _zz__zz_readWriteBuffer_0_data_7 = writeBuffer_data[31 : 24];
        _zz_readWriteBuffer_1_15 = writeBufferValid[3 : 3];
        _zz__zz_readWriteBuffer_0_keep_7 = writeBuffer_keep[3 : 3];
      end
      4'b0100 : begin
        _zz__zz_readWriteBuffer_0_data_7 = writeBuffer_data[39 : 32];
        _zz_readWriteBuffer_1_15 = writeBufferValid[4 : 4];
        _zz__zz_readWriteBuffer_0_keep_7 = writeBuffer_keep[4 : 4];
      end
      4'b0101 : begin
        _zz__zz_readWriteBuffer_0_data_7 = writeBuffer_data[47 : 40];
        _zz_readWriteBuffer_1_15 = writeBufferValid[5 : 5];
        _zz__zz_readWriteBuffer_0_keep_7 = writeBuffer_keep[5 : 5];
      end
      4'b0110 : begin
        _zz__zz_readWriteBuffer_0_data_7 = writeBuffer_data[55 : 48];
        _zz_readWriteBuffer_1_15 = writeBufferValid[6 : 6];
        _zz__zz_readWriteBuffer_0_keep_7 = writeBuffer_keep[6 : 6];
      end
      4'b0111 : begin
        _zz__zz_readWriteBuffer_0_data_7 = writeBuffer_data[63 : 56];
        _zz_readWriteBuffer_1_15 = writeBufferValid[7 : 7];
        _zz__zz_readWriteBuffer_0_keep_7 = writeBuffer_keep[7 : 7];
      end
      default : begin
        _zz__zz_readWriteBuffer_0_data_7 = writeBuffer_data[71 : 64];
        _zz_readWriteBuffer_1_15 = writeBufferValid[8 : 8];
        _zz__zz_readWriteBuffer_0_keep_7 = writeBuffer_keep[8 : 8];
      end
    endcase
  end

  always @(*) begin
    fillLevel_next_2 = fillLevel_next_1;
    if(inStage_fire) begin
      fillLevel_next_2 = (fillLevel_next_1 + writeBytes);
    end
    if(when_Axi4StreamWidthAdapter_l195) begin
      fillLevel_next_2 = 3'b000;
    end
  end

  always @(*) begin
    fillLevel_next_1 = fillLevel_next;
    if(outStream_fire) begin
      fillLevel_next_1 = (fillLevel - 3'b001);
    end
  end

  always @(*) begin
    writeBytes_preReg_1 = writeBytes_preReg;
    if(inCompact_valid) begin
      writeBytes_preReg_1 = 3'b100;
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
  assign writeBytes_preReg = 3'b000;
  assign inCompact_fire = (inCompact_valid && inCompact_ready);
  assign outStream_valid = (bufferValid[0] || bufferLast);
  assign outStream_payload_data = buffer_data[7 : 0];
  assign outStream_payload_keep = buffer_keep[0 : 0];
  assign outStream_payload_last = (bufferLast && (! bufferValid[1]));
  assign fillLevel_next = fillLevel;
  assign outStream_fire = (outStream_valid && outStream_ready);
  assign inStage_fire = (inStage_valid && inStage_ready);
  assign when_Axi4StreamWidthAdapter_l195 = (outStream_payload_last && outStream_fire);
  assign _zz_writeBuffer_data_1 = 8'h0;
  assign _zz_writeBufferValid = 1'b0;
  assign _zz_writeBuffer_keep_1 = 1'b0;
  assign _zz_writeBuffer_data_2 = {{_zz_writeBuffer_data_1,buffer_data[7 : 0]},inStage_payload_data};
  assign _zz_2 = zz__zz_writeBufferValid_1(1'b0);
  always @(*) _zz_writeBufferValid_1 = _zz_2;
  assign _zz_writeBufferValid_2 = {{_zz_writeBufferValid,bufferValid[0 : 0]},_zz_writeBufferValid_1};
  assign _zz_writeBuffer_keep_2 = {{_zz_writeBuffer_keep_1,buffer_keep[0 : 0]},inStage_payload_keep};
  always @(*) begin
    if(inStage_fire) begin
      _zz_writeBufferValid_3 = _zz__zz_writeBufferValid_3;
    end else begin
      _zz_writeBufferValid_3 = 3'b100;
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
  assign _zz_3 = zz__zz_writeBufferValid_4(1'b0);
  always @(*) _zz_writeBufferValid_4 = _zz_3;
  assign _zz_writeBufferValid_5 = {{_zz_writeBufferValid,bufferValid[1 : 1]},_zz_writeBufferValid_4};
  assign _zz_writeBuffer_keep_3 = {{_zz_writeBuffer_keep_1,buffer_keep[1 : 1]},inStage_payload_keep};
  always @(*) begin
    if(inStage_fire) begin
      _zz_writeBufferValid_6 = _zz__zz_writeBufferValid_6;
    end else begin
      _zz_writeBufferValid_6 = 3'b100;
    end
  end

  assign _zz_writeBuffer_data_4 = {{_zz_writeBuffer_data_1,buffer_data[23 : 16]},inStage_payload_data};
  assign _zz_4 = zz__zz_writeBufferValid_7(1'b0);
  always @(*) _zz_writeBufferValid_7 = _zz_4;
  assign _zz_writeBufferValid_8 = {{_zz_writeBufferValid,bufferValid[2 : 2]},_zz_writeBufferValid_7};
  assign _zz_writeBuffer_keep_4 = {{_zz_writeBuffer_keep_1,buffer_keep[2 : 2]},inStage_payload_keep};
  always @(*) begin
    if(inStage_fire) begin
      _zz_writeBufferValid_9 = _zz__zz_writeBufferValid_9;
    end else begin
      _zz_writeBufferValid_9 = 3'b100;
    end
  end

  assign _zz_writeBuffer_data_5 = {{_zz_writeBuffer_data_1,buffer_data[31 : 24]},inStage_payload_data};
  assign _zz_5 = zz__zz_writeBufferValid_10(1'b0);
  always @(*) _zz_writeBufferValid_10 = _zz_5;
  assign _zz_writeBufferValid_11 = {{_zz_writeBufferValid,bufferValid[3 : 3]},_zz_writeBufferValid_10};
  assign _zz_writeBuffer_keep_5 = {{_zz_writeBuffer_keep_1,buffer_keep[3 : 3]},inStage_payload_keep};
  always @(*) begin
    if(inStage_fire) begin
      _zz_writeBufferValid_12 = _zz__zz_writeBufferValid_12;
    end else begin
      _zz_writeBufferValid_12 = 3'b100;
    end
  end

  assign _zz_writeBuffer_data_6 = {{_zz_writeBuffer_data_1,buffer_data[39 : 32]},inStage_payload_data};
  assign _zz_6 = zz__zz_writeBufferValid_13(1'b0);
  always @(*) _zz_writeBufferValid_13 = _zz_6;
  assign _zz_writeBufferValid_14 = {{_zz_writeBufferValid,bufferValid[4 : 4]},_zz_writeBufferValid_13};
  assign _zz_writeBuffer_keep_6 = {{_zz_writeBuffer_keep_1,buffer_keep[4 : 4]},inStage_payload_keep};
  always @(*) begin
    if(inStage_fire) begin
      _zz_writeBufferValid_15 = _zz__zz_writeBufferValid_15;
    end else begin
      _zz_writeBufferValid_15 = 3'b100;
    end
  end

  assign _zz_writeBuffer_data_7 = {{_zz_writeBuffer_data_1,buffer_data[47 : 40]},inStage_payload_data};
  assign _zz_7 = zz__zz_writeBufferValid_16(1'b0);
  always @(*) _zz_writeBufferValid_16 = _zz_7;
  assign _zz_writeBufferValid_17 = {{_zz_writeBufferValid,bufferValid[5 : 5]},_zz_writeBufferValid_16};
  assign _zz_writeBuffer_keep_7 = {{_zz_writeBuffer_keep_1,buffer_keep[5 : 5]},inStage_payload_keep};
  always @(*) begin
    if(inStage_fire) begin
      _zz_writeBufferValid_18 = _zz__zz_writeBufferValid_18;
    end else begin
      _zz_writeBufferValid_18 = 3'b100;
    end
  end

  assign _zz_writeBuffer_data_8 = {{_zz_writeBuffer_data_1,buffer_data[55 : 48]},inStage_payload_data};
  assign _zz_8 = zz__zz_writeBufferValid_19(1'b0);
  always @(*) _zz_writeBufferValid_19 = _zz_8;
  assign _zz_writeBufferValid_20 = {{_zz_writeBufferValid,bufferValid[6 : 6]},_zz_writeBufferValid_19};
  assign _zz_writeBuffer_keep_8 = {{_zz_writeBuffer_keep_1,buffer_keep[6 : 6]},inStage_payload_keep};
  always @(*) begin
    if(inStage_fire) begin
      _zz_writeBufferValid_21 = _zz__zz_writeBufferValid_21;
    end else begin
      _zz_writeBufferValid_21 = 3'b100;
    end
  end

  assign _zz_writeBuffer_data_9 = {{_zz_writeBuffer_data_1,buffer_data[63 : 56]},inStage_payload_data};
  assign _zz_9 = zz__zz_writeBufferValid_22(1'b0);
  always @(*) _zz_writeBufferValid_22 = _zz_9;
  assign _zz_writeBufferValid_23 = {{_zz_writeBufferValid,bufferValid[7 : 7]},_zz_writeBufferValid_22};
  assign _zz_writeBuffer_keep_9 = {{_zz_writeBuffer_keep_1,buffer_keep[7 : 7]},inStage_payload_keep};
  always @(*) begin
    if(inStage_fire) begin
      _zz_writeBufferValid_24 = _zz__zz_writeBufferValid_24;
    end else begin
      _zz_writeBufferValid_24 = 3'b100;
    end
  end

  assign _zz_writeBuffer_data_10 = {{_zz_writeBuffer_data_1,_zz_writeBuffer_data_1},inStage_payload_data};
  assign _zz_10 = zz__zz_writeBufferValid_25(1'b0);
  always @(*) _zz_writeBufferValid_25 = _zz_10;
  assign _zz_writeBufferValid_26 = {{_zz_writeBufferValid,_zz_writeBufferValid},_zz_writeBufferValid_25};
  assign _zz_writeBuffer_keep_10 = {{_zz_writeBuffer_keep_1,_zz_writeBuffer_keep_1},inStage_payload_keep};
  always @(*) begin
    if(inStage_fire) begin
      _zz_writeBufferValid_27 = _zz__zz_writeBufferValid_27;
    end else begin
      _zz_writeBufferValid_27 = 3'b100;
    end
  end

  assign writeBuffer_data = _zz_writeBuffer_data;
  assign writeBuffer_keep = _zz_writeBuffer_keep;
  assign when_Axi4StreamWidthAdapter_l201 = (inStage_payload_last && inStage_fire);
  assign when_Axi4StreamWidthAdapter_l203 = (start && inStage_fire);
  assign when_Axi4StreamWidthAdapter_l205 = (outStream_payload_last && outStream_fire);
  always @(*) begin
    if(outStream_fire) begin
      _zz_readWriteBuffer_1 = 4'b0001;
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
    _zz_readWriteBuffer_0_data[47 : 40] = _zz__zz_readWriteBuffer_0_data_5;
    _zz_readWriteBuffer_0_data[55 : 48] = _zz__zz_readWriteBuffer_0_data_6;
    _zz_readWriteBuffer_0_data[63 : 56] = _zz__zz_readWriteBuffer_0_data_7;
  end

  always @(*) begin
    readWriteBuffer_1[0 : 0] = _zz_readWriteBuffer_1_8;
    readWriteBuffer_1[1 : 1] = _zz_readWriteBuffer_1_9;
    readWriteBuffer_1[2 : 2] = _zz_readWriteBuffer_1_10;
    readWriteBuffer_1[3 : 3] = _zz_readWriteBuffer_1_11;
    readWriteBuffer_1[4 : 4] = _zz_readWriteBuffer_1_12;
    readWriteBuffer_1[5 : 5] = _zz_readWriteBuffer_1_13;
    readWriteBuffer_1[6 : 6] = _zz_readWriteBuffer_1_14;
    readWriteBuffer_1[7 : 7] = _zz_readWriteBuffer_1_15;
  end

  always @(*) begin
    _zz_readWriteBuffer_0_keep[0 : 0] = _zz__zz_readWriteBuffer_0_keep;
    _zz_readWriteBuffer_0_keep[1 : 1] = _zz__zz_readWriteBuffer_0_keep_1;
    _zz_readWriteBuffer_0_keep[2 : 2] = _zz__zz_readWriteBuffer_0_keep_2;
    _zz_readWriteBuffer_0_keep[3 : 3] = _zz__zz_readWriteBuffer_0_keep_3;
    _zz_readWriteBuffer_0_keep[4 : 4] = _zz__zz_readWriteBuffer_0_keep_4;
    _zz_readWriteBuffer_0_keep[5 : 5] = _zz__zz_readWriteBuffer_0_keep_5;
    _zz_readWriteBuffer_0_keep[6 : 6] = _zz__zz_readWriteBuffer_0_keep_6;
    _zz_readWriteBuffer_0_keep[7 : 7] = _zz__zz_readWriteBuffer_0_keep_7;
  end

  always @(*) begin
    if(outStream_fire) begin
      _zz_readWriteBuffer_1_1 = 4'b0010;
    end else begin
      _zz_readWriteBuffer_1_1 = 4'b0001;
    end
  end

  always @(*) begin
    if(outStream_fire) begin
      _zz_readWriteBuffer_1_2 = 4'b0011;
    end else begin
      _zz_readWriteBuffer_1_2 = 4'b0010;
    end
  end

  always @(*) begin
    if(outStream_fire) begin
      _zz_readWriteBuffer_1_3 = 4'b0100;
    end else begin
      _zz_readWriteBuffer_1_3 = 4'b0011;
    end
  end

  always @(*) begin
    if(outStream_fire) begin
      _zz_readWriteBuffer_1_4 = 4'b0101;
    end else begin
      _zz_readWriteBuffer_1_4 = 4'b0100;
    end
  end

  always @(*) begin
    if(outStream_fire) begin
      _zz_readWriteBuffer_1_5 = 4'b0110;
    end else begin
      _zz_readWriteBuffer_1_5 = 4'b0101;
    end
  end

  always @(*) begin
    if(outStream_fire) begin
      _zz_readWriteBuffer_1_6 = 4'b0111;
    end else begin
      _zz_readWriteBuffer_1_6 = 4'b0110;
    end
  end

  always @(*) begin
    if(outStream_fire) begin
      _zz_readWriteBuffer_1_7 = 4'b1000;
    end else begin
      _zz_readWriteBuffer_1_7 = 4'b0111;
    end
  end

  assign readWriteBuffer_0_data = _zz_readWriteBuffer_0_data;
  assign readWriteBuffer_0_keep = _zz_readWriteBuffer_0_keep;
  assign when_Axi4StreamWidthAdapter_l216 = (outStream_payload_last && outStream_fire);
  assign when_Axi4StreamWidthAdapter_l218 = (inStage_fire || outStream_fire);
  assign canWrite = (! _zz_canWrite[writeBytes]);
  assign canWriteWhenRead = (writeBytes <= 3'b001);
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
  always @(posedge clk or posedge reset) begin
    if(reset) begin
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
        buffer_keep <= readWriteBuffer_0_keep;
        bufferValid <= readWriteBuffer_1;
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
      buffer_data <= readWriteBuffer_0_data;
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
