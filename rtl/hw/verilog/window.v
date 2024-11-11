
module window(
	input			clk,
	input			rst_n,
	input			en_1,
	input[3:0]		state,

	input[7:0]		pix_in,

	input[7:0]		ram1_rdata,
	input[7:0]		ram2_rdata,

	output[7:0]		ram1_wdata,
	output reg[10:0]	ram1_waddr,
	output reg[10:0]	ram1_raddr,

	output reg[7:0]		ram2_wdata,
	output[10:0]		ram2_waddr,
	output[10:0]		ram2_raddr,

	output			win_ram_wen,

	output reg[13:0]	pix_00,
	output reg[13:0]	pix_01,
	output reg[13:0]	pix_02,
	output reg[13:0]	pix_10,
	output reg[13:0]	pix_11,
	output reg[13:0]	pix_12,
	output reg[13:0]	pix_20,
	output reg[13:0]	pix_21,
	output reg[13:0]	pix_22,

	output reg		en_window,
	output			not_ready,
	output			not_valid
);

wire			write0;

reg[7:0]		ram1_rdata_dly1;
reg[7:0]		ram2_rdata_dly1;

assign write0 = (ram2_waddr == 'd1024) ? 'b1 : 'b0;
assign not_ready = write0;
assign not_valid = (ram2_raddr == 'd1024) ? 'b1 : 'b0;

//input delay
always@(posedge clk) begin
	ram1_rdata_dly1	<= ram1_rdata;
	ram2_rdata_dly1	<= ram2_rdata;
end

//window enable
always@* begin
	case(state)
		'b0001:		en_window = en_1 || write0;
		'b0010:		en_window = en_1 || write0;
		'b0100:		en_window = 'b1;
		'b1000: 	en_window = 'b0;
		default:	en_window = 'b0;
	endcase
end

//shifter
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		pix_00	<= 'b0;
		pix_01	<= 'b0;
		pix_02	<= 'b0;
		pix_10	<= 'b0;
		pix_11	<= 'b0;
		pix_12	<= 'b0;
		pix_20	<= 'b0;
		pix_21	<= 'b0;
		pix_22	<= 'b0;
	end
	else begin
		if(en_window) begin
			pix_00	<= pix_01;
			pix_01	<= pix_02;
			pix_02	<= ram1_rdata_dly1;
			pix_10	<= pix_11;
			pix_11	<= pix_12;
			pix_12	<= ram2_rdata_dly1;
			pix_20	<= pix_21;
			pix_21	<= pix_22;
			pix_22	<= write0 ? 'b0 : pix_in;
		end
	end
end

//ram control
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		ram1_waddr	<= 'd0;
		ram1_raddr	<= 'd1;
	end
	else begin
		if(en_window) begin
			if(ram1_waddr < 'd1024) begin
				ram1_waddr	<= ram1_waddr + 1;
			end
			else begin
				ram1_waddr	<= 'b0;
			end

			if(ram1_raddr < 'd1024) begin
				ram1_raddr	<= ram1_raddr + 1;
			end
			else begin
				ram1_raddr	<= 'b0;
			end
		end
	end
end

assign ram1_wdata = ram2_rdata;
always@* begin
	if(state[0] || state[1]) begin
		if(~write0) begin
			ram2_wdata	= pix_in;
		end
		else begin
			ram2_wdata	= 'b0;
		end
	end
	else begin
		ram2_wdata	= 'b0;
	end
end
assign ram2_waddr = ram1_waddr;
assign ram2_raddr = ram1_raddr;

assign win_ram_wen = en_window;

endmodule
