//function: calculating value and direction of graditude of each pixel
module grad(
	input			clk,
	input			rst_n,
	input			en,

	input[7:0]		gray_in,
	input[7:0]		ram1_rdata,
	input[7:0]		ram2_rdata,

	output[7:0]		ram1_wdata,
	output reg[10:0]	ram1_waddr,
	output reg[10:0]	ram1_raddr,

	output[7:0]		ram2_wdata,
	output[10:0]		ram2_waddr,
	output[10:0]		ram2_raddr,

	output reg[13:0]	grad_val_dir,
	output reg		ovalid
);

reg[7:0]		ram1_rdata_dly1;
reg[7:0]		ram2_rdata_dly1;

//shifter, store 9 pixel gray
reg[7:0]		gray_00;
reg[7:0]		gray_01;
reg[7:0]		gray_02;
reg[7:0]		gray_10;
reg[7:0]		gray_11;
reg[7:0]		gray_12;
reg[7:0]		gray_20;
reg[7:0]		gray_21;
reg[7:0]		gray_22;

//gratitude x and y
reg signed[10:0]	gx;
reg signed[10:0]	gy;
reg [10:0]		gx_abs;
reg [10:0]		gy_abs;

//grad value and direction
reg[11:0]		grad_val;
reg[1:0]		grad_dir;	//4 directions, 00: x axis; 01: 45; 10: y axis; 11: 135

reg[10:0]		cnt_vld;

//input delay
always@(posedge clk) begin
	ram1_rdata_dly1	<= ram1_rdata;
	ram2_rdata_dly1	<= ram2_rdata;
end

//shifter
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		gray_00	<= 'b0;
		gray_01	<= 'b0;
		gray_02	<= 'b0;
		gray_10	<= 'b0;
		gray_11	<= 'b0;
		gray_12	<= 'b0;
		gray_20	<= 'b0;
		gray_21	<= 'b0;
		gray_22	<= 'b0;
	end
	else begin
		if(en) begin
			gray_00	<= gray_01;
			gray_01	<= gray_02;
			gray_02	<= ram1_rdata_dly1;
			gray_10	<= gray_11;
			gray_11	<= gray_12;
			gray_12	<= ram2_rdata_dly1;
			gray_20	<= gray_21;
			gray_21	<= gray_22;
			gray_22	<= gray_in;
		end
	end
end

//gratitude x and y
//sobel: x: 1  0 -1   y: 1  2  1
//	    2  0 -2      0  0  0
//	    1  0 -1     -1 -2 -1
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		gx	<= 'b0;
		gy	<= 'b0;
	end
	else begin
		gx	<= 	$signed({3'b0, gray_00}) - $signed({3'b0, gray_02})
				+ $signed({2'b0, gray_10, 1'b0}) - $signed({2'b0, gray_12, 1'b0})
				+ $signed({3'b0, gray_20}) - $signed({3'b0,gray_22});

		gy	<=	$signed({3'b0, gray_00}) + $signed({2'b0, gray_01, 1'b1})
				+ $signed({3'b0, gray_02}) - $signed({3'b0, gray_20})
				- $signed({2'b0, gray_21, 1'b0}) - $signed({3'b0, gray_22});
	end
end

always@* begin
	if(gx[10]) begin	//gx < 0
		gx_abs	= ~gx + 11'b1;
	end
	else begin		//gx > 0
		gx_abs = gx;
	end
end

always@* begin
	if(gy[10]) begin	//gy < 0
		gy_abs	= ~gy + 11'b1;
	end
	else begin		//gy > 0
		gy_abs = gy;
	end
end

always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		grad_val	<= 'b0;
		grad_dir	<= 'b0;
	end
	else begin
		grad_val	<= {1'b0, gx_abs} + {1'b0, gy_abs};

		if({1'b0, gx_abs} >= {gy_abs, 1'b0}) begin
			grad_dir	<= 'b00;
		end
		else if( ({1'b0, gx_abs} < {gy_abs, 1'b0}) && ({gx_abs, 1'b0} > {1'b0, gy_abs})) begin
			if(gx[10] ^ gy[10]) begin	//gxgy < 0
				grad_dir	<= 'b11;
			end
			else begin	//gxgy > 0
				grad_dir	<= 'b01;
			end
		end
		else begin
			grad_dir	<= 'b10;
		end
	end
end

always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		grad_val_dir	<= 'b0;
	end
	else begin
		if(cnt_vld < 'd1028) begin
			if((ram1_raddr == 'd4)) begin	//edge
				grad_val_dir <= 'b0;
			end
			else begin
				grad_val_dir	<= {grad_val, grad_dir};
			end
		end
		else begin
			grad_val_dir <= 'b0;
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
assign ram2_wdata = gray_in;
assign ram2_waddr = ram1_waddr;
assign ram2_raddr = ram1_raddr;

//output valid
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		cnt_vld	<= 'd0;
	end
	else begin
		if(en) begin
			if(cnt_vld < 'd1028) begin
				if(ram1_raddr == 'd4) begin
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
		ovalid	<= 'b0;
	end
	else begin
		if(cnt_vld == 'd2) begin
			ovalid	<= 'b1;
		end
		else if(cnt_vld == 'd1028) begin
			ovalid	<= 'b0;
		end
	end
end

endmodule
