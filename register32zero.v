module register32zero
(
output reg  [31:0]q,
input       [31:0]d,
input       wrenable,
input       clk
);
    always @(posedge clk) begin
        if(wrenable) begin
            q[31:0] = 32'b00000000000000000000000000000000;
        end
    end
endmodule