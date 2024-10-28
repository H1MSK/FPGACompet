//require 4 DRAMs, width 8 depth 1040
module gauss(
	input			clk,
	input			rst_n,

	input[7:0]		axi_data_in,
	input[3:0]		axi_keep,
	input			axi_last,
	input			axi_valid,
	input			dualth_axi_ready,

	input[7:0]		coe_00_in,		//gauss coefficient, 0.xxxx_xxxx
	input[7:0]		coe_01_in,
	input[7:0]		coe_02_in,
	input[7:0]		coe_11_in,
	input[7:0]		coe_12_in,
	input[7:0]		coe_22_in,

	input[7:0]		ram1_rdata,
	input[7:0]		ram2_rdata,
	input[7:0]		ram3_rdata,
	input[7:0]		ram4_rdata,

	output[7:0]		ram1_wdata,
	output reg[10:0]	ram1_waddr,
	output reg[10:0]	ram1_raddr,

	output[7:0]		ram2_wdata,
	output[10:0]		ram2_waddr,
	output[10:0]		ram2_raddr,

	output[7:0]		ram3_wdata,
	output[10:0]		ram3_waddr,
	output[10:0]		ram3_raddr,

	output[7:0]		ram4_wdata,
	output[10:0]		ram4_waddr,
	output[10:0]		ram4_raddr,

	output reg[7:0]		gray_out,
	output reg		ovalid,
	output			gauss_axi_ready,
	output			gauss_ram_wen
);

wire			en;

reg[7:0]		ram1_rdata_dly1;
reg[7:0]		ram2_rdata_dly1;
reg[7:0]		ram3_rdata_dly1;
reg[7:0]		ram4_rdata_dly1;

reg[10:0]		cnt_vld;
reg[12:0]		cnt_last;	//enough last indicates a pic over

reg[20:0]		gray_temp;

//shifter, store 25 pixel gray
reg[7:0]		gray_00;
reg[7:0]		gray_01;
reg[7:0]		gray_02;
reg[7:0]		gray_03;
reg[7:0]		gray_04;

reg[7:0]		gray_10;
reg[7:0]		gray_11;
reg[7:0]		gray_12;
reg[7:0]		gray_13;
reg[7:0]		gray_14;

reg[7:0]		gray_20;
reg[7:0]		gray_21;
reg[7:0]		gray_22;
reg[7:0]		gray_23;
reg[7:0]		gray_24;

reg[7:0]		gray_30;
reg[7:0]		gray_31;
reg[7:0]		gray_32;
reg[7:0]		gray_33;
reg[7:0]		gray_34;

reg[7:0]		gray_40;
reg[7:0]		gray_41;
reg[7:0]		gray_42;
reg[7:0]		gray_43;
reg[7:0]		gray_44;

//coefficients
reg[7:0]		coe_00;
reg[7:0]		coe_01;
reg[7:0]		coe_02;
reg[7:0]		coe_03;
reg[7:0]		coe_04;

reg[7:0]		coe_10;
reg[7:0]		coe_11;
reg[7:0]		coe_12;
reg[7:0]		coe_13;
reg[7:0]		coe_14;

reg[7:0]		coe_20;
reg[7:0]		coe_21;
reg[7:0]		coe_22;
reg[7:0]		coe_23;
reg[7:0]		coe_24;

reg[7:0]		coe_30;
reg[7:0]		coe_31;
reg[7:0]		coe_32;
reg[7:0]		coe_33;
reg[7:0]		coe_34;

reg[7:0]		coe_40;
reg[7:0]		coe_41;
reg[7:0]		coe_42;
reg[7:0]		coe_43;
reg[7:0]		coe_44;

//input delay
always@(posedge clk) begin
	ram1_rdata_dly1	<= ram1_rdata;
	ram2_rdata_dly1	<= ram2_rdata;
	ram3_rdata_dly1	<= ram3_rdata;
	ram4_rdata_dly1	<= ram4_rdata;
end

//module enable
assign en = (axi_valid || ovalid) && gauss_axi_ready;
assign gauss_axi_ready = dualth_axi_ready;

//shifter
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		gray_00	<= 'b0;
		gray_01	<= 'b0;
		gray_02	<= 'b0;
		gray_03	<= 'b0;
		gray_04	<= 'b0;

		gray_10	<= 'b0;
		gray_11	<= 'b0;
		gray_12	<= 'b0;
		gray_13	<= 'b0;
		gray_14	<= 'b0;

		gray_20	<= 'b0;
		gray_21	<= 'b0;
		gray_22	<= 'b0;
		gray_23	<= 'b0;
		gray_24	<= 'b0;

		gray_30	<= 'b0;
		gray_31	<= 'b0;
		gray_32	<= 'b0;
		gray_33	<= 'b0;
		gray_34	<= 'b0;

		gray_40	<= 'b0;
		gray_41	<= 'b0;
		gray_42	<= 'b0;
		gray_43	<= 'b0;
		gray_44	<= 'b0;
	end
	else begin
		if(en) begin
			gray_00	<= gray_01;
			gray_01	<= gray_02;
			gray_02	<= gray_03;
			gray_03	<= gray_04;
			gray_04	<= ram1_rdata_dly1;

			gray_10	<= gray_11;
			gray_11	<= gray_12;
			gray_12	<= gray_13;
			gray_13	<= gray_14;
			gray_14	<= ram2_rdata_dly1;

			gray_20	<= gray_21;
			gray_21	<= gray_22;
			gray_22	<= gray_23;
			gray_23	<= gray_24;
			gray_24	<= ram3_rdata_dly1;

			gray_30	<= gray_31;
			gray_31	<= gray_32;
			gray_32	<= gray_33;
			gray_33	<= gray_34;
			gray_34	<= ram4_rdata_dly1;

			gray_40	<= gray_41;
			gray_41	<= gray_42;
			gray_42	<= gray_43;
			gray_43	<= gray_44;
			gray_44	<= axi_data_in;
		end
	end
