// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : AxiLiteRegs
// Git hash  : ac106a508d16e27cfe6f32162015da1ba0ee7336

`timescale 1ns/1ps 
module AxiLiteRegs (
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axilite AWVALID" *) input  wire          axilite_aw_valid,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axilite AWREADY" *) output wire          axilite_aw_ready,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axilite AWADDR" *) input  wire [13:0]   axilite_aw_payload_addr,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axilite AWPROT" *) input  wire [2:0]    axilite_aw_payload_prot,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axilite WVALID" *) input  wire          axilite_w_valid,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axilite WREADY" *) output wire          axilite_w_ready,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axilite WDATA" *) input  wire [31:0]   axilite_w_payload_data,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axilite WSTRB" *) input  wire [3:0]    axilite_w_payload_strb,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axilite BVALID" *) output wire          axilite_b_valid,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axilite BREADY" *) input  wire          axilite_b_ready,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axilite BRESP" *) output wire [1:0]    axilite_b_payload_resp,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axilite ARVALID" *) input  wire          axilite_ar_valid,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axilite ARREADY" *) output wire          axilite_ar_ready,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axilite ARADDR" *) input  wire [13:0]   axilite_ar_payload_addr,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axilite ARPROT" *) input  wire [2:0]    axilite_ar_payload_prot,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axilite RVALID" *) output wire          axilite_r_valid,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axilite RREADY" *) input  wire          axilite_r_ready,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axilite RDATA" *) output wire [31:0]   axilite_r_payload_data,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 axilite RRESP" *) output wire [1:0]    axilite_r_payload_resp,
  input  wire          in_ip_output_valid,
  input  wire          in_ip_output_ready,
  input  wire          in_ip_output_last,
  output wire          out_busy,
  output wire [7:0]    out_coeff_0,
  output wire [7:0]    out_coeff_1,
  output wire [7:0]    out_coeff_2,
  output wire [7:0]    out_coeff_3,
  output wire [7:0]    out_coeff_4,
  output wire [7:0]    out_coeff_5,
  output wire [7:0]    out_thres_0,
  output wire [7:0]    out_thres_1,
  input  wire          clk,
  input  wire          resetn
);

  wire                adaptor_io_axi_lite_aw_ready;
  wire                adaptor_io_axi_lite_w_ready;
  wire                adaptor_io_axi_lite_b_valid;
  wire       [1:0]    adaptor_io_axi_lite_b_payload_resp;
  wire                adaptor_io_axi_lite_ar_ready;
  wire                adaptor_io_axi_lite_r_valid;
  wire       [31:0]   adaptor_io_axi_lite_r_payload_data;
  wire       [1:0]    adaptor_io_axi_lite_r_payload_resp;
  wire                adaptor_io_csb_req_valid;
  wire       [13:0]   adaptor_io_csb_req_payload_addr;
  wire       [31:0]   adaptor_io_csb_req_payload_wdata;
  wire                adaptor_io_csb_req_payload_wr;
  wire       [0:0]    _zz_f_start;
  wire                csb_req_valid;
  wire                csb_req_ready;
  wire       [13:0]   csb_req_payload_addr;
  wire       [31:0]   csb_req_payload_wdata;
  wire                csb_req_payload_wr;
  wire                csb_resp_valid;
  wire       [31:0]   csb_resp_payload_rdata;
  wire                busif_bus_rderr;
  wire       [31:0]   busif_bus_rdata;
  reg                 busif_reg_rderr;
  reg        [31:0]   busif_reg_rdata;
  wire                busif_askWrite;
  wire                busif_askRead;
  wire                busif_doWrite;
  wire                busif_doRead;
  reg                 _zz_csb_resp_valid;
  wire                read_hit_0x0000;
  wire                write_hit_0x0000;
  reg                 f_start;
  reg                 last_start;
  wire                just_start;
  wire                read_hit_0x0004;
  wire                write_hit_0x0004;
  reg                 f_done;
  wire                read_hit_0x0080;
  wire                write_hit_0x0080;
  wire                read_hit_0x0084;
  wire                write_hit_0x0084;
  reg        [7:0]    f_thres_0;
  reg        [7:0]    f_thres_1;
  wire                read_hit_0x0100;
  wire                write_hit_0x0100;
  wire                read_hit_0x0104;
  wire                write_hit_0x0104;
  wire                read_hit_0x0108;
  wire                write_hit_0x0108;
  wire                read_hit_0x010c;
  wire                write_hit_0x010c;
  wire                read_hit_0x0110;
  wire                write_hit_0x0110;
  wire                read_hit_0x0114;
  wire                write_hit_0x0114;
  reg        [7:0]    f_coeff_0;
  reg        [7:0]    f_coeff_1;
  reg        [7:0]    f_coeff_2;
  reg        [7:0]    f_coeff_3;
  reg        [7:0]    f_coeff_4;
  reg        [7:0]    f_coeff_5;
  wire                ip_output_fire;
  wire                ip_output_last_fire;
  reg                 reg_busy;
  reg                 last_busy;
  wire                busy;

  assign _zz_f_start = 1'b1;
  AxiLite2CSB adaptor (
    .io_axi_lite_aw_valid        (axilite_aw_valid                        ), //i
    .io_axi_lite_aw_ready        (adaptor_io_axi_lite_aw_ready            ), //o
    .io_axi_lite_aw_payload_addr (axilite_aw_payload_addr[13:0]           ), //i
    .io_axi_lite_aw_payload_prot (axilite_aw_payload_prot[2:0]            ), //i
    .io_axi_lite_w_valid         (axilite_w_valid                         ), //i
    .io_axi_lite_w_ready         (adaptor_io_axi_lite_w_ready             ), //o
    .io_axi_lite_w_payload_data  (axilite_w_payload_data[31:0]            ), //i
    .io_axi_lite_w_payload_strb  (axilite_w_payload_strb[3:0]             ), //i
    .io_axi_lite_b_valid         (adaptor_io_axi_lite_b_valid             ), //o
    .io_axi_lite_b_ready         (axilite_b_ready                         ), //i
    .io_axi_lite_b_payload_resp  (adaptor_io_axi_lite_b_payload_resp[1:0] ), //o
    .io_axi_lite_ar_valid        (axilite_ar_valid                        ), //i
    .io_axi_lite_ar_ready        (adaptor_io_axi_lite_ar_ready            ), //o
    .io_axi_lite_ar_payload_addr (axilite_ar_payload_addr[13:0]           ), //i
    .io_axi_lite_ar_payload_prot (axilite_ar_payload_prot[2:0]            ), //i
    .io_axi_lite_r_valid         (adaptor_io_axi_lite_r_valid             ), //o
    .io_axi_lite_r_ready         (axilite_r_ready                         ), //i
    .io_axi_lite_r_payload_data  (adaptor_io_axi_lite_r_payload_data[31:0]), //o
    .io_axi_lite_r_payload_resp  (adaptor_io_axi_lite_r_payload_resp[1:0] ), //o
    .io_csb_req_valid            (adaptor_io_csb_req_valid                ), //o
    .io_csb_req_ready            (csb_req_ready                           ), //i
    .io_csb_req_payload_addr     (adaptor_io_csb_req_payload_addr[13:0]   ), //o
    .io_csb_req_payload_wdata    (adaptor_io_csb_req_payload_wdata[31:0]  ), //o
    .io_csb_req_payload_wr       (adaptor_io_csb_req_payload_wr           ), //o
    .io_csb_resp_valid           (csb_resp_valid                          ), //i
    .io_csb_resp_payload_rdata   (csb_resp_payload_rdata[31:0]            ), //i
    .clk                         (clk                                     ), //i
    .resetn                      (resetn                                  )  //i
  );
  assign axilite_aw_ready = adaptor_io_axi_lite_aw_ready;
  assign axilite_w_ready = adaptor_io_axi_lite_w_ready;
  assign axilite_b_valid = adaptor_io_axi_lite_b_valid;
  assign axilite_b_payload_resp = adaptor_io_axi_lite_b_payload_resp;
  assign axilite_ar_ready = adaptor_io_axi_lite_ar_ready;
  assign axilite_r_valid = adaptor_io_axi_lite_r_valid;
  assign axilite_r_payload_data = adaptor_io_axi_lite_r_payload_data;
  assign axilite_r_payload_resp = adaptor_io_axi_lite_r_payload_resp;
  assign csb_req_valid = adaptor_io_csb_req_valid;
  assign csb_req_payload_addr = adaptor_io_csb_req_payload_addr;
  assign csb_req_payload_wdata = adaptor_io_csb_req_payload_wdata;
  assign csb_req_payload_wr = adaptor_io_csb_req_payload_wr;
  assign busif_askWrite = (csb_req_valid && csb_req_payload_wr);
  assign busif_askRead = (csb_req_valid && (! csb_req_payload_wr));
  assign busif_doWrite = (busif_askWrite && csb_req_ready);
  assign busif_doRead = (busif_askRead && csb_req_ready);
  assign csb_req_ready = csb_req_valid;
  assign csb_resp_valid = _zz_csb_resp_valid;
  assign csb_resp_payload_rdata = busif_bus_rdata;
  assign read_hit_0x0000 = ((csb_req_payload_addr == 14'h0) && busif_doRead);
  assign write_hit_0x0000 = ((csb_req_payload_addr == 14'h0) && busif_doWrite);
  assign just_start = (f_start && (! last_start));
  assign read_hit_0x0004 = ((csb_req_payload_addr == 14'h0004) && busif_doRead);
  assign write_hit_0x0004 = ((csb_req_payload_addr == 14'h0004) && busif_doWrite);
  assign read_hit_0x0080 = ((csb_req_payload_addr == 14'h0080) && busif_doRead);
  assign write_hit_0x0080 = ((csb_req_payload_addr == 14'h0080) && busif_doWrite);
  assign read_hit_0x0084 = ((csb_req_payload_addr == 14'h0084) && busif_doRead);
  assign write_hit_0x0084 = ((csb_req_payload_addr == 14'h0084) && busif_doWrite);
  assign out_thres_0 = f_thres_0;
  assign out_thres_1 = f_thres_1;
  assign read_hit_0x0100 = ((csb_req_payload_addr == 14'h0100) && busif_doRead);
  assign write_hit_0x0100 = ((csb_req_payload_addr == 14'h0100) && busif_doWrite);
  assign read_hit_0x0104 = ((csb_req_payload_addr == 14'h0104) && busif_doRead);
  assign write_hit_0x0104 = ((csb_req_payload_addr == 14'h0104) && busif_doWrite);
  assign read_hit_0x0108 = ((csb_req_payload_addr == 14'h0108) && busif_doRead);
  assign write_hit_0x0108 = ((csb_req_payload_addr == 14'h0108) && busif_doWrite);
  assign read_hit_0x010c = ((csb_req_payload_addr == 14'h010c) && busif_doRead);
  assign write_hit_0x010c = ((csb_req_payload_addr == 14'h010c) && busif_doWrite);
  assign read_hit_0x0110 = ((csb_req_payload_addr == 14'h0110) && busif_doRead);
  assign write_hit_0x0110 = ((csb_req_payload_addr == 14'h0110) && busif_doWrite);
  assign read_hit_0x0114 = ((csb_req_payload_addr == 14'h0114) && busif_doRead);
  assign write_hit_0x0114 = ((csb_req_payload_addr == 14'h0114) && busif_doWrite);
  assign out_coeff_0 = f_coeff_0;
  assign out_coeff_1 = f_coeff_1;
  assign out_coeff_2 = f_coeff_2;
  assign out_coeff_3 = f_coeff_3;
  assign out_coeff_4 = f_coeff_4;
  assign out_coeff_5 = f_coeff_5;
  assign ip_output_fire = (in_ip_output_valid && in_ip_output_ready);
  assign ip_output_last_fire = (ip_output_fire && in_ip_output_last);
  assign busy = (just_start || reg_busy);
  assign out_busy = busy;
  assign busif_bus_rderr = busif_reg_rderr;
  assign busif_bus_rdata = busif_reg_rdata;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      busif_reg_rderr <= 1'b0;
      busif_reg_rdata <= 32'h0;
      _zz_csb_resp_valid <= 1'b0;
      f_start <= 1'b0;
      last_start <= 1'b0;
      f_done <= 1'b0;
      f_thres_0 <= 8'h0;
      f_thres_1 <= 8'h0;
      f_coeff_0 <= 8'h0;
      f_coeff_1 <= 8'h0;
      f_coeff_2 <= 8'h0;
      f_coeff_3 <= 8'h0;
      f_coeff_4 <= 8'h0;
      f_coeff_5 <= 8'h0;
      reg_busy <= 1'b0;
      last_busy <= 1'b0;
    end else begin
      _zz_csb_resp_valid <= (busif_doRead || busif_doWrite);
      if(write_hit_0x0000) begin
        f_start <= _zz_f_start[0];
      end
      last_start <= f_start;
      if(read_hit_0x0004) begin
        f_done <= 1'b0;
      end
      if(write_hit_0x0080) begin
        f_thres_0 <= csb_req_payload_wdata[7 : 0];
      end
      if(write_hit_0x0084) begin
        f_thres_1 <= csb_req_payload_wdata[7 : 0];
      end
      if(write_hit_0x0100) begin
        f_coeff_0 <= csb_req_payload_wdata[7 : 0];
      end
      if(write_hit_0x0104) begin
        f_coeff_1 <= csb_req_payload_wdata[7 : 0];
      end
      if(write_hit_0x0108) begin
        f_coeff_2 <= csb_req_payload_wdata[7 : 0];
      end
      if(write_hit_0x010c) begin
        f_coeff_3 <= csb_req_payload_wdata[7 : 0];
      end
      if(write_hit_0x0110) begin
        f_coeff_4 <= csb_req_payload_wdata[7 : 0];
      end
      if(write_hit_0x0114) begin
        f_coeff_5 <= csb_req_payload_wdata[7 : 0];
      end
      if(just_start) begin
        reg_busy <= 1'b1;
      end
      if(ip_output_last_fire) begin
        reg_busy <= 1'b0;
      end
      last_busy <= reg_busy;
      if(ip_output_last_fire) begin
        f_done <= 1'b1;
      end
      if(ip_output_last_fire) begin
        f_start <= 1'b0;
      end
      if(busif_askRead) begin
        case(csb_req_payload_addr)
          14'h0 : begin
            busif_reg_rdata <= {31'h0,f_start};
            busif_reg_rderr <= 1'b0;
          end
          14'h0004 : begin
            busif_reg_rdata <= {31'h0,f_done};
            busif_reg_rderr <= 1'b0;
          end
          14'h0080 : begin
            busif_reg_rdata <= {24'h0,f_thres_0};
            busif_reg_rderr <= 1'b0;
          end
          14'h0084 : begin
            busif_reg_rdata <= {24'h0,f_thres_1};
            busif_reg_rderr <= 1'b0;
          end
          14'h0100 : begin
            busif_reg_rdata <= {24'h0,f_coeff_0};
            busif_reg_rderr <= 1'b0;
          end
          14'h0104 : begin
            busif_reg_rdata <= {24'h0,f_coeff_1};
            busif_reg_rderr <= 1'b0;
          end
          14'h0108 : begin
            busif_reg_rdata <= {24'h0,f_coeff_2};
            busif_reg_rderr <= 1'b0;
          end
          14'h010c : begin
            busif_reg_rdata <= {24'h0,f_coeff_3};
            busif_reg_rderr <= 1'b0;
          end
          14'h0110 : begin
            busif_reg_rdata <= {24'h0,f_coeff_4};
            busif_reg_rderr <= 1'b0;
          end
          14'h0114 : begin
            busif_reg_rdata <= {24'h0,f_coeff_5};
            busif_reg_rderr <= 1'b0;
          end
          default : begin
            busif_reg_rdata <= 32'h0;
            busif_reg_rderr <= ((|csb_req_payload_addr[1 : 0]) ? 1'b1 : 1'b0);
          end
        endcase
      end else begin
        busif_reg_rdata <= 32'h0;
        busif_reg_rderr <= 1'b0;
      end
    end
  end


endmodule
