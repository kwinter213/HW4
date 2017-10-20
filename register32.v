`include "register.v"
module register32zero
(
output		[31:0]q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30, q31,
input		[31:0]d,
input		[31:0]wrenable,
input		clk
);

register reg0(q0[31:0],d[31:0],wrenable[0],clk);
register reg1(q1[31:0],d[31:0],wrenable[1],clk);
register reg2(q2[31:0],d[31:0],wrenable[ 2 ],clk);
register reg3(q3[31:0],d[31:0],wrenable[ 3 ],clk);
register reg4(q4[31:0],d[31:0],wrenable[ 4 ],clk);
register reg5(q5[31:0],d[31:0],wrenable[ 5 ],clk);
register reg6(q6[31:0],d[31:0],wrenable[ 6 ],clk);
register reg7(q7[31:0],d[31:0],wrenable[ 7 ],clk);
register reg8(q8[31:0],d[31:0],wrenable[ 8 ],clk);
register reg9(q9[31:0],d[31:0],wrenable[ 9 ],clk);
register reg10(q10[31:0],d[31:0],wrenable[ 10 ],clk);
register reg11(q11[31:0],d[31:0],wrenable[ 11 ],clk);
register reg12(q12[31:0],d[31:0],wrenable[ 12 ],clk);
register reg13(q13[31:0],d[31:0],wrenable[ 13 ],clk);
register reg14(q14[31:0],d[31:0],wrenable[ 14 ],clk);
register reg15(q15[31:0],d[31:0],wrenable[ 15 ],clk);
register reg16(q16[31:0],d[31:0],wrenable[ 16 ],clk);
register reg17(q17[31:0],d[31:0],wrenable[ 17 ],clk);
register reg18(q18[31:0],d[31:0],wrenable[ 18 ],clk);
register reg19(q19[31:0],d[31:0],wrenable[ 19 ],clk);
register reg20(q20[31:0],d[31:0],wrenable[ 20 ],clk);
register reg21(q21[31:0],d[31:0],wrenable[ 21 ],clk);
register reg22(q22[31:0],d[31:0],wrenable[ 22 ],clk);
register reg23(q23[31:0],d[31:0],wrenable[ 23 ],clk);
register reg24(q24[31:0],d[31:0],wrenable[ 24 ],clk);
register reg25(q25[31:0],d[31:0],wrenable[ 25 ],clk);
register reg26(q26[31:0],d[31:0],wrenable[ 26 ],clk);
register reg27(q27[31:0],d[31:0],wrenable[ 27 ],clk);
register reg28(q28[31:0],d[31:0],wrenable[ 28 ],clk);
register reg29(q29[31:0],d[31:0],wrenable[ 29 ],clk);
register reg30(q30[31:0],d[31:0],wrenable[ 30 ],clk);
register reg31(q31[31:0],d[31:0],wrenable[ 31 ],clk);

endmodule