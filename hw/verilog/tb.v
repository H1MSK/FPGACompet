
module tb(	
);

reg		clk;
reg		rst_n;

reg[7:0]	mem[0:1049599];
reg[7:0]	coe_00_in;
reg[7:0]	coe_01_in;
reg[7:0]	coe_02_in;
reg[7:0]	coe_11_in;
reg[7:0]	coe_12_in;
reg[7:0]	coe_22_in;
reg[7:0]	gth;
reg[7:0]	gtl;

wire[7:0]	axi_data_in;
reg		input_axi_keep;
reg		input_axi_last;
reg		input_axi_valid;
reg		output_axi_ready;

wire[7:0]	output_axi_dout;

top_core	u_top_core(
	.clk			(clk			),
	.rst_n			(rst_n			),

	.axi_data_in		(axi_data_in		),
	.input_axi_keep		(input_axi_keep		),
	.input_axi_last		(input_axi_last		),
	.input_axi_valid	(input_axi_valid	),
	.output_axi_ready	(output_axi_ready	),

	.coe_00_in		(coe_00_in		),
	.coe_01_in		(coe_01_in		),
	.coe_02_in		(coe_02_in		),
	.coe_11_in		(coe_11_in		),
	.coe_12_in		(coe_12_in		),
	.coe_22_in		(coe_22_in		),

	.gth			(gth			),
	.gtl			(gtl			),

	.input_axi_ready	(input_axi_ready	),
	.output_axi_dout	(output_axi_dout	),
	.output_axi_valid	(output_axi_valid	),
	.output_axi_last	(output_axi_last	)
);

always #1 clk = ~clk;
integer i;
integer aa;
integer bb;

assign axi_data_in = mem[i];
initial begin
	clk = 0; rst_n = 0; input_axi_keep = 0; input_axi_valid = 1; output_axi_ready = 1; input_axi_last = 0;
	coe_00_in = 'b100; coe_01_in = 'b100; coe_02_in = 'b100; 
	coe_11_in = 'b100; coe_12_in = 'b100; coe_22_in = 'b100;
	gth = 5; gtl = 1;
	i = 0;
	$readmemh("E:/DigitalDesign+++++++/competition/data/gray_txt_out15_3.txt", mem);

	#2 begin
		rst_n = 1;
		repeat(1049599) begin
			#2 begin
				if(i < 1049599) begin
					i = i + 1;
				end
				else begin
					i = 0;
				end
			end
		end
	end
	
	#16694	$finish;

end

/*
initial begin
	aa = $fopen("E:/DigitalDesign+++++++/competition/data/outcome1026.txt", "w");
	bb = $fopen("E:/DigitalDesign+++++++/competition/data/axv1026.txt", "w");

	forever begin
		#2 begin
			if(dualth_axi_valid) begin
				$fwrite(aa, "%b\n", output_axi_dout);
				$fwrite(bb, "%b\n", output__axi_valid);
			end
		end
	end

	#2216684 begin
		$fclose(aa);
		$fclose(bb);
	end
end
*/

endmodule