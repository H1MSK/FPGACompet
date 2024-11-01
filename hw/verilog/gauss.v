//require 4 DRAMs, width 8 depth 1040
module gauss(
	input			clk,
	input			rst_n,

	input[7:0]		axi_data_in,
	input[3:0]		axi_keep,

	input[3:0]		state,
	input			en_1,			//stream controller en

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
	output			gauss_ram_wen,
	output reg		edg
);

reg			en_gauss;

reg[7:0]		ram1_rdata_dly1;
reg[7:0]		ram2_rdata_dly1;
reg[7:0]		ram3_rdata_dly1;
reg[7:0]		ram4_rdata_dly1;

reg[20:0]		gray_temp;

reg[20:0]		gray_temp1;
reg[20:0]		gray_temp2;

reg[20:0]		gray_temp11;
reg[20:0]		gray_temp12;
reg[20:0]		gray_temp21;
reg[20:0]		gray_temp22;

reg[20:0]		gray_temp111;
reg[20:0]		gray_temp112;
reg[20:0]		gray_temp121;
reg[20:0]		gray_temp122;
reg[20:0]		gray_temp211;
reg[20:0]		gray_temp212;
reg[20:0]		gray_temp220;

reg[20:0]		gray_temp1111;
reg[20:0]		gray_temp1112;
reg[20:0]		gray_temp1121;
reg[20:0]		gray_temp1122;
reg[20:0]		gray_temp1211;
reg[20:0]		gray_temp1212;
reg[20:0]		gray_temp1221;
reg[20:0]		gray_temp1222;
reg[20:0]		gray_temp2111;
reg[20:0]		gray_temp2112;
reg[20:0]		gray_temp2121;
reg[20:0]		gray_temp2122;
reg[20:0]		gray_temp2200;

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

//ram delay
always@(posedge clk) begin
	ram1_rdata_dly1	<= ram1_rdata;
	ram2_rdata_dly1	<= ram2_rdata;
	ram3_rdata_dly1	<= ram3_rdata;
	ram4_rdata_dly1	<= ram4_rdata;
end

//gauss enable
always@* begin
	case(state)
		'b0001:		en_gauss = en_1;
		'b0010:		en_gauss = en_1;
		'b0100:		en_gauss = 'b1;
		'b1000: 	en_gauss = 'b0;
		default:	en_gauss = 'b0;
	endcase
end

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
		if(en_gauss) begin
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
			gray_44	<= (state[1] || state[0]) ? axi_data_in : 'b0;	// = data_in when pic input is not done
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

		gray_temp1	<= 'b0;
		gray_temp2	<= 'b0;

		gray_temp11	<= 'b0;
		gray_temp12	<= 'b0;
		gray_temp21	<= 'b0;
		gray_temp22	<= 'b0;

		gray_temp111	<= 'b0;
		gray_temp112	<= 'b0;
		gray_temp121	<= 'b0;
		gray_temp122	<= 'b0;
		gray_temp211	<= 'b0;
		gray_temp212	<= 'b0;
		gray_temp220	<= 'b0;

		gray_temp1111	<= 'b0;
		gray_temp1112	<= 'b0;
		gray_temp1121	<= 'b0;
		gray_temp1122	<= 'b0;
		gray_temp1211	<= 'b0;
		gray_temp1212	<= 'b0;
		gray_temp1221	<= 'b0;
		gray_temp1222	<= 'b0;
		gray_temp2111	<= 'b0;
		gray_temp2112	<= 'b0;
		gray_temp2121	<= 'b0;
		gray_temp2122	<= 'b0;
		gray_temp2200	<= 'b0;
	end
	else begin
		if(en_gauss) begin
			gray_temp	<= gray_temp1 + gray_temp2;
		
			gray_temp1	<= gray_temp11 + gray_temp12;
			gray_temp2	<= gray_temp21 + gray_temp22;
		
			gray_temp11	<= gray_temp111 + gray_temp112;
			gray_temp12	<= gray_temp121 + gray_temp122;
			gray_temp21	<= gray_temp211 + gray_temp212;
			gray_temp22	<= gray_temp220;
		
			gray_temp111	<= gray_temp1111 + gray_temp1112;
			gray_temp112	<= gray_temp1121 + gray_temp1122;
			gray_temp121	<= gray_temp1211 + gray_temp1212;
			gray_temp122	<= gray_temp1221 + gray_temp1222;
			gray_temp211	<= gray_temp2111 + gray_temp2112;
			gray_temp212	<= gray_temp2121 + gray_temp2122;
			gray_temp220	<= gray_temp2200;
		
			gray_temp1111	<= gray_00 * coe_00 + gray_01 * coe_01;
			gray_temp1112	<= gray_02 * coe_02 + gray_03 * coe_03;
			gray_temp1121	<= gray_04 * coe_04 + gray_10 * coe_10;
			gray_temp1122	<= gray_11 * coe_11 + gray_12 * coe_12;
			gray_temp1211	<= gray_13 * coe_13 + gray_14 * coe_14;
			gray_temp1212	<= gray_20 * coe_20 + gray_21 * coe_21;
			gray_temp1221	<= gray_22 * coe_22 + gray_23 * coe_23;
			gray_temp1222	<= gray_24 * coe_24 + gray_30 * coe_30;
			gray_temp2111	<= gray_31 * coe_31 + gray_32 * coe_32;
			gray_temp2112	<= gray_33 * coe_33 + gray_34 * coe_34;
			gray_temp2121	<= gray_40 * coe_40 + gray_41 * coe_41;
			gray_temp2122	<= gray_42 * coe_42 + gray_43 * coe_43;
			gray_temp2200	<= gray_44 * coe_44;
		end
	end
end

always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		gray_out	<= 'b0;
	end
	else begin
		if(en_gauss) begin
			gray_out	<= gray_temp[15:8];
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
		if(en_gauss) begin
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

assign ram4_wdata = (state[1] || state[0]) ? axi_data_in : 'b0;	//when pic input is not done
assign ram4_waddr = ram1_waddr;
assign ram4_raddr = ram1_raddr;

assign gauss_ram_wen = en_gauss;

//edge: gauss 1026*1024, grad 1025*1024. disable gauss when 1026
always@* begin
	if(ram1_raddr == 'd6) begin
		edg	= 'b1;
	end
	else begin
		edg	= 'b0;
	end
end

endmodule