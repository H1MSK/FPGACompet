
module top_core(
	input			clk,
	input			rst_n,

	input[7:0]		axi_data_in,
	input			axi_keep,
	input			axi_last,
	input			axi_valid,
	input			dualth_axi_ready,

	input[7:0]		coe_00_in,
	input[7:0]		coe_01_in,
	input[7:0]		coe_02_in,
	input[7:0]		coe_11_in,
	input[7:0]		coe_12_in,
	input[7:0]		coe_22_in,

	input[7:0]		gth,
	input[7:0]		gtl,

	output			gauss_axi_ready,
	output[7:0]		dualth_axi_dout,
	output			dualth_axi_valid,
	output			dualth_axi_last,
	output			dualth_axi_keep
);

wire[7:0]		gauss_ram1_rdata;
wire[7:0]		gauss_ram2_rdata;
wire[7:0]		gauss_ram3_rdata;
wire[7:0]		gauss_ram4_rdata;

wire[7:0]		gauss_ram1_wdata;
wire[10:0]		gauss_ram1_waddr;
wire[10:0]		gauss_ram1_raddr;

wire[7:0]		gauss_ram2_wdata;
wire[10:0]		gauss_ram2_waddr;
wire[10:0]		gauss_ram2_raddr;

wire[7:0]		gauss_ram3_wdata;
wire[10:0]		gauss_ram3_waddr;
wire[10:0]		gauss_ram3_raddr;

wire[7:0]		gauss_ram4_wdata;
wire[10:0]		gauss_ram4_waddr;
wire[10:0]		gauss_ram4_raddr;

wire[7:0]		gauss_gray_out;
wire			gauss_ovalid;
wire			gauss_ram_wen;


wire[7:0]	grad_ram1_rdata;
wire[7:0]	grad_ram2_rdata;
wire[7:0]	grad_ram1_wdata;
wire[10:0]	grad_ram1_waddr;
wire[10:0]	grad_ram1_raddr;
wire[7:0]	grad_ram2_wdata;
wire[10:0]	grad_ram2_waddr;
wire[10:0]	grad_ram2_raddr;
wire[13:0]	grad_val_dir;
wire		grad_ovalid;


wire[13:0]	nms_ram1_rdata;
wire[13:0]	nms_ram2_rdata;
wire[13:0]	nms_ram1_wdata;
wire[10:0]	nms_ram1_waddr;
wire[10:0]	nms_ram1_raddr;
wire[13:0]	nms_ram2_wdata;
wire[10:0]	nms_ram2_waddr;
wire[10:0]	nms_ram2_raddr;
wire[11:0]	val_aft_nms_dly;
wire		nms_ovalid;

wire[1:0]	dualth_ram1_rdata;
wire[1:0]	dualth_ram2_rdata;
wire[1:0]	dualth_ram1_wdata;
wire[10:0]	dualth_ram1_waddr;
wire[10:0]	dualth_ram1_raddr;
wire[1:0]	dualth_ram2_wdata;
wire[10:0]	dualth_ram2_waddr;
wire[10:0]	dualth_ram2_raddr;
wire[7:0]	dualth_gray_out_dly;
wire		dualth_ovalid;

assign dualth_axi_keep = 1;

gauss		u_gauss(
	.clk		(clk			),
	.rst_n		(rst_n			),

	.axi_data_in	(axi_data_in		),
	.axi_keep	(),
	.axi_last	(axi_last		),
	.axi_valid	(axi_valid		),
	.dualth_axi_ready(dualth_axi_ready	),

	.coe_00_in	(coe_00_in		),
	.coe_01_in	(coe_01_in		),
	.coe_02_in	(coe_02_in		),
	.coe_11_in	(coe_11_in		),
	.coe_12_in	(coe_12_in		),
	.coe_22_in	(coe_22_in		),

	.ram1_rdata	(gauss_ram1_rdata	),
	.ram2_rdata	(gauss_ram2_rdata	),
	.ram3_rdata	(gauss_ram3_rdata	),
	.ram4_rdata	(gauss_ram4_rdata	),

	.ram1_wdata	(gauss_ram1_wdata	),
	.ram1_waddr	(gauss_ram1_waddr	),
	.ram1_raddr	(gauss_ram1_raddr	),

	.ram2_wdata	(gauss_ram2_wdata	),
	.ram2_waddr	(gauss_ram2_waddr	),
	.ram2_raddr	(gauss_ram2_raddr	),

	.ram3_wdata	(gauss_ram3_wdata	),
	.ram3_waddr	(gauss_ram3_waddr	),
	.ram3_raddr	(gauss_ram3_raddr	),

	.ram4_wdata	(gauss_ram4_wdata	),
	.ram4_waddr	(gauss_ram4_waddr	),
	.ram4_raddr	(gauss_ram4_raddr	),

	.gray_out	(gauss_gray_out		),
	.ovalid		(gauss_ovalid		),
	.gauss_axi_ready(gauss_axi_ready	),
	.gauss_ram_wen	(gauss_ram_wen		)
);

ram8b		u1_ram8b(
	.a		(gauss_ram1_waddr	),
	.d		(gauss_ram1_wdata	),
	.dpra		(gauss_ram1_raddr	),
	.clk		(clk			),
	.we		(gauss_ram_wen		),
	.dpo		(gauss_ram1_rdata	)
);

