//transparent when buf is done
module plug_sc(
	input		ivalid,
	input		oready,
	input[3:0]	state,

	output reg	iready,
	output reg	ovalid
);

always@* begin
	if(state == 'b0001) begin
		iready	= 'b1;
		ovalid	= 'b0;
	end
	else begin
		iready	= oready;
		ovalid	= ivalid;
	end
end

endmodule