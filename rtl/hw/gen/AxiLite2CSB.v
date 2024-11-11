// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : AxiLite2CSB
// Git hash  : ac106a508d16e27cfe6f32162015da1ba0ee7336

`timescale 1ns/1ps 
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
  input  wire          resetn
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

  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
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
