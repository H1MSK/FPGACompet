//dda_out = max{data_in, 0}
module relu(
	input			clk,
	input			rst_n,
	input			en_1,
	input signed[7:0]	data_in,
	
	output reg[7:0]		data_out
);

always@(posedge clk or negedge rst_n)begin
	if(~rst_n) begin
		data_out	<= 'b0;
	end
	else begin
		if(en_1) begin
			if(data_in[7]) begin	//neg
				data_out	<= 'b0;
			end
			else begin		//pos
				data_out	<= data_in;
			end
		end
	end
end

endmodule