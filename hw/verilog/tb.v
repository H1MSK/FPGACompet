
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
reg		axi_keep;
reg		axi_last;
reg		axi_valid;
reg		dualth_axi_ready;

wire[7:0]	dualth_axi_dout;

top_core	u_top_core(
	.clk			(clk			),
	.rst_n			(rst_n			),

	.axi_data_in		(axi_data_in		),
	.axi_keep		(axi_keep		),
	.axi_last		(axi_last		),
	.axi_valid		(axi_valid		),
	.dualth_axi_ready	(dualth_axi_ready	),

	.coe_00_in		(coe_00_in		),
	.coe_01_in		(coe_01_in		),
	.coe_02_in		(coe_02_in		),
	.coe_11_in		(coe_11_in		),
	.coe_12_in		(coe_12_in		),
	.coe_22_in		(coe_22_in		),

	.gth			(gth			),
	.gtl			(gtl			),

	.gauss_axi_ready	(gauss_axi_ready	),
	.dualth_axi_dout	(dualth_axi_dout	),
	.dualth_axi_valid	(dualth_axi_valid	),
	.dualth_axi_last	(dualth_axi_last	)
);

always #1 clk = ~clk;
integer i;
integer aa;
integer bb;

assign axi_data_in = mem[i];
initial begin
	clk = 0; rst_n = 0; axi_keep = 0; axi_valid = 1; dualth_axi_ready = 1;
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

initial begin
	repeat(4100) begin
		#510	axi_last = 1;
		#2	axi_last = 0;
	end
end

initial begin
	aa = $fopen("E:/DigitalDesign+++++++/competition/data/outcome1026.txt", "w");
	bb = $fopen("E:/DigitalDesign+++++++/competition/data/axv1026.txt", "w");

	forever begin
		#2 begin
			if(dualth_axi_valid) begin
				$fwrite(aa, "%b\n", dualth_axi_dout);
				$fwrite(bb, "%b\n", dualth_axi_valid);
			end
		end
	end

	#2216684 begin
		$fclose(aa);
		$fclose(bb);
	end
end

endmodule