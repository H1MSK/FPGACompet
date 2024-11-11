// Generator : SpinalHDL v1.10.1    git head : 2527c7c6b0fb0f95e5e1a5722a0be732b364ce43
// Component : StreamController_1
// Git hash  : a7edaa7e75fa187e8bc88e78a18e2babddae992f

`timescale 1ns/1ps 
module StreamController_1 (
  input  wire          ivalid,
  output wire          iready,
  output wire          ovalid,
  input  wire          oready,
  output wire          en_0,
  input  wire          clk,
  input  wire          resetn
);

  reg                 full_bit;

  assign iready = ((! full_bit) || oready);
  assign ovalid = full_bit;
  assign en_0 = (ivalid && ((! full_bit) || oready));
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      full_bit <= 1'b0;
    end else begin
      full_bit <= (ivalid || (full_bit && (! oready)));
    end
  end


endmodule
