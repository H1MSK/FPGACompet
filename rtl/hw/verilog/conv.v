
module conv(
	input			clk,
	input			rst_n,
	input			en_1,
	input			en_2,
	input			en_3,
	input			en_4,
	input			en_5,
	input[3:0]		state,

	input[7:0]		pix_00,		//3*3 window
	input[7:0]		pix_01,
	input[7:0]		pix_02,
	input[7:0]		pix_10,
	input[7:0]		pix_11,
	input[7:0]		pix_12,
	input[7:0]		pix_20,
	input[7:0]		pix_21,
	input[7:0]		pix_22,

	input signed[7:0]	coe_00_in,	//coefficient, sign.xxx_xxxx
	input signed[7:0]	coe_01_in,
	input signed[7:0]	coe_02_in,
	input signed[7:0]	coe_10_in,
	input signed[7:0]	coe_11_in,
	input signed[7:0]	coe_12_in,
	input signed[7:0]	coe_20_in,
	input signed[7:0]	coe_21_in,
	input signed[7:0]	coe_22_in,

	output signed[7:0]	conv_out
);

//coefficients
reg signed[7:0]		coe_00;
reg signed[7:0]		coe_01;
reg signed[7:0]		coe_02;
reg signed[7:0]		coe_10;
reg signed[7:0]		coe_11;
reg signed[7:0]		coe_12;
reg signed[7:0]		coe_20;
reg signed[7:0]		coe_21;
reg signed[7:0]		coe_22;

//product and sum
reg signed[16:0]	prod00;
reg signed[16:0]	prod01;
reg signed[16:0]	prod02;
reg signed[16:0]	prod10;
reg signed[16:0]	prod11;
reg signed[16:0]	prod12;
reg signed[16:0]	prod20;
reg signed[16:0]	prod21;
reg signed[16:0]	prod22;

reg signed[20:0]	sum_temp200;
reg signed[20:0]	sum_temp122;
reg signed[20:0]	sum_temp121;
reg signed[20:0]	sum_temp112;
reg signed[20:0]	sum_temp111;

reg signed[20:0]	sum_temp20;
reg signed[20:0]	sum_temp12;
reg signed[20:0]	sum_temp11;

reg signed[20:0]	sum_temp2;
reg signed[20:0]	sum_temp1;

reg signed[20:0]	sum;

//coe
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		coe_00	<= 'b0;
		coe_01	<= 'b0;
		coe_02	<= 'b0;

		coe_10	<= 'b0;
		coe_11	<= 'b0;
		coe_12	<= 'b0;
		
		coe_20	<= 'b0;
		coe_21	<= 'b0;
		coe_22	<= 'b0;
	end
	else begin
		coe_00	<= coe_00_in;
		coe_01	<= coe_01_in;
		coe_02	<= coe_02_in;
		
		coe_10	<= coe_10_in;
		coe_11	<= coe_11_in;
		coe_12	<= coe_12_in;

		coe_20	<= coe_20_in;
		coe_21	<= coe_21_in;
		coe_22	<= coe_22_in;
	end
end

always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		prod00		<= 'b0;
		prod01		<= 'b0;
		prod02		<= 'b0;
		prod10		<= 'b0;
		prod11		<= 'b0;
		prod12		<= 'b0;
		prod20		<= 'b0;
		prod21		<= 'b0;
		prod22		<= 'b0;

		sum		<= 'b0;

		sum_temp1	<= 'b0;
		sum_temp2	<= 'b0;

		sum_temp11	<= 'b0;
		sum_temp12	<= 'b0;
		sum_temp20	<= 'b0;

		sum_temp111	<= 'b0;
		sum_temp112	<= 'b0;
		sum_temp121	<= 'b0;
		sum_temp122	<= 'b0;
		sum_temp200	<= 'b0;
	end
	else begin
		if(en_1) begin
			prod00		<= $signed({1'b0, pix_00}) * coe_00;
			prod01		<= $signed({1'b0, pix_01}) * coe_01;
			prod02		<= $signed({1'b0, pix_02}) * coe_02;
			prod10		<= $signed({1'b0, pix_10}) * coe_10;
			prod11		<= $signed({1'b0, pix_11}) * coe_11;
			prod12		<= $signed({1'b0, pix_12}) * coe_12;
			prod20		<= $signed({1'b0, pix_20}) * coe_20;
			prod21		<= $signed({1'b0, pix_21}) * coe_21;
			prod22		<= $signed({1'b0, pix_22}) * coe_22;
		end
		if(en_5) begin
			sum		<= sum_temp1 + sum_temp2;
		end
		if(en_4) begin
			sum_temp1	<= sum_temp11 + sum_temp12;
			sum_temp2	<= sum_temp20;
		end
		if(en_3) begin
			sum_temp11	<= sum_temp111 + sum_temp112;
			sum_temp12	<= sum_temp121 + sum_temp122;
			sum_temp20	<= sum_temp200;
		end
		if(en_2) begin
			sum_temp111	<= prod00 + prod01;
			sum_temp112	<= prod02 + prod10;
			sum_temp121	<= prod11 + prod12;
			sum_temp122	<= prod20 + prod21;
			sum_temp200	<= prod22;
		end
	end
end

assign conv_out = $signed({sum[20], sum[13:7]});


endmodule