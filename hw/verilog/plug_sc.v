//transparent when buf is done
module plug_sc(
	input		ivalid,
	input		oready,
	input[3:0]	state,

	output reg	iready,
	output reg	ovalid
);

always@* begin
	case(state)
		'b0001: begin
			iready	= 'b1;
			ovalid	= 'b0;
		end
		'b0010: begin
			iready	= oready;
			ovalid	= ivalid;
		end
		'b0100: begin
			iready	= oready;
			ovalid	= 'b1;
		end
		default: begin
			iready	= 'b0;
			ovalid	= 'b0;
		end
	endcase
end

endmodule