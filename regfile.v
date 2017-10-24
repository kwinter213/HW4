//------------------------------------------------------------------------------
// MIPS register file
//   width: 32 bits
//   depth: 32 words (reg[0] is static zero register)
//   2 asynchronous read ports
//   1 synchronous, positive edge triggered write port
//------------------------------------------------------------------------------
`include "register32zero.v"
`include "register32.v"
`include "mux32to1by32.v"

module regfile
(
output[31:0]	ReadData1,	// Contents of first register read
output[31:0]	ReadData2,	// Contents of second register read
input[31:0]	WriteData,	// Contents to write to register
input[4:0]	ReadRegister1,	// Address of first register to read
input[4:0]	ReadRegister2,	// Address of second register to read
input[4:0]	WriteRegister,	// Address of register to write
input		RegWrite,	// Enable writing of register when High
input		Clk		// Clock (Positive Edge Triggered)
);

wire [31:0]dout; //output for decoder
wire [31:0]zout; //zeroregout
wire [31:0]regout1; //output for reg 1 ...31
wire [31:0]regout2 ;
wire [31:0]regout3 ;
wire [31:0]regout4 ;
wire [31:0]regout5 ;
wire [31:0]regout6 ;
wire [31:0]regout7 ;
wire [31:0]regout8 ;
wire [31:0]regout9 ;
wire [31:0]regout10 ;
wire [31:0]regout11 ;
wire [31:0]regout12 ;
wire [31:0]regout13 ;
wire [31:0]regout14 ;
wire [31:0]regout15 ;
wire [31:0]regout16 ;
wire [31:0]regout17 ;
wire [31:0]regout18 ;
wire [31:0]regout19 ;
wire [31:0]regout20 ;
wire [31:0]regout21 ;
wire [31:0]regout22 ;
wire [31:0]regout23 ;
wire [31:0]regout24 ;
wire [31:0]regout25 ;
wire [31:0]regout26 ;
wire [31:0]regout27 ;
wire [31:0]regout28 ;
wire [31:0]regout29 ;
wire [31:0]regout30 ;
wire [31:0]regout31;



//Decoder
decoder1to32 decoder(dout[31:0], RegWrite, WriteRegister[4:0]);

//zero register
register32zero zreg(zout[31:0], WriteData[31:0], dout[0], Clk);

//other registers (1-31)
register32 reg1(regout1[31:0], WriteData[31:0], dout[1], Clk);
register32 reg2 (regout2 [31:0], WriteData[31:0],dout[ 2 ],Clk);
register32 reg3 (regout3 [31:0], WriteData[31:0],dout[ 3 ],Clk);
register32 reg4 (regout4 [31:0], WriteData[31:0],dout[ 4 ],Clk);
register32 reg5 (regout5 [31:0], WriteData[31:0],dout[ 5 ],Clk);
register32 reg6 (regout6 [31:0], WriteData[31:0],dout[ 6 ],Clk);
register32 reg7 (regout7 [31:0], WriteData[31:0],dout[ 7 ],Clk);
register32 reg8 (regout8 [31:0], WriteData[31:0],dout[ 8 ],Clk);
register32 reg9 (regout9 [31:0], WriteData[31:0],dout[ 9 ],Clk);
register32 reg10 (regout10 [31:0], WriteData[31:0],dout[ 10 ],Clk);
register32 reg11 (regout11 [31:0], WriteData[31:0],dout[ 11 ],Clk);
register32 reg12 (regout12 [31:0], WriteData[31:0],dout[ 12 ],Clk);
register32 reg13 (regout13 [31:0], WriteData[31:0],dout[ 13 ],Clk);
register32 reg14 (regout14 [31:0], WriteData[31:0],dout[ 14 ],Clk);
register32 reg15 (regout15 [31:0], WriteData[31:0],dout[ 15 ],Clk);
register32 reg16 (regout16 [31:0], WriteData[31:0],dout[ 16 ],Clk);
register32 reg17 (regout17 [31:0], WriteData[31:0],dout[ 17 ],Clk);
register32 reg18 (regout18 [31:0], WriteData[31:0],dout[ 18 ],Clk);
register32 reg19 (regout19 [31:0], WriteData[31:0],dout[ 19 ],Clk);
register32 reg20 (regout20 [31:0], WriteData[31:0],dout[ 20 ],Clk);
register32 reg21 (regout21 [31:0], WriteData[31:0],dout[ 21 ],Clk);
register32 reg22 (regout22 [31:0], WriteData[31:0],dout[ 22 ],Clk);
register32 reg23 (regout23 [31:0], WriteData[31:0],dout[ 23 ],Clk);
register32 reg24 (regout24 [31:0], WriteData[31:0],dout[ 24 ],Clk);
register32 reg25 (regout25 [31:0], WriteData[31:0],dout[ 25 ],Clk);
register32 reg26 (regout26 [31:0], WriteData[31:0],dout[ 26 ],Clk);
register32 reg27 (regout27 [31:0], WriteData[31:0],dout[ 27 ],Clk);
register32 reg28 (regout28 [31:0], WriteData[31:0],dout[ 28 ],Clk);
register32 reg29 (regout29 [31:0], WriteData[31:0],dout[ 29 ],Clk);
register32 reg30 (regout30 [31:0], WriteData[31:0],dout[ 30 ],Clk);
register32 reg31 (regout31 [31:0], WriteData[31:0],dout[ 31 ],Clk);

//MUX0
mux32to1by32 mux0(ReadData1[31:0],ReadRegister1[4:0],zout[31:0],regout1[31:0],regout2[31:0],regout3[31:0],regout4[31:0],regout5[31:0],regout6[31:0],regout7[31:0],regout8[31:0],regout9[31:0],regout10[31:0],regout11[31:0],regout12[31:0],regout13[31:0],regout14[31:0],regout15[31:0],regout16[31:0],regout17[31:0],regout18[31:0],regout19[31:0],regout20[31:0],regout21[31:0],regout22[31:0],regout23[31:0],regout24[31:0],regout25[31:0],regout26[31:0],regout27[31:0],regout28[31:0],regout29[31:0],regout30[31:0],regout31[31:0]);

//MUX1
mux32to1by32 mux1(ReadData2[31:0],ReadRegister2[4:0],zout[31:0],regout1[31:0],regout2[31:0],regout3[31:0],regout4[31:0],regout5[31:0],regout6[31:0],regout7[31:0],regout8[31:0],regout9[31:0],regout10[31:0],regout11[31:0],regout12[31:0],regout13[31:0],regout14[31:0],regout15[31:0],regout16[31:0],regout17[31:0],regout18[31:0],regout19[31:0],regout20[31:0],regout21[31:0],regout22[31:0],regout23[31:0],regout24[31:0],regout25[31:0],regout26[31:0],regout27[31:0],regout28[31:0],regout29[31:0],regout30[31:0],regout31[31:0]);

endmodule