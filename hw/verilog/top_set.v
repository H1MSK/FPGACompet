// window + conv + relu = 1 set
module top_set(
	input			clk,
	input			rst_n,

	input[7:0]		input_axi_data,
	input			input_axi_keep,
	input			input_axi_last,
	input			input_axi_valid,
	input			output_axi_ready,

	input signed[7:0]	coe_00_in,
	input signed[7:0]	coe_01_in,
	input signed[7:0]	coe_02_in,
	input signed[7:0]	coe_10_in,
	input signed[7:0]	coe_11_in,
	input signed[7:0]	coe_12_in,
	input signed[7:0]	coe_20_in,
	input signed[7:0]	coe_21_in,
	input signed[7:0]	coe_22_in,

	output			input_axi_ready,
	output[7:0]		output_axi_data,
	output			output_axi_valid,
	output			output_axi_last,
	output			output_axi_keep,

	output			sc1_window_en
);

wire[3:0]		state;

wire[7:0]		win_ram1_rdata;
wire[7:0]		win_ram2_rdata;
wire[7:0]		win_ram1_wdata;
wire[10:0]		win_ram1_waddr;
wire[10:0]		win_ram1_raddr;
wire[7:0]		win_ram2_wdata;
wire[10:0]		win_ram2_waddr;
wire[10:0]		win_ram2_raddr;

wire[7:0]		pix_00;
wire[7:0]		pix_01;
wire[7:0]		pix_02;
wire[7:0]		pix_10;
wire[7:0]		pix_11;
wire[7:0]		pix_12;
wire[7:0]		pix_20;
wire[7:0]		pix_21;
wire[7:0]		pix_22;

wire[7:0]		conv_out;

assign output_axi_keep = 1;

cntpix		u_cntpix(
	.clk		(clk			),
	.rst_n		(rst_n			),
	.en_1		(sc1_window_en		),
	.input_last	(input_axi_last		),

	.output_valid	(output_axi_valid	),
	.output_ready	(output_axi_ready	),

	.state		(state			),
	.output_last	(output_axi_last	)
);

StreamController_1	u1_sc_window(
	.ivalid		(input_axi_valid	),
	.iready		(input_axi_ready	),
	.ovalid		(sc1_window_ovalid	),
	.oready		(sc1_window_oready && (~win_not_ready)	),
	.en_0		(sc1_window_en		),
	.clk		(clk			),
	.resetn		(rst_n			)
);

plug_sc			u_plug_sc(
	.ivalid		(sc1_window_ovalid	),
	.oready		(sc1_conv_iready	),
	.state		(state			),

	.iready		(sc1_window_oready	),
	.ovalid		(sc1_conv_ivalid	)
);

window			u_window(
	.clk		(clk			),
	.rst_n		(rst_n			),
	.en_1		(sc1_window_en		),
	.state		(state			),

	.pix_in		(input_axi_data		),

	.ram1_rdata	(win_ram1_rdata		),
	.ram2_rdata	(win_ram2_rdata		),

	.ram1_wdata	(win_ram1_wdata		),
	.ram1_waddr	(win_ram1_waddr		),
	.ram1_raddr	(win_ram1_raddr		),

	.ram2_wdata	(win_ram2_wdata		),
	.ram2_waddr	(win_ram2_waddr		),
	.ram2_raddr	(win_ram2_raddr		),

	.win_ram_wen	(win_ram_wen		),

	.pix_00		(pix_00			),
	.pix_01		(pix_01			),
	.pix_02		(pix_02			),
	.pix_10		(pix_10			),
	.pix_11		(pix_11			),
	.pix_12		(pix_12			),
	.pix_20		(pix_20			),
	.pix_21		(pix_21			),
	.pix_22		(pix_22			),

	.en_window	(en_window		),
	.not_ready	(win_not_ready		),
	.not_valid	(win_not_valid		)
);

