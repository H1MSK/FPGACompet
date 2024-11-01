//function:	1.state machine: buffing, buf done, pic done
//		2."last" output
module cntpix(
	input			clk,
	input			rst_n,
	input			input_valid,
	input			input_ready,
	input			input_last,
	input			output_valid,
	input			output_ready,

	output reg[3:0]		state,
	output reg		output_last
);

reg[20:0]		cnt_pix;
reg			input_last_reg;
reg[3:0]		last_state;

always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		cnt_pix	<= 'd0;
	end
	else begin
		if(state[1] && state[0]) begin
			if(input_valid && input_ready) begin
				cnt_pix	<= cnt_pix + 'd1;
			end
		end
		else if(state[2]) begin
			cnt_pix	<= cnt_pix + 'd1;
		end
	end
end

always@* begin
	if(cnt_pix < 'd5149) begin					//buffing	//1026*2 + 3 + 6 + 1025 + 2 + 5 + 1025 + 2 + 2 + 1025 + 2 = 5149
		state	= 'b0001;
	end
	else if((cnt_pix >= 'd5149) && (cnt_pix < 'd1050624)) begin	//buf done	//1026*1024 = 1050624
		state	= 'b0010;
	end
	else if((cnt_pix >= 'd1050624) && (cnt_pix < 'd1055773)) begin	//pic input done//1050624 + 5149 = 1055773
		state	= 'b0100;
	end
	else if(cnt_pix >= 'd1055773)begin				//process done			
		state	= 'b1000;
	end
	else begin
		state	= 'b0000;
	end
end

//output last generating
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		last_state	<= 'b0;
	end
	else begin
		last_state	<= state;
	end
end

always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		output_last	<= 'b0;
	end
	else begin
		if(output_last == 'b0) begin
			if((last_state == 'b0100) && (state == 'b1000)) begin
				output_last	<= 'b1;
			end
		end
		else begin
			if(output_valid && output_ready) begin
				output_last	<= 'b0;
			end
		end
	end
end

endmodule