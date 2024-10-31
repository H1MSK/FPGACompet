//dual threshold detecting and weak edge connecting
module dualth(
	input			clk,
	input			rst_n,
	input			en,
	input			dualth_axi_ready,

	input[7:0]		gth,
	input[7:0]		gtl,

	input[11:0]		val_aft_nms_dly,
	input[1:0]		ram1_rdata,
	input[1:0]		ram2_rdata, 

	output reg[10:0]	ram1_waddr,
	output reg[10:0]	ram1_raddr,
	output[1:0]		ram1_wdata,

	output[10:0]		ram2_waddr,
	output[10:0]		ram2_raddr,
	output[1:0]		ram2_wdata,

	output reg[7:0]		gray_out_dly,	//axi data output
	output			axi_valid,
	output reg		axi_last
);


reg[7:0]		ram1_rdata_dly1;
reg[7:0]		ram2_rdata_dly1;
reg		en_dly1;
reg		en_dly2;
reg		en_dly3;
reg		en_dly4;
reg		en_dly5;
reg		en_dly6;
reg		en_dly7;
reg		en_dly8;

reg[7:0]	gray_out;

reg[1:0]	swn;	//11 strong 01 weak 00 not

reg[10:0]	cnt_vld;
reg		dualth_ovalid;


reg[12:0]	cnt_last;

//input delay
always@(posedge clk or rst_n) begin
	if(~rst_n) begin
		ram1_rdata_dly1		<= 'b0;
		ram2_rdata_dly1		<= 'b0;
		en_dly1			<= 'b0;
	end
	else begin
		ram1_rdata_dly1		<= ram1_rdata;
		ram2_rdata_dly1		<= ram2_rdata;
		en_dly1			<= en;
	end
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
		if(en) begin
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
		if(en) begin
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

//final output
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		gray_out	<= 'd255;
	end
	else begin
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

always@(posedge clk) begin
	gray_out_dly	<= gray_out;
end

//output valid
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		cnt_vld	<= 'd0;
	end
	else begin
		if(en) begin
			if(cnt_vld < 'd1028) begin
				if(ram1_raddr == 'd12) begin
					cnt_vld	<= cnt_vld + 1;
				end
			end
			else begin
				cnt_vld	<= 'd0;
			end
		end
	end
end

always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		dualth_ovalid	<= 'b0;
	end
	else begin
		if(cnt_vld == 'd4) begin
			dualth_ovalid	<= 'b1;
		end
		else if(cnt_vld == 'd1028) begin
			dualth_ovalid	<= 'b0;
		end
	end
end

assign axi_valid = en_dly1 && dualth_ovalid;

always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		cnt_last	<= 'd0;
	end
	else begin
		if(axi_valid) begin
			cnt_last	<= cnt_last + 'd1;
		end
	end
end

always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		axi_last	<= 'b0;
	end
	else begin
		if(&cnt_last[6:0]) begin
			axi_last	<= 'b1;
		end
		else if(dualth_axi_ready && axi_valid) begin
			axi_last	<= 'b0;
		end
	end
end


endmodule