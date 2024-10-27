// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : AxiStreamWidthAdaptorI32O8
// Git hash  : 5b8c89a8721bcf5aa6757eedc649f6094158d0d3

`timescale 1ns/1ps 
module AxiStreamWidthAdaptorI32O8 (
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in TVALID" *) input  wire          i_valid,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in TREADY" *) output wire          i_ready,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in TDATA" *) input  wire [255:0]  i_payload_data,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in TKEEP" *) input  wire [31:0]   i_payload_keep,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in TLAST" *) input  wire          i_payload_last,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out TVALID" *) output wire          o_valid,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out TREADY" *) input  wire          o_ready,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out TDATA" *) output wire [63:0]   o_payload_data,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out TKEEP" *) output wire [7:0]    o_payload_keep,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out TLAST" *) output wire          o_payload_last,
  input  wire          clk,
  input  wire          reset
);

  wire                axi4StreamWidthAdapter_1_io_axis_s_ready;
  wire                axi4StreamWidthAdapter_1_io_axis_m_valid;
  wire       [63:0]   axi4StreamWidthAdapter_1_io_axis_m_payload_data;
  wire       [7:0]    axi4StreamWidthAdapter_1_io_axis_m_payload_keep;
  wire                axi4StreamWidthAdapter_1_io_axis_m_payload_last;

  Axi4StreamWidthAdapter axi4StreamWidthAdapter_1 (
    .io_axis_s_valid        (i_valid                                              ), //i
    .io_axis_s_ready        (axi4StreamWidthAdapter_1_io_axis_s_ready             ), //o
    .io_axis_s_payload_data (i_payload_data[255:0]                                ), //i
    .io_axis_s_payload_keep (i_payload_keep[31:0]                                 ), //i
    .io_axis_s_payload_last (i_payload_last                                       ), //i
    .io_axis_m_valid        (axi4StreamWidthAdapter_1_io_axis_m_valid             ), //o
    .io_axis_m_ready        (o_ready                                              ), //i
    .io_axis_m_payload_data (axi4StreamWidthAdapter_1_io_axis_m_payload_data[63:0]), //o
    .io_axis_m_payload_keep (axi4StreamWidthAdapter_1_io_axis_m_payload_keep[7:0] ), //o
    .io_axis_m_payload_last (axi4StreamWidthAdapter_1_io_axis_m_payload_last      ), //o
    .clk                    (clk                                                  ), //i
    .reset                  (reset                                                )  //i
  );
  assign i_ready = axi4StreamWidthAdapter_1_io_axis_s_ready;
  assign o_valid = axi4StreamWidthAdapter_1_io_axis_m_valid;
  assign o_payload_data = axi4StreamWidthAdapter_1_io_axis_m_payload_data;
  assign o_payload_keep = axi4StreamWidthAdapter_1_io_axis_m_payload_keep;
  assign o_payload_last = axi4StreamWidthAdapter_1_io_axis_m_payload_last;

endmodule
