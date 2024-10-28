//non-maximum suppress
module nms(
	input			clk,
	input			rst_n,
	input			en,

	input[13:0]		grad_in,
	input[13:0]		ram1_rdata,
	input[13:0]		ram2_rdata,

	output[13:0]		ram1_wdata,
	output reg[10:0]	ram1_waddr,
	output reg[10:0]	ram1_raddr,

	output[13:0]		ram2_wdata,
	output[10:0]		ram2_waddr,
	output[10:0]		ram2_raddr,

	output reg[11:0]	val_aft_nms_dly,
	output reg		ovalid
);

reg[7:0]		ram1_rdata_dly1;
reg[7:0]		ram2_rdata_dly1;

reg[11:0]	val_aft_nms;

reg[13:0]	grad_center;
reg[13:0]	grad_near1;
reg[13:0]	grad_near2;

//shifter, store 9 pixel grad
reg[13:0]		grad_00;
reg[13:0]		grad_01;
reg[13:0]		grad_02;
reg[13:0]		grad_10;
reg[13:0]		grad_11;
reg[13:0]		grad_12;
reg[13:0]		grad_20;
reg[13:0]		grad_21;
reg[13:0]		grad_22;

reg[10:0]		cnt_vld;

//input delay
always@(posedge clk) begin
	ram1_rdata_dly1	<= ram1_rdata;
	ram2_rdata_dly1	<= ram2_rdata;
end

//shifter
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		grad_00	<= 'b0;
		grad_01	<= 'b0;
		grad_02	<= 'b0;
		grad_10	<= 'b0;
		grad_11	<= 'b0;
		grad_12	<= 'b0;
		grad_20	<= 'b0;
		grad_21	<= 'b0;
		grad_22	<= 'b0;
	end
	else begin
		if(en) begin
			grad_00	<= grad_01;
			grad_01	<= grad_02;
			grad_02	<= ram1_rdata_dly1;
			grad_10	<= grad_11;
			grad_11	<= grad_12;
			grad_12	<= ram2_rdata_dly1;
			grad_20	<= grad_21;
			grad_21	<= grad_22;
			grad_22	<= grad_in;
		end
	end
end

//comparing
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		val_aft_nms	<= 'b0;
		
		grad_center	<= 'b0;
		grad_near1	<= 'b0;
		grad_near2	<= 'b0;
	end
	else begin
		if(en) begin
			grad_center	<= grad_11;

			case(grad_11[1:0])
				2'b00: begin
					grad_near1	<= grad_10;
					grad_near2	<= grad_12;
				end
				2'b01: begin
					grad_near1	<= grad_02;
					grad_near2	<= grad_20;
				end
				2'b10: begin
					grad_near1	<= grad_01;
					grad_near2	<= grad_21;
				end
				2'b11: begin
					grad_near1	<= grad_00;
					grad_near2	<= grad_22;
				end
			endcase

			if(cnt_vld < 'd1027) begin
				if((ram1_raddr == 'd8)) begin	//edge
					val_aft_nms <= 'b0;
				end
				else begin
					if((grad_center[13:2] < grad_near1[13:2]) || (grad_center[13:2] < grad_near2[13:2])) begin
						val_aft_nms	<= 'b0;
					end
					else begin
						val_aft_nms	<= grad_center[13:2];
					end
				end
			end
			else begin
				val_aft_nms	<= 'b0;
			end
		end
	end
end

always@(posedge	clk) begin
	val_aft_nms_dly	<= val_aft_nms;
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
assign ram2_wdata = grad_in;
assign ram2_waddr = ram1_waddr;
assign ram2_raddr = ram1_raddr;

//output valid
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		cnt_vld	<= 'd0;
	end
	else begin
		if(cnt_vld < 'd1027) begin
			if(ram1_raddr == 'd3) begin
				cnt_vld	<= cnt_vld + 1;
			end
		end
		else begin
			cnt_vld	<= 'd0;
		end
	end
end

always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		ovalid	<= 'b0;
	end
	else begin
		if(cnt_vld == 'd2) begin
			ovalid	<= 'b1;
		end
		else if(cnt_vld == 'd1027) begin
			ovalid	<= 'b0;
		end
	end
end

endmodule