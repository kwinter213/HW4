// Single-bit D Flip-Flop with enable
//   Positive edge triggered

module register
(
output reg	[31:0]q,
input		[31:0]d,
input		wrenable,
input		clk
);

    always @(posedge clk) begin
        if(wrenable) begin
            q[31:0] = d[31:0];
        end
        else
        	q[31:0]= 32'b00000000000000000000000000000000;
    end
endmodule