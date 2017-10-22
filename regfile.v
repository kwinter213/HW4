//------------------------------------------------------------------------------
// MIPS register file
//   width: 32 bits
//   depth: 32 words (reg[0] is static zero register)
//   2 asynchronous read ports
//   1 synchronous, positive edge triggered write port
//------------------------------------------------------------------------------
`include "register32zero.v"
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

  wire [31:0] decodeout; //output of decoder
  wire [31:0] q[31:0]; //output of registers

  //Decoder (included in mux32to1by32.v file)
  decoder1to32 decoder(decodeout[31:0], RegWrite, WriteRegister[4:0]); //inputs and outputs defined by diagram

  //write data/decoder into 32 bit registers
  register32zero regzero(q[0][31:0],q[1][31:0],q[2][31:0],q[3][31:0],q[4][31:0],q[5][31:0],q[6][31:0],q[7][31:0],q[8][31:0],q[9][31:0],q[10][31:0],q[11][31:0],q[12][31:0],q[13][31:0],q[14][31:0],q[15][31:0],q[16][31:0],q[17][31:0],q[18][31:0],q[19][31:0],q[20][31:0],q[21][31:0],q[22][31:0],q[23][31:0],q[24][31:0],q[25][31:0],q[26][31:0],q[27][31:0],q[28][31:0],q[29][31:0],q[30][31:0],q[31][31:0],WriteData[31:0],decodeout[31:0],clk); //decode out determines which register to pick, write data writes data, q is the output of the selected mux

  //MUX array
  mux32to1by32 mux320(ReadData1,ReadRegister1,q[0][31:0],q[1][31:0],q[2][31:0],q[3][31:0],q[4][31:0],q[5][31:0],q[6][31:0],q[7][31:0],q[8][31:0],q[9][31:0],q[10][31:0],q[11][31:0],q[12][31:0],q[13][31:0],q[14][31:0],q[15][31:0],q[16][31:0],q[17][31:0],q[18][31:0],q[19][31:0],q[20][31:0],q[21][31:0],q[22][31:0],q[23][31:0],q[24][31:0],q[25][31:0],q[26][31:0],q[27][31:0],q[28][31:0],q[29][31:0],q[30][31:0],q[31][31:0]);
  mux32to1by32 mux321(ReadData2,ReadRegister2,q[0][31:0],q[1][31:0],q[2][31:0],q[3][31:0],q[4][31:0],q[5][31:0],q[6][31:0],q[7][31:0],q[8][31:0],q[9][31:0],q[10][31:0],q[11][31:0],q[12][31:0],q[13][31:0],q[14][31:0],q[15][31:0],q[16][31:0],q[17][31:0],q[18][31:0],q[19][31:0],q[20][31:0],q[21][31:0],q[22][31:0],q[23][31:0],q[24][31:0],q[25][31:0],q[26][31:0],q[27][31:0],q[28][31:0],q[29][31:0],q[30][31:0],q[31][31:0]);

endmodule