ram8b		u1_ram8b(
	.a		(win_ram1_waddr		),
	.d		(win_ram1_wdata		),
	.dpra		(win_ram1_raddr		),
	.clk		(clk			),
	.we		(win_ram_wen		),
	.dpo		(win_ram1_rdata		)
);

ram8b		u2_ram8b(
	.a		(win_ram2_waddr		),
	.d		(win_ram2_wdata		),
	.dpra		(win_ram2_raddr		),
	.clk		(clk			),
	.we		(win_ram_wen		),
	.dpo		(win_ram2_rdata		)
);

StreamController_1	u1_sc_conv(
	.ivalid		(sc1_conv_ivalid && (~win_not_valid)	),
	.iready		(sc1_conv_iready	),
	.ovalid		(sc1_conv_ovalid	),
	.oready		(sc1_conv_oready	),
	.en_0		(sc1_conv_en		),
	.clk		(clk			),
	.resetn		(rst_n			)
);
StreamController_1	u2_sc_conv(
	.ivalid		(sc1_conv_ovalid	),
	.iready		(sc1_conv_oready	),
	.ovalid		(sc2_conv_ovalid	),
	.oready		(sc2_conv_oready	),
	.en_0		(sc2_conv_en		),
	.clk		(clk			),
	.resetn		(rst_n			)
);
StreamController_1	u3_sc_conv(
	.ivalid		(sc2_conv_ovalid	),
	.iready		(sc2_conv_oready	),
	.ovalid		(sc3_conv_ovalid	),
	.oready		(sc3_conv_oready	),
	.en_0		(sc3_conv_en		),
	.clk		(clk			),
	.resetn		(rst_n			)
);
StreamController_1	u4_sc_conv(
	.ivalid		(sc3_conv_ovalid	),
	.iready		(sc3_conv_oready	),
	.ovalid		(sc4_conv_ovalid	),
	.oready		(sc4_conv_oready	),
	.en_0		(sc4_conv_en		),
	.clk		(clk			),
	.resetn		(rst_n			)
);
StreamController_1	u5_sc_conv(
	.ivalid		(sc4_conv_ovalid	),
	.iready		(sc4_conv_oready	),
	.ovalid		(sc5_conv_ovalid	),
	.oready		(sc5_conv_oready	),
	.en_0		(sc5_conv_en		),
	.clk		(clk			),
	.resetn		(rst_n			)
);

conv			u_conv(
	.clk		(clk			),
	.rst_n		(rst_n			),
	.en_1		(sc1_conv_en		),
	.en_2		(sc2_conv_en		),
	.en_3		(sc3_conv_en		),
	.en_4		(sc4_conv_en		),
	.en_5		(sc5_conv_en		),
	.state		(state			),

	.pix_00		(pix_00			),
	.pix_01		(pix_01			),
	.pix_02		(pix_02			),
	.pix_10		(pix_10			),
	.pix_11		(pix_11			),
	.pix_12		(pix_12			),
	.pix_20		(pix_20			),
	.pix_21		(pix_21			),
	.pix_22		(pix_22			),

	.coe_00_in	(coe_00_in		),
	.coe_01_in	(coe_01_in		),
	.coe_02_in	(coe_02_in		),
	.coe_10_in	(coe_10_in		),
	.coe_11_in	(coe_11_in		),
	.coe_12_in	(coe_12_in		),
	.coe_20_in	(coe_20_in		),
	.coe_21_in	(coe_21_in		),
	.coe_22_in	(coe_22_in		),

	.conv_out	(conv_out		)
);

StreamController_1	u1_sc_relu(
	.ivalid		(sc5_conv_ovalid	),
	.iready		(sc5_conv_oready	),
	.ovalid		(output_axi_valid	),
	.oready		(output_axi_ready	),
	.en_0		(sc1_relu_en		),
	.clk		(clk			),
	.resetn		(rst_n			)
);

relu			u_relu(
	.clk		(clk			),
	.rst_n		(rst_n			),
	.en_1		(sc1_relu_en		),
	.data_in	(conv_out		),

	.data_out	(output_axi_data	)
);
endmodule