ram8b		u2_ram8b(
	.a		(gauss_ram2_waddr	),
	.d		(gauss_ram2_wdata	),
	.dpra		(gauss_ram2_raddr	),
	.clk		(clk			),
	.we		(gauss_ram_wen		),
	.dpo		(gauss_ram2_rdata	)
);

ram8b		u3_ram8b(
	.a		(gauss_ram3_waddr	),
	.d		(gauss_ram3_wdata	),
	.dpra		(gauss_ram3_raddr	),
	.clk		(clk			),
	.we		(gauss_ram_wen		),
	.dpo		(gauss_ram3_rdata	)
);

ram8b		u4_ram8b(
	.a		(gauss_ram4_waddr	),
	.d		(gauss_ram4_wdata	),
	.dpra		(gauss_ram4_raddr	),
	.clk		(clk			),
	.we		(gauss_ram_wen		),
	.dpo		(gauss_ram4_rdata	)
);

//
grad		u_grad(
	.clk		(clk			),
	.rst_n		(rst_n			),
	.en		(gauss_ovalid		),

	.gray_in	(gauss_gray_out		),
	.ram1_rdata	(grad_ram1_rdata	),
	.ram2_rdata	(grad_ram2_rdata	),

	.ram1_wdata	(grad_ram1_wdata	),
	.ram1_waddr	(grad_ram1_waddr	),
	.ram1_raddr	(grad_ram1_raddr	),

	.ram2_wdata	(grad_ram2_wdata	),
	.ram2_waddr	(grad_ram2_waddr	),
	.ram2_raddr	(grad_ram2_raddr	),

	.grad_val_dir	(grad_val_dir		),
	.ovalid		(		)
);

ram8b		u5_ram8b(
	.a		(grad_ram1_waddr	),
	.d		(grad_ram1_wdata	),
	.dpra		(grad_ram1_raddr	),
	.clk		(clk			),
	.we		(gauss_ovalid		),
	.dpo		(grad_ram1_rdata	)
);

ram8b		u6_ram8b(
	.a		(grad_ram2_waddr	),
	.d		(grad_ram2_wdata	),
	.dpra		(grad_ram2_raddr	),
	.clk		(clk			),
	.we		(gauss_ovalid		),
	.dpo		(grad_ram2_rdata	)
);


nms		u_nms(
	.clk		(clk			),
	.rst_n		(rst_n			),
	.en		(gauss_ovalid		),

	.grad_in	(grad_val_dir		),
	.ram1_rdata	(nms_ram1_rdata		),
	.ram2_rdata	(nms_ram2_rdata		),

	.ram1_wdata	(nms_ram1_wdata		),
	.ram1_waddr	(nms_ram1_waddr		),
	.ram1_raddr	(nms_ram1_raddr		),

	.ram2_wdata	(nms_ram2_wdata		),
	.ram2_waddr	(nms_ram2_waddr		),
	.ram2_raddr	(nms_ram2_raddr		),

	.val_aft_nms_dly(val_aft_nms_dly	),
	.ovalid		(		)
);

ram14b		u1_ram14b(
	.a		(nms_ram1_waddr		),
	.d		(nms_ram1_wdata		),
	.dpra		(nms_ram1_raddr		),
	.clk		(clk			),
	.we		(gauss_ovalid		),
	.dpo		(nms_ram1_rdata		)
);

ram14b		u2_ram14b(
	.a		(nms_ram2_waddr		),
	.d		(nms_ram2_wdata		),
	.dpra		(nms_ram2_raddr		),
	.clk		(clk			),
	.we		(gauss_ovalid		),
	.dpo		(nms_ram2_rdata		)
);


dualth		u_dualth(
	.clk		(clk			),
	.rst_n		(rst_n			),
	.en		(gauss_ovalid		),
	.dualth_axi_ready(dualth_axi_ready	),

	.gth		(gth			),
	.gtl		(gtl			),

	.val_aft_nms_dly(val_aft_nms_dly	),
	.ram1_rdata	(dualth_ram1_rdata	),
	.ram2_rdata	(dualth_ram2_rdata	),

	.ram1_waddr	(dualth_ram1_waddr	),
	.ram1_raddr	(dualth_ram1_raddr	),
	.ram1_wdata	(dualth_ram1_wdata	),

	.ram2_waddr	(dualth_ram2_waddr	),
	.ram2_raddr	(dualth_ram2_raddr	),
	.ram2_wdata	(dualth_ram2_wdata	),

	.gray_out_dly	(dualth_axi_dout	),
	.axi_valid	(dualth_axi_valid	),
	.axi_last	(dualth_axi_last	)
);

ram2b		u1_ram2b(
	.a		(dualth_ram1_waddr	),
	.d		(dualth_ram1_wdata	),
	.dpra		(dualth_ram1_raddr	),
	.clk		(clk			),
	.we		(gauss_ovalid		),
	.dpo		(dualth_ram1_rdata	)
);

ram2b		u2_ram2b(
	.a		(dualth_ram2_waddr	),
	.d		(dualth_ram2_wdata	),
	.dpra		(dualth_ram2_raddr	),
	.clk		(clk			),
	.we		(gauss_ovalid		),
	.dpo		(dualth_ram2_rdata	)
);

endmodule