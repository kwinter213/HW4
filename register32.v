module register
(
output reg  [31:0]q,
input       [31:0]d,
input       wrenable,
input       clk
);
    always @(posedge clk) begin
        if(wrenable) begin
            q[31:0] = d[31:0];
        end
    end
endmodule