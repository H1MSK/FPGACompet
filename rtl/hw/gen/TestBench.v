// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : TestBench
// Git hash  : 860e2238d66f92e27272c2919413e60a7e624acd

`timescale 1ns/1ps 
module TestBench (
  input  wire          io_axilite_aw_valid,
  output wire          io_axilite_aw_ready,
  input  wire [13:0]   io_axilite_aw_payload_addr,
  input  wire [2:0]    io_axilite_aw_payload_prot,
  input  wire          io_axilite_w_valid,
  output wire          io_axilite_w_ready,
  input  wire [31:0]   io_axilite_w_payload_data,
  input  wire [3:0]    io_axilite_w_payload_strb,
  output wire          io_axilite_b_valid,
  input  wire          io_axilite_b_ready,
  output wire [1:0]    io_axilite_b_payload_resp,
  input  wire          io_axilite_ar_valid,
  output wire          io_axilite_ar_ready,
  input  wire [13:0]   io_axilite_ar_payload_addr,
  input  wire [2:0]    io_axilite_ar_payload_prot,
  output wire          io_axilite_r_valid,
  input  wire          io_axilite_r_ready,
  output wire [31:0]   io_axilite_r_payload_data,
  output wire [1:0]    io_axilite_r_payload_resp,
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
  input  wire          resetn,
  input  wire          clk
);

  wire                down_i_ready;
  wire                down_o_valid;
  wire       [7:0]    down_o_payload_data;
  wire       [0:0]    down_o_payload_keep;
  wire                down_o_payload_last;
  wire                regs_axilite_aw_ready;
  wire                regs_axilite_w_ready;
  wire                regs_axilite_b_valid;
  wire       [1:0]    regs_axilite_b_payload_resp;
  wire                regs_axilite_ar_ready;
  wire                regs_axilite_r_valid;
  wire       [31:0]   regs_axilite_r_payload_data;
  wire       [1:0]    regs_axilite_r_payload_resp;
  wire                regs_out_busy;
  wire       [7:0]    regs_out_coeff_0;
  wire       [7:0]    regs_out_coeff_1;
  wire       [7:0]    regs_out_coeff_2;
  wire       [7:0]    regs_out_coeff_3;
  wire       [7:0]    regs_out_coeff_4;
  wire       [7:0]    regs_out_coeff_5;
  wire       [7:0]    regs_out_thres_0;
  wire       [7:0]    regs_out_thres_1;
  wire                ip_gauss_axi_ready;
  wire                ip_dualth_axi_valid;
  wire       [7:0]    ip_dualth_axi_dout;
  wire       [0:0]    ip_dualth_axi_keep;
  wire                ip_dualth_axi_last;
  wire                up_i_ready;
  wire                up_o_valid;
  wire       [31:0]   up_o_payload_data;
  wire       [3:0]    up_o_payload_keep;
  wire                up_o_payload_last;

  AxiStreamWidthAdaptorI32O8 down (
    .i_valid        (io_i_valid              ), //i
    .i_ready        (down_i_ready            ), //o
    .i_payload_data (io_i_payload_data[31:0] ), //i
    .i_payload_keep (io_i_payload_keep[3:0]  ), //i
    .i_payload_last (io_i_payload_last       ), //i
    .o_valid        (down_o_valid            ), //o
    .o_ready        (ip_gauss_axi_ready      ), //i
    .o_payload_data (down_o_payload_data[7:0]), //o
    .o_payload_keep (down_o_payload_keep     ), //o
    .o_payload_last (down_o_payload_last     ), //o
    .clk            (clk                     ), //i
    .resetn         (resetn                  )  //i
  );
  AxiLiteRegs regs (
    .axilite_aw_valid        (io_axilite_aw_valid              ), //i
    .axilite_aw_ready        (regs_axilite_aw_ready            ), //o
    .axilite_aw_payload_addr (io_axilite_aw_payload_addr[13:0] ), //i
    .axilite_aw_payload_prot (io_axilite_aw_payload_prot[2:0]  ), //i
    .axilite_w_valid         (io_axilite_w_valid               ), //i
    .axilite_w_ready         (regs_axilite_w_ready             ), //o
    .axilite_w_payload_data  (io_axilite_w_payload_data[31:0]  ), //i
    .axilite_w_payload_strb  (io_axilite_w_payload_strb[3:0]   ), //i
    .axilite_b_valid         (regs_axilite_b_valid             ), //o
    .axilite_b_ready         (io_axilite_b_ready               ), //i
    .axilite_b_payload_resp  (regs_axilite_b_payload_resp[1:0] ), //o
    .axilite_ar_valid        (io_axilite_ar_valid              ), //i
    .axilite_ar_ready        (regs_axilite_ar_ready            ), //o
    .axilite_ar_payload_addr (io_axilite_ar_payload_addr[13:0] ), //i
    .axilite_ar_payload_prot (io_axilite_ar_payload_prot[2:0]  ), //i
    .axilite_r_valid         (regs_axilite_r_valid             ), //o
    .axilite_r_ready         (io_axilite_r_ready               ), //i
    .axilite_r_payload_data  (regs_axilite_r_payload_data[31:0]), //o
    .axilite_r_payload_resp  (regs_axilite_r_payload_resp[1:0] ), //o
    .in_ip_output_valid      (ip_dualth_axi_valid              ), //i
    .in_ip_output_ready      (up_i_ready                       ), //i
    .in_ip_output_last       (ip_dualth_axi_last               ), //i
    .out_busy                (regs_out_busy                    ), //o
    .out_coeff_0             (regs_out_coeff_0[7:0]            ), //o
    .out_coeff_1             (regs_out_coeff_1[7:0]            ), //o
    .out_coeff_2             (regs_out_coeff_2[7:0]            ), //o
    .out_coeff_3             (regs_out_coeff_3[7:0]            ), //o
    .out_coeff_4             (regs_out_coeff_4[7:0]            ), //o
    .out_coeff_5             (regs_out_coeff_5[7:0]            ), //o
    .out_thres_0             (regs_out_thres_0[7:0]            ), //o
    .out_thres_1             (regs_out_thres_1[7:0]            ), //o
    .clk                     (clk                              ), //i
    .resetn                  (resetn                           )  //i
  );
  TopBlackbox ip (
    .clk              (clk                     ), //i
    .rst_n            (resetn                  ), //i
    .axi_valid        (down_o_valid            ), //i
    .gauss_axi_ready  (ip_gauss_axi_ready      ), //o
    .axi_data_in      (down_o_payload_data[7:0]), //i
    .axi_keep         (down_o_payload_keep     ), //i
    .axi_last         (down_o_payload_last     ), //i
    .coe_00_in        (regs_out_coeff_0[7:0]   ), //i
    .coe_01_in        (regs_out_coeff_1[7:0]   ), //i
    .coe_02_in        (regs_out_coeff_2[7:0]   ), //i
    .coe_11_in        (regs_out_coeff_3[7:0]   ), //i
    .coe_12_in        (regs_out_coeff_4[7:0]   ), //i
    .coe_22_in        (regs_out_coeff_5[7:0]   ), //i
    .gtl              (regs_out_thres_0[7:0]   ), //i
    .gth              (regs_out_thres_1[7:0]   ), //i
    .dualth_axi_valid (ip_dualth_axi_valid     ), //o
    .dualth_axi_ready (up_i_ready              ), //i
    .dualth_axi_dout  (ip_dualth_axi_dout[7:0] ), //o
    .dualth_axi_keep  (ip_dualth_axi_keep      ), //o
    .dualth_axi_last  (ip_dualth_axi_last      )  //o
  );
  AxiStreamWidthAdaptorI8O32 up (
    .i_valid        (ip_dualth_axi_valid    ), //i
    .i_ready        (up_i_ready             ), //o
    .i_payload_data (ip_dualth_axi_dout[7:0]), //i
    .i_payload_keep (ip_dualth_axi_keep     ), //i
    .i_payload_last (ip_dualth_axi_last     ), //i
    .o_valid        (up_o_valid             ), //o
    .o_ready        (io_o_ready             ), //i
    .o_payload_data (up_o_payload_data[31:0]), //o
    .o_payload_keep (up_o_payload_keep[3:0] ), //o
    .o_payload_last (up_o_payload_last      ), //o
    .clk            (clk                    ), //i
    .resetn         (resetn                 )  //i
  );
  assign io_i_ready = down_i_ready;
  assign io_o_valid = up_o_valid;
  assign io_o_payload_data = up_o_payload_data;
  assign io_o_payload_keep = up_o_payload_keep;
  assign io_o_payload_last = up_o_payload_last;
  assign io_axilite_aw_ready = regs_axilite_aw_ready;
  assign io_axilite_w_ready = regs_axilite_w_ready;
  assign io_axilite_b_valid = regs_axilite_b_valid;
  assign io_axilite_b_payload_resp = regs_axilite_b_payload_resp;
  assign io_axilite_ar_ready = regs_axilite_ar_ready;
  assign io_axilite_r_valid = regs_axilite_r_valid;
  assign io_axilite_r_payload_data = regs_axilite_r_payload_data;
  assign io_axilite_r_payload_resp = regs_axilite_r_payload_resp;

endmodule
