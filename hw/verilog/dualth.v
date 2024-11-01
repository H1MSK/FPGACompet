//dual threshold detecting and weak edge connecting
module dualth(
	input			clk,
	input			rst_n,
	input			en_1,
	input			en_2,
	input[3:0]		state,

	input[7:0]		gth,
	input[7:0]		gtl,

	input[11:0]		val_aft_nms,
	input[1:0]		ram1_rdata,
	input[1:0]		ram2_rdata, 

	output reg[10:0]	ram1_waddr,
	output reg[10:0]	ram1_raddr,
	output[1:0]		ram1_wdata,

	output[10:0]		ram2_waddr,
	output[10:0]		ram2_raddr,
	output[1:0]		ram2_wdata,

	output reg[7:0]		gray_out,	//axi data output
	output			dualth_ram_wen
);

reg			en_buf;

reg[7:0]		ram1_rdata_dly1;
reg[7:0]		ram2_rdata_dly1;

reg[1:0]		swn;	//11 strong 01 weak 00 not

//input delay
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		ram1_rdata_dly1		<= 'b0;
		ram2_rdata_dly1		<= 'b0;
	end
	else begin
		ram1_rdata_dly1		<= ram1_rdata;
		ram2_rdata_dly1		<= ram2_rdata;
	end
end

//dualth buf enable
always@* begin
	case(state)
		'b0001:		en_buf = en_1;
		'b0010:		en_buf = en_1;
		'b0100:		en_buf = 'b1;
		'b1000: 	en_buf = 'b0;
		default:	en_buf = 'b0;
	endcase
end

//dual threshold comparing
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		swn	<= 'b10;
	end
	else begin
		if(val_aft_nms_dly < gth) begin
			if(val_aft_nms_dly < gtl) begin
				swn	<= 'b00;
			end
			else begin
				swn	<= 'b01;
			end
		end
		else begin
			swn	<= 'b11;
		end
	end
end

//shifter
reg[1:0]	swn_00;
reg[1:0]	swn_01;
reg[1:0]	swn_02;
reg[1:0]	swn_10;
reg[1:0]	swn_11;	//center
reg[1:0]	swn_12;
reg[1:0]	swn_20;
reg[1:0]	swn_21;
reg[1:0]	swn_22;

//shifter
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		swn_00	<= 'b0;
		swn_01	<= 'b0;
		swn_02	<= 'b0;
		swn_10	<= 'b0;
		swn_11	<= 'b0;
		swn_12	<= 'b0;
		swn_20	<= 'b0;
		swn_21	<= 'b0;
		swn_22	<= 'b0;
	end
	else begin
		if(en_buf) begin
			swn_00	<= swn_01;
			swn_01	<= swn_02;
			swn_02	<= ram1_rdata_dly1;
			swn_10	<= swn_11;
			swn_11	<= swn_12;
			swn_12	<= ram2_rdata_dly1;
			swn_20	<= swn_21;
			swn_21	<= swn_22;
			swn_22	<= swn;
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
		if(en_buf) begin
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
assign ram2_wdata = swn;
assign ram2_waddr = ram1_waddr;
assign ram2_raddr = ram1_raddr;
assign dualth_ram_wen = en_buf;

//final output
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		gray_out	<= 'd255;
	end
	else begin
		if(en_2) begin
			case(swn_11)
				2'b00: begin
					gray_out	<= 'd255;
				end
				2'b01: begin
					if((&swn_00) || (&swn_01) ||(&swn_02) ||(&swn_10) ||(&swn_12) ||(&swn_20) ||(&swn_21) ||(&swn_22)) begin
						gray_out	<= 'd0;
					end
					else begin
						gray_out	<= 'd255;
					end
				end
				2'b11: begin
					gray_out	<= 'd255;
				end
				default begin
					gray_out	<= 'd127;
				end
			endcase
		end
	end
end

endmodule