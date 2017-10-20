module mux32to1by1
(
output   out,
input[4:0]  address,
input[31:0] inputs
);
integer my_int_address;
always @( address ) begin
	my_int_address=address[4:0];		
	out=my_int_address;
end
endmodule