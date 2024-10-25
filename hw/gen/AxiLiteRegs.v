// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : AxiLiteRegs
// Git hash  : 1629b51311574b60a89c236ca5b476ead2319295

`timescale 1ns/1ps

module AxiLiteRegs (
  input  wire          axilite_aw_valid,
  output wire          axilite_aw_ready,
  input  wire [13:0]   axilite_aw_payload_addr,
  input  wire [2:0]    axilite_aw_payload_prot,
  input  wire          axilite_w_valid,
  output wire          axilite_w_ready,
  input  wire [31:0]   axilite_w_payload_data,
  input  wire [3:0]    axilite_w_payload_strb,
  output wire          axilite_b_valid,
  input  wire          axilite_b_ready,
  output wire [1:0]    axilite_b_payload_resp,
  input  wire          axilite_ar_valid,
  output wire          axilite_ar_ready,
  input  wire [13:0]   axilite_ar_payload_addr,
  input  wire [2:0]    axilite_ar_payload_prot,
  output wire          axilite_r_valid,
  input  wire          axilite_r_ready,
  output wire [31:0]   axilite_r_payload_data,
  output wire [1:0]    axilite_r_payload_resp,
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
  input  wire          reset
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
    .reset                       (reset                                   )  //i
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
  always @(posedge clk or posedge reset) begin
    if(reset) begin
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

module AxiLite2CSB (
  input  wire          io_axi_lite_aw_valid,
  output reg           io_axi_lite_aw_ready,
  input  wire [13:0]   io_axi_lite_aw_payload_addr,
  input  wire [2:0]    io_axi_lite_aw_payload_prot,
  input  wire          io_axi_lite_w_valid,
  output reg           io_axi_lite_w_ready,
  input  wire [31:0]   io_axi_lite_w_payload_data,
  input  wire [3:0]    io_axi_lite_w_payload_strb,
  output reg           io_axi_lite_b_valid,
  input  wire          io_axi_lite_b_ready,
  output wire [1:0]    io_axi_lite_b_payload_resp,
  input  wire          io_axi_lite_ar_valid,
  output reg           io_axi_lite_ar_ready,
  input  wire [13:0]   io_axi_lite_ar_payload_addr,
  input  wire [2:0]    io_axi_lite_ar_payload_prot,
  output reg           io_axi_lite_r_valid,
  input  wire          io_axi_lite_r_ready,
  output wire [31:0]   io_axi_lite_r_payload_data,
  output wire [1:0]    io_axi_lite_r_payload_resp,
  output reg           io_csb_req_valid,
  input  wire          io_csb_req_ready,
  output wire [13:0]   io_csb_req_payload_addr,
  output wire [31:0]   io_csb_req_payload_wdata,
  output wire          io_csb_req_payload_wr,
  input  wire          io_csb_resp_valid,
  input  wire [31:0]   io_csb_resp_payload_rdata,
  input  wire          clk,
  input  wire          reset
);
  localparam fsm_enumDef_BOOT = 4'd0;
  localparam fsm_enumDef_wait_axi_cmd = 4'd1;
  localparam fsm_enumDef_csb_send_raddr = 4'd2;
  localparam fsm_enumDef_csb_wait_rdata = 4'd3;
  localparam fsm_enumDef_axi_send_rdata = 4'd4;
  localparam fsm_enumDef_axi_wait_wdata = 4'd5;
  localparam fsm_enumDef_csb_send_wcmd = 4'd6;
  localparam fsm_enumDef_csb_wait_resp = 4'd7;
  localparam fsm_enumDef_axi_send_bresp = 4'd8;

  wire                io_axi_lite_ar_fire;
  wire                io_axi_lite_aw_fire;
  reg        [13:0]   waddr;
  reg                 waddr_unaligned;
  wire                io_axi_lite_w_fire;
  reg        [31:0]   wdata;
  reg        [13:0]   raddr;
  reg                 raddr_unaligned;
  reg        [31:0]   rdata;
  wire                fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  reg        [3:0]    fsm_stateReg;
  reg        [3:0]    fsm_stateNext;
  `ifndef SYNTHESIS
  reg [111:0] fsm_stateReg_string;
  reg [111:0] fsm_stateNext_string;
  `endif


  `ifndef SYNTHESIS
  always @(*) begin
    case(fsm_stateReg)
      fsm_enumDef_BOOT : fsm_stateReg_string = "BOOT          ";
      fsm_enumDef_wait_axi_cmd : fsm_stateReg_string = "wait_axi_cmd  ";
      fsm_enumDef_csb_send_raddr : fsm_stateReg_string = "csb_send_raddr";
      fsm_enumDef_csb_wait_rdata : fsm_stateReg_string = "csb_wait_rdata";
      fsm_enumDef_axi_send_rdata : fsm_stateReg_string = "axi_send_rdata";
      fsm_enumDef_axi_wait_wdata : fsm_stateReg_string = "axi_wait_wdata";
      fsm_enumDef_csb_send_wcmd : fsm_stateReg_string = "csb_send_wcmd ";
      fsm_enumDef_csb_wait_resp : fsm_stateReg_string = "csb_wait_resp ";
      fsm_enumDef_axi_send_bresp : fsm_stateReg_string = "axi_send_bresp";
      default : fsm_stateReg_string = "??????????????";
    endcase
  end
  always @(*) begin
    case(fsm_stateNext)
      fsm_enumDef_BOOT : fsm_stateNext_string = "BOOT          ";
      fsm_enumDef_wait_axi_cmd : fsm_stateNext_string = "wait_axi_cmd  ";
      fsm_enumDef_csb_send_raddr : fsm_stateNext_string = "csb_send_raddr";
      fsm_enumDef_csb_wait_rdata : fsm_stateNext_string = "csb_wait_rdata";
      fsm_enumDef_axi_send_rdata : fsm_stateNext_string = "axi_send_rdata";
      fsm_enumDef_axi_wait_wdata : fsm_stateNext_string = "axi_wait_wdata";
      fsm_enumDef_csb_send_wcmd : fsm_stateNext_string = "csb_send_wcmd ";
      fsm_enumDef_csb_wait_resp : fsm_stateNext_string = "csb_wait_resp ";
      fsm_enumDef_axi_send_bresp : fsm_stateNext_string = "axi_send_bresp";
      default : fsm_stateNext_string = "??????????????";
    endcase
  end
  `endif

  assign io_axi_lite_ar_fire = (io_axi_lite_ar_valid && io_axi_lite_ar_ready);
  assign io_axi_lite_aw_fire = (io_axi_lite_aw_valid && io_axi_lite_aw_ready);
  always @(*) begin
    io_axi_lite_aw_ready = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_wait_axi_cmd : begin
        if(!io_axi_lite_ar_valid) begin
          if(io_axi_lite_aw_valid) begin
            io_axi_lite_aw_ready = 1'b1;
          end
        end
      end
      fsm_enumDef_csb_send_raddr : begin
      end
      fsm_enumDef_csb_wait_rdata : begin
      end
      fsm_enumDef_axi_send_rdata : begin
      end
      fsm_enumDef_axi_wait_wdata : begin
      end
      fsm_enumDef_csb_send_wcmd : begin
      end
      fsm_enumDef_csb_wait_resp : begin
      end
      fsm_enumDef_axi_send_bresp : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_axi_lite_w_ready = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_wait_axi_cmd : begin
        if(!io_axi_lite_ar_valid) begin
          if(io_axi_lite_aw_valid) begin
            if(io_axi_lite_w_valid) begin
              io_axi_lite_w_ready = 1'b1;
            end
          end
        end
      end
      fsm_enumDef_csb_send_raddr : begin
      end
      fsm_enumDef_csb_wait_rdata : begin
      end
      fsm_enumDef_axi_send_rdata : begin
      end
      fsm_enumDef_axi_wait_wdata : begin
        if(io_axi_lite_w_valid) begin
          io_axi_lite_w_ready = 1'b1;
        end
      end
      fsm_enumDef_csb_send_wcmd : begin
      end
      fsm_enumDef_csb_wait_resp : begin
      end
      fsm_enumDef_axi_send_bresp : begin
      end
      default : begin
      end
    endcase
  end

  assign io_axi_lite_w_fire = (io_axi_lite_w_valid && io_axi_lite_w_ready);
  always @(*) begin
    io_axi_lite_ar_ready = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_wait_axi_cmd : begin
        if(io_axi_lite_ar_valid) begin
          io_axi_lite_ar_ready = 1'b1;
        end
      end
      fsm_enumDef_csb_send_raddr : begin
      end
      fsm_enumDef_csb_wait_rdata : begin
      end
      fsm_enumDef_axi_send_rdata : begin
      end
      fsm_enumDef_axi_wait_wdata : begin
      end
      fsm_enumDef_csb_send_wcmd : begin
      end
      fsm_enumDef_csb_wait_resp : begin
      end
      fsm_enumDef_axi_send_bresp : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_csb_req_valid = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_wait_axi_cmd : begin
      end
      fsm_enumDef_csb_send_raddr : begin
        io_csb_req_valid = 1'b1;
      end
      fsm_enumDef_csb_wait_rdata : begin
      end
      fsm_enumDef_axi_send_rdata : begin
      end
      fsm_enumDef_axi_wait_wdata : begin
      end
      fsm_enumDef_csb_send_wcmd : begin
        io_csb_req_valid = 1'b1;
      end
      fsm_enumDef_csb_wait_resp : begin
      end
      fsm_enumDef_axi_send_bresp : begin
      end
      default : begin
      end
    endcase
  end

  assign io_csb_req_payload_wdata = wdata;
  always @(*) begin
    io_axi_lite_r_valid = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_wait_axi_cmd : begin
      end
      fsm_enumDef_csb_send_raddr : begin
      end
      fsm_enumDef_csb_wait_rdata : begin
      end
      fsm_enumDef_axi_send_rdata : begin
        io_axi_lite_r_valid = 1'b1;
      end
      fsm_enumDef_axi_wait_wdata : begin
      end
      fsm_enumDef_csb_send_wcmd : begin
      end
      fsm_enumDef_csb_wait_resp : begin
      end
      fsm_enumDef_axi_send_bresp : begin
      end
      default : begin
      end
    endcase
  end

  assign io_axi_lite_r_payload_data = rdata;
  assign io_axi_lite_r_payload_resp = (raddr_unaligned ? 2'b10 : 2'b00);
  always @(*) begin
    io_axi_lite_b_valid = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_wait_axi_cmd : begin
      end
      fsm_enumDef_csb_send_raddr : begin
      end
      fsm_enumDef_csb_wait_rdata : begin
      end
      fsm_enumDef_axi_send_rdata : begin
      end
      fsm_enumDef_axi_wait_wdata : begin
      end
      fsm_enumDef_csb_send_wcmd : begin
      end
      fsm_enumDef_csb_wait_resp : begin
      end
      fsm_enumDef_axi_send_bresp : begin
        io_axi_lite_b_valid = 1'b1;
      end
      default : begin
      end
    endcase
  end

  assign io_axi_lite_b_payload_resp = (waddr_unaligned ? 2'b10 : 2'b00);
  assign fsm_wantExit = 1'b0;
  always @(*) begin
    fsm_wantStart = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_wait_axi_cmd : begin
      end
      fsm_enumDef_csb_send_raddr : begin
      end
      fsm_enumDef_csb_wait_rdata : begin
      end
      fsm_enumDef_axi_send_rdata : begin
      end
      fsm_enumDef_axi_wait_wdata : begin
      end
      fsm_enumDef_csb_send_wcmd : begin
      end
      fsm_enumDef_csb_wait_resp : begin
      end
      fsm_enumDef_axi_send_bresp : begin
      end
      default : begin
        fsm_wantStart = 1'b1;
      end
    endcase
  end

  assign fsm_wantKill = 1'b0;
  assign io_csb_req_payload_addr = ((fsm_stateReg == fsm_enumDef_csb_send_raddr) ? raddr : waddr);
  assign io_csb_req_payload_wr = (fsm_stateReg == fsm_enumDef_csb_send_wcmd);
  always @(*) begin
    fsm_stateNext = fsm_stateReg;
    case(fsm_stateReg)
      fsm_enumDef_wait_axi_cmd : begin
        if(io_axi_lite_ar_valid) begin
          fsm_stateNext = fsm_enumDef_csb_send_raddr;
        end else begin
          if(io_axi_lite_aw_valid) begin
            if(io_axi_lite_w_valid) begin
              fsm_stateNext = fsm_enumDef_csb_send_wcmd;
            end else begin
              fsm_stateNext = fsm_enumDef_axi_wait_wdata;
            end
          end
        end
      end
      fsm_enumDef_csb_send_raddr : begin
        if(io_csb_req_ready) begin
          if(io_csb_resp_valid) begin
            fsm_stateNext = fsm_enumDef_axi_send_rdata;
          end else begin
            fsm_stateNext = fsm_enumDef_csb_wait_rdata;
          end
        end
      end
      fsm_enumDef_csb_wait_rdata : begin
        if(io_csb_resp_valid) begin
          fsm_stateNext = fsm_enumDef_axi_send_rdata;
        end
      end
      fsm_enumDef_axi_send_rdata : begin
        if(io_axi_lite_r_ready) begin
          fsm_stateNext = fsm_enumDef_wait_axi_cmd;
        end
      end
      fsm_enumDef_axi_wait_wdata : begin
        if(io_axi_lite_w_valid) begin
          fsm_stateNext = fsm_enumDef_csb_send_wcmd;
        end
      end
      fsm_enumDef_csb_send_wcmd : begin
        if(io_csb_req_ready) begin
          if(io_csb_resp_valid) begin
            fsm_stateNext = fsm_enumDef_axi_send_bresp;
          end else begin
            fsm_stateNext = fsm_enumDef_csb_wait_resp;
          end
        end
      end
      fsm_enumDef_csb_wait_resp : begin
        if(io_csb_resp_valid) begin
          fsm_stateNext = fsm_enumDef_axi_send_bresp;
        end
      end
      fsm_enumDef_axi_send_bresp : begin
        if(io_axi_lite_b_ready) begin
          fsm_stateNext = fsm_enumDef_wait_axi_cmd;
        end
      end
      default : begin
      end
    endcase
    if(fsm_wantStart) begin
      fsm_stateNext = fsm_enumDef_wait_axi_cmd;
    end
    if(fsm_wantKill) begin
      fsm_stateNext = fsm_enumDef_BOOT;
    end
  end

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      fsm_stateReg <= fsm_enumDef_BOOT;
    end else begin
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert(((! io_axi_lite_ar_fire) || (io_axi_lite_ar_payload_addr[1 : 0] == 2'b00))); // AxiLite2CSB.scala:L28
        `else
          if(!((! io_axi_lite_ar_fire) || (io_axi_lite_ar_payload_addr[1 : 0] == 2'b00))) begin
            $display("FAILURE "); // AxiLite2CSB.scala:L28
            $finish;
          end
        `endif
      `endif
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert(((! io_axi_lite_aw_fire) || (io_axi_lite_aw_payload_addr[1 : 0] == 2'b00))); // AxiLite2CSB.scala:L29
        `else
          if(!((! io_axi_lite_aw_fire) || (io_axi_lite_aw_payload_addr[1 : 0] == 2'b00))) begin
            $display("FAILURE "); // AxiLite2CSB.scala:L29
            $finish;
          end
        `endif
      `endif
      fsm_stateReg <= fsm_stateNext;
      case(fsm_stateReg)
        fsm_enumDef_wait_axi_cmd : begin
          if(!io_axi_lite_ar_valid) begin
            if(io_axi_lite_aw_valid) begin
              if(io_axi_lite_w_valid) begin
                `ifndef SYNTHESIS
                  `ifdef FORMAL
                    assert((io_axi_lite_w_payload_strb == 4'b1111)); // AxiLite2CSB.scala:L93
                  `else
                    if(!(io_axi_lite_w_payload_strb == 4'b1111)) begin
                      $display("FAILURE "); // AxiLite2CSB.scala:L93
                      $finish;
                    end
                  `endif
                `endif
              end
            end
          end
        end
        fsm_enumDef_csb_send_raddr : begin
        end
        fsm_enumDef_csb_wait_rdata : begin
        end
        fsm_enumDef_axi_send_rdata : begin
        end
        fsm_enumDef_axi_wait_wdata : begin
        end
        fsm_enumDef_csb_send_wcmd : begin
        end
        fsm_enumDef_csb_wait_resp : begin
        end
        fsm_enumDef_axi_send_bresp : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if(io_axi_lite_aw_fire) begin
      waddr <= io_axi_lite_aw_payload_addr;
    end
    if(io_axi_lite_aw_fire) begin
      waddr_unaligned <= (io_axi_lite_ar_payload_addr[1 : 0] != 2'b00);
    end
    if(io_axi_lite_w_fire) begin
      wdata <= io_axi_lite_w_payload_data;
    end
    if(io_axi_lite_ar_fire) begin
      raddr <= io_axi_lite_ar_payload_addr;
    end
    if(io_axi_lite_ar_fire) begin
      raddr_unaligned <= (io_axi_lite_ar_payload_addr[1 : 0] != 2'b00);
    end
    if(io_csb_resp_valid) begin
      rdata <= io_csb_resp_payload_rdata;
    end
  end


endmodule