end

//coe
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		coe_00	<= 'b0;
		coe_01	<= 'b0;
		coe_02	<= 'b0;
		coe_03	<= 'b0;
		coe_04	<= 'b0;

		coe_10	<= 'b0;
		coe_11	<= 'b0;
		coe_12	<= 'b0;
		coe_13	<= 'b0;
		coe_14	<= 'b0;

		coe_20	<= 'b0;
		coe_21	<= 'b0;
		coe_22	<= 'b0;
		coe_23	<= 'b0;
		coe_24	<= 'b0;

		coe_30	<= 'b0;
		coe_31	<= 'b0;
		coe_32	<= 'b0;
		coe_33	<= 'b0;
		coe_34	<= 'b0;

		coe_40	<= 'b0;
		coe_41	<= 'b0;
		coe_42	<= 'b0;
		coe_43	<= 'b0;
		coe_44	<= 'b0;
	end
	else begin
		coe_00	<= coe_00_in;
		coe_01	<= coe_01_in;
		coe_02	<= coe_02_in;
		coe_03	<= coe_01_in;
		coe_04	<= coe_00_in;

		coe_10	<= coe_01_in;
		coe_11	<= coe_11_in;
		coe_12	<= coe_12_in;
		coe_13	<= coe_11_in;
		coe_14	<= coe_01_in;

		coe_20	<= coe_02_in;
		coe_21	<= coe_12_in;
		coe_22	<= coe_22_in;
		coe_23	<= coe_12_in;
		coe_24	<= coe_02_in;

		coe_30	<= coe_01_in;
		coe_31	<= coe_11_in;
		coe_32	<= coe_12_in;
		coe_33	<= coe_11_in;
		coe_34	<= coe_01_in;

		coe_40	<= coe_00_in;
		coe_41	<= coe_01_in;
		coe_42	<= coe_02_in;
		coe_43	<= coe_01_in;
		coe_44	<= coe_00_in;
	end
end

//gray out
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		gray_temp	<= 'b0;
	end
	else begin
		if(en) begin
			gray_temp	<= gray_00 * coe_00 + gray_01 * coe_01 + gray_02 * coe_02 + gray_03 * coe_03 + gray_04 * coe_04
					+ gray_10 * coe_10 + gray_11 * coe_11 + gray_12 * coe_12 + gray_13 * coe_13 + gray_14 * coe_14
					+ gray_20 * coe_20 + gray_21 * coe_21 + gray_22 * coe_22 + gray_23 * coe_23 + gray_24 * coe_24
					+ gray_30 * coe_30 + gray_31 * coe_31 + gray_32 * coe_32 + gray_33 * coe_33 + gray_34 * coe_34
					+ gray_40 * coe_40 + gray_41 * coe_41 + gray_42 * coe_42 + gray_43 * coe_43 + gray_44 * coe_44;
		end
	end
end

always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		gray_out	<= 'b0;
	end
	else begin
		if(cnt_vld < 'd1025) begin
			if((ram1_raddr == 'd1) || (ram1_raddr == 'd2)) begin	//edge
				gray_out	<= 'b0;
			end
			else begin
				gray_out	<= gray_temp[15:8];
			end
		end
		else begin
			gray_out	<= 'b0;
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
			if(ram1_waddr < 'd1025) begin
				ram1_waddr	<= ram1_waddr + 1;
			end
			else begin
				ram1_waddr	<= 'b0;
			end

			if(ram1_raddr < 'd1025) begin
				ram1_raddr	<= ram1_raddr + 1;
			end
			else begin
				ram1_raddr	<= 'b0;
			end
		end
	end
end

assign ram1_wdata = ram2_rdata;

assign ram2_wdata = ram3_rdata;
assign ram2_waddr = ram1_waddr;
assign ram2_raddr = ram1_raddr;

assign ram3_wdata = ram4_rdata;
assign ram3_waddr = ram1_waddr;
assign ram3_raddr = ram1_raddr;

assign ram4_wdata = (cnt_last < 'd4096) ? axi_data_in : 'b0;
assign ram4_waddr = ram1_waddr;
assign ram4_raddr = ram1_raddr;

assign gauss_ram_wen = en;

//output valid
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		cnt_vld	<= 'd0;
	end
	else begin
		if(en) begin
			if(cnt_vld < 'd1031) begin
				if(ram1_raddr == 'd3) begin
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
		cnt_last	<= 'd0;
	end
	else begin
		if(axi_last) begin
			cnt_last	<= cnt_last + 'd1;
		end
	end
end

always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		ovalid	<= 'b0;
	end
	else begin
		if((cnt_vld >= 'd3) && (cnt_vld < 'd1031)) begin
			if(ram1_raddr == 'd1) begin
				ovalid	<= 'b0;
			end
			else begin
				if(cnt_last < 'd4096) begin
					if(axi_valid) begin
						ovalid	<= 'b1;
					end
					else begin
						ovalid	<= 'b0;
					end
				end
				else begin
					ovalid	<= 'b1;
				end
			end
		end
		else if(cnt_vld == 'd1031) begin
			ovalid	<= 'b0;
		end
	end
end

endmodule