module ram2b(
  input       clk,
  input[10:0] a,    // waddr
  input[1:0]  d,    // wdata
  input       we,   // wen
  input       dpra, // raddr
  output      dpo   // rdata
);
  reg[1:0] mem[0:10];
  always @(posedge clk) begin
    if(we) mem[a] <= d;
  end

  assign dpo = mem[dpra];
endmodule

module ram8b(
  input       clk,
  input[10:0] a,    // waddr
  input[7:0]  d,    // wdata
  input       we,   // wen
  input       dpra, // raddr
  output      dpo   // rdata
);
  reg[7:0] mem[0:10];
  always @(posedge clk) begin
    if(we) mem[a] <= d;
  end

  assign dpo = mem[dpra];
endmodule

module ram14b(
  input       clk,
  input[10:0] a,    // waddr
  input[13:0] d,    // wdata
  input       we,   // wen
  input       dpra, // raddr
  output      dpo   // rdata
);
  reg[13:0] mem[0:10];
  always @(posedge clk) begin
    if(we) mem[a] <= d;
  end

  assign dpo = mem[dpra];
endmodule
