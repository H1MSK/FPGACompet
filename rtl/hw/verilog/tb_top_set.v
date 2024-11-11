
module tb_top_set(
);

reg[7:0]	mem[0:7];

reg			clk;
reg			rst_n;

wire[7:0]		input_axi_data;
reg			input_axi_keep;
reg			input_axi_last;
reg			input_axi_valid;
reg			output_axi_ready;

reg signed[7:0]		coe_00_in;
reg signed[7:0]		coe_01_in;
reg signed[7:0]		coe_02_in;
reg signed[7:0]		coe_10_in;
reg signed[7:0]		coe_11_in;
reg signed[7:0]		coe_12_in;
reg signed[7:0]		coe_20_in;
reg signed[7:0]		coe_21_in;
reg signed[7:0]		coe_22_in;

top_set		u1_top_set(
	.clk			(clk			),
	.rst_n			(rst_n			),

	.input_axi_data		(input_axi_data		),
	.input_axi_keep		(input_axi_keep		),
	.input_axi_last		(input_axi_last		),
	.input_axi_valid	(input_axi_valid	),
	.output_axi_ready	(output_axi_ready	),

	.coe_00_in		(coe_00_in		),
	.coe_01_in		(coe_01_in		),
	.coe_02_in		(coe_02_in		),
	.coe_10_in		(coe_10_in		),
	.coe_11_in		(coe_11_in		),
	.coe_12_in		(coe_12_in		),
	.coe_20_in		(coe_20_in		),
	.coe_21_in		(coe_21_in		),
	.coe_22_in		(coe_22_in		),

	.input_axi_ready	(input_axi_ready	),
	.output_axi_data	(output_axi_data	),
	.output_axi_valid	(output_axi_valid	),
	.output_axi_last	(output_axi_last	),
	.output_axi_keep	(output_axi_keep	),

	.sc1_window_en		(sc1_window_en		)
);

always #1 clk = ~clk;
integer i;

assign input_axi_data = mem[i];
initial begin
	clk = 0; rst_n = 0; input_axi_keep = 1; input_axi_last = 0;
	coe_00_in = 'b100; coe_01_in = 'b100; coe_02_in = 'b100;
	coe_10_in = 'b100; coe_11_in = 'b1000000; coe_12_in = 'b100;
	coe_20_in = 'b100; coe_21_in = 'b100; coe_22_in = 'b100;
	i = 0;
	$readmemb("E:/DigitalDesign+++++++/competition/data/num.txt", mem);

	#2 begin
		rst_n = 1;
		repeat(1000000) begin
			#2 begin
				if(sc1_window_en) begin
					if(i < 7) begin
						i = i + 1;
					end
					else begin
						i = 0;
					end
				end
			end
		end
	end
	
	#10	$finish;
end

initial begin
	input_axi_valid = 1;
	repeat(1000) begin
		#100	input_axi_valid = 0;
		#2	input_axi_valid = 1;
		#2000	input_axi_valid = 0;
		#4	input_axi_valid = 1;
		#200	input_axi_valid = 0;
		#2	input_axi_valid = 1;
		#200	input_axi_valid = 0;
		#4	input_axi_valid = 1;
	end
end

initial begin
	output_axi_ready = 1;
	repeat(1000) begin
		#106	output_axi_ready = 0;
		#4	output_axi_ready = 1;
		#2008	output_axi_ready = 0;
		#4	output_axi_ready = 1;
		#196	output_axi_ready = 0;
		#2	output_axi_ready = 1;
		#210	output_axi_ready = 0;
		#4	output_axi_ready = 1;
	end
end

endmodule