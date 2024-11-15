// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : AxiStreamWidthAdaptorI8O32
// Git hash  : ac106a508d16e27cfe6f32162015da1ba0ee7336

`timescale 1ns/1ps 
module AxiStreamWidthAdaptorI8O32 (
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 sin TVALID" *) input  wire          i_valid,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 sin TREADY" *) output wire          i_ready,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 sin TDATA" *) input  wire [7:0]    i_payload_data,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 sin TKEEP" *) input  wire [0:0]    i_payload_keep,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 sin TLAST" *) input  wire          i_payload_last,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 sout TVALID" *) output wire          o_valid,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 sout TREADY" *) input  wire          o_ready,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 sout TDATA" *) output wire [31:0]   o_payload_data,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 sout TKEEP" *) output wire [3:0]    o_payload_keep,
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 sout TLAST" *) output wire          o_payload_last,
  input  wire          clk,
  input  wire          resetn
);

  wire                axi4StreamWidthAdapter_2_io_axis_s_ready;
  wire                axi4StreamWidthAdapter_2_io_axis_m_valid;
  wire       [31:0]   axi4StreamWidthAdapter_2_io_axis_m_payload_data;
  wire       [3:0]    axi4StreamWidthAdapter_2_io_axis_m_payload_keep;
  wire                axi4StreamWidthAdapter_2_io_axis_m_payload_last;

  Axi4StreamWidthAdapter axi4StreamWidthAdapter_2 (
    .io_axis_s_valid        (i_valid                                              ), //i
    .io_axis_s_ready        (axi4StreamWidthAdapter_2_io_axis_s_ready             ), //o
    .io_axis_s_payload_data (i_payload_data[7:0]                                  ), //i
    .io_axis_s_payload_keep (i_payload_keep                                       ), //i
    .io_axis_s_payload_last (i_payload_last                                       ), //i
    .io_axis_m_valid        (axi4StreamWidthAdapter_2_io_axis_m_valid             ), //o
    .io_axis_m_ready        (o_ready                                              ), //i
    .io_axis_m_payload_data (axi4StreamWidthAdapter_2_io_axis_m_payload_data[31:0]), //o
    .io_axis_m_payload_keep (axi4StreamWidthAdapter_2_io_axis_m_payload_keep[3:0] ), //o
    .io_axis_m_payload_last (axi4StreamWidthAdapter_2_io_axis_m_payload_last      ), //o
    .clk                    (clk                                                  ), //i
    .resetn                 (resetn                                               )  //i
  );
  assign i_ready = axi4StreamWidthAdapter_2_io_axis_s_ready;
  assign o_valid = axi4StreamWidthAdapter_2_io_axis_m_valid;
  assign o_payload_data = axi4StreamWidthAdapter_2_io_axis_m_payload_data;
  assign o_payload_keep = axi4StreamWidthAdapter_2_io_axis_m_payload_keep;
  assign o_payload_last = axi4StreamWidthAdapter_2_io_axis_m_payload_last;

endmodule
