module dbg_emio_outsig(
  input clk,
  input reset,
  
  // from_gpio[2:0] => data_addr
  // from_gpio[8] => fake_out_valid
  // from_gpio[9] => fake_out_ready
  // from_gpio[10] => fake_out_last
  input [63:0]   from_gpio,

  output fake_out_valid,
  output fake_out_ready,
  output fake_out_last,

  // to_gpio[8] <= out_busy
  // to_gpio[7:0] <= {out_coeff_..., out_thres_...}[data_addr]
  output [63:0]  to_gpio,

  input          out_busy,
  input [7:0]    out_coeff_0,
  input [7:0]    out_coeff_1,
  input [7:0]    out_coeff_2,
  input [7:0]    out_coeff_3,
  input [7:0]    out_coeff_4,
  input [7:0]    out_coeff_5,
  input [7:0]    out_thres_0,
  input [7:0]    out_thres_1
);

  assign fake_out_valid = from_gpio[8];
  assign fake_out_ready = from_gpio[9];

  reg last_gpio_10;
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      last_gpio_10 <= 1'b0;
    end
    last_gpio_10 <= from_gpio[10];
  end
  assign fake_out_last  = from_gpio[10] && ~last_gpio_10;

  assign to_gpio[63:9] = 0;
  assign to_gpio[8] = out_busy;
  wire data_addr = from_gpio[2:0];
  reg data;
  always @(*) begin
    case(data_addr)
      3'd0: data = out_coeff_0;
      3'd1: data = out_coeff_1;
      3'd2: data = out_coeff_2;
      3'd3: data = out_coeff_3;
      3'd4: data = out_coeff_4;
      3'd5: data = out_coeff_5;
      3'd6: data = out_thres_0;
      3'd7: data = out_thres_1;
      default: data = 8'd0;
    endcase
  end
  assign to_gpio[7:0] = data;

endmodule