// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : FakeTop
// Git hash  : ac0494d18a5b48ded8fc83c7b055311a95923fb8

`timescale 1ns/1ps 
module FakeTop (
  input  wire          io_i_valid,
  output wire          io_i_ready,
  input  wire [31:0]   io_i_payload_data,
  input  wire [3:0]    io_i_payload_keep,
  input  wire          io_i_payload_last,
  output wire          io_o_valid,
  input  wire          io_o_ready,
  output wire [31:0]   io_o_payload_data,
  output wire [3:0]    io_o_payload_keep,
  output wire          io_o_payload_last,
  input  wire          clk,
  input  wire          reset
);

  wire                down_i_ready;
  wire                down_o_valid;
  wire       [7:0]    down_o_payload_data;
  wire       [0:0]    down_o_payload_keep;
  wire                down_o_payload_last;
  wire                up_i_ready;
  wire                up_o_valid;
  wire       [31:0]   up_o_payload_data;
  wire       [3:0]    up_o_payload_keep;
  wire                up_o_payload_last;
  wire                mid_valid;
  wire                mid_ready;
  wire       [7:0]    mid_payload_data;
  wire       [0:0]    mid_payload_keep;
  wire                mid_payload_last;

  AxiStreamWidthAdaptorI32O8 down (
    .i_valid        (io_i_valid              ), //i
    .i_ready        (down_i_ready            ), //o
    .i_payload_data (io_i_payload_data[31:0] ), //i
    .i_payload_keep (io_i_payload_keep[3:0]  ), //i
    .i_payload_last (io_i_payload_last       ), //i
    .o_valid        (down_o_valid            ), //o
    .o_ready        (mid_ready               ), //i
    .o_payload_data (down_o_payload_data[7:0]), //o
    .o_payload_keep (down_o_payload_keep     ), //o
    .o_payload_last (down_o_payload_last     ), //o
    .clk            (clk                     ), //i
    .reset          (reset                   )  //i
  );
  AxiStreamWidthAdaptorI8O32 up (
    .i_valid        (mid_valid              ), //i
    .i_ready        (up_i_ready             ), //o
    .i_payload_data (mid_payload_data[7:0]  ), //i
    .i_payload_keep (mid_payload_keep       ), //i
    .i_payload_last (mid_payload_last       ), //i
    .o_valid        (up_o_valid             ), //o
    .o_ready        (io_o_ready             ), //i
    .o_payload_data (up_o_payload_data[31:0]), //o
    .o_payload_keep (up_o_payload_keep[3:0] ), //o
    .o_payload_last (up_o_payload_last      ), //o
    .clk            (clk                    ), //i
    .reset          (reset                  )  //i
  );
  assign io_i_ready = down_i_ready;
  assign mid_valid = down_o_valid;
  assign mid_payload_data = down_o_payload_data;
  assign mid_payload_keep = down_o_payload_keep;
  assign mid_payload_last = down_o_payload_last;
  assign mid_ready = up_i_ready;
  assign io_o_valid = up_o_valid;
  assign io_o_payload_data = up_o_payload_data;
  assign io_o_payload_keep = up_o_payload_keep;
  assign io_o_payload_last = up_o_payload_last;

endmodule
