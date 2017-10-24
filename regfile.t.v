//------------------------------------------------------------------------------
// Test harness validates hw4testbench by connecting it to various functional 
// or broken register files, and verifying that it correctly identifies each
//------------------------------------------------------------------------------
`include "regfile.v"
module hw4testbenchharness();

  wire[31:0]	ReadData1;	// Data from first register read
  wire[31:0]	ReadData2;	// Data from second register read
  wire[31:0]	WriteData;	// Data to write to register
  wire[4:0]	ReadRegister1;	// Address of first register to read
  wire[4:0]	ReadRegister2;	// Address of second register to read
  wire[4:0]	WriteRegister;  // Address of register to write
  wire		RegWrite;	// Enable writing of register when High
  wire		Clk;		// Clock (Positive Edge Triggered)

  reg		begintest;	// Set High to begin testing register file
  wire		dutpassed;	// Indicates whether register file passed tests

  // Instantiate the register file being tested.  DUT = Device Under Test
  regfile DUT
  (
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .WriteData(WriteData),
    .ReadRegister1(ReadRegister1),
    .ReadRegister2(ReadRegister2),
    .WriteRegister(WriteRegister),
    .RegWrite(RegWrite),
    .Clk(Clk)
  );

  // Instantiate test bench to test the DUT
  hw4testbench tester
  (
    .begintest(begintest),
    .endtest(endtest), 
    .dutpassed(dutpassed),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .WriteData(WriteData), 
    .ReadRegister1(ReadRegister1), 
    .ReadRegister2(ReadRegister2),
    .WriteRegister(WriteRegister),
    .RegWrite(RegWrite), 
    .Clk(Clk)
  );

  // Test harness asserts 'begintest' for 1000 time steps, starting at time 10
  initial begin
    begintest=0;
    #10;
    begintest=1;
    #1000;
  end

  // Display test results ('dutpassed' signal) once 'endtest' goes high
  always @(posedge endtest) begin
    $display("DUT passed?: %b", dutpassed);
  end

endmodule


//------------------------------------------------------------------------------
// Your HW4 test bench
//   Generates signals to drive register file and passes them back up one
//   layer to the test harness. This lets us plug in various working and
//   broken register files to test.
//
//   Once 'begintest' is asserted, begin testing the register file.
//   Once your test is conclusive, set 'dutpassed' appropriately and then
//   raise 'endtest'.
//------------------------------------------------------------------------------

module hw4testbench
(
// Test bench driver signal connections
input	   		begintest,	// Triggers start of testing
output reg 		endtest,	// Raise once test completes
output reg 		dutpassed,	// Signal test result

// Register File DUT connections
input[31:0]		ReadData1,
input[31:0]		ReadData2,
output reg[31:0]	WriteData,
output reg[4:0]		ReadRegister1,
output reg[4:0]		ReadRegister2,
output reg[4:0]		WriteRegister,
output reg		RegWrite,
output reg		Clk
);

  // Initialize register driver signals
  initial begin
    WriteData=32'd0;
    ReadRegister1=5'd0;
    ReadRegister2=5'd0;
    WriteRegister=5'd0;
    RegWrite=0;
    Clk=0;
  end

  // Once 'begintest' is asserted, start running test cases
  always @(posedge begintest) begin
    endtest = 0;
    dutpassed = 1;
    #10

  // Test Case 1: 
  //   Write '42' to register 2, verify with Read Ports 1 and 2
  WriteRegister = 5'd2;
  WriteData = 32'd42;
  RegWrite = 1;
  ReadRegister1 = 5'd2;
  ReadRegister2 = 5'd2;
  #5 Clk=1; #5 Clk=0;	// Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1 !== 42) || (ReadData2 !== 42)) begin
    dutpassed = 0;	// Set to 'false' on failure
    $display("Test Case 1 Failed");
  end

// Test Case 2: 
  //   Double check the zero register :) (#4 on the github)
  WriteRegister = 5'd0;
  WriteData = 32'd12;
  RegWrite = 1;
  ReadRegister1 = 5'd0;
  ReadRegister2 = 5'd0;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1 !== 0) || (ReadData2 !== 0)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 2 Failed");
  end

// Test Case 3: 
  //   Write Enable is broken/ignored (#2 on the github)
  WriteRegister = 5'd30;
  WriteData = 32'd30;
  RegWrite = 0;
  ReadRegister1 = 5'd30;
  ReadRegister2 = 5'd30;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1==32'd30) || (ReadData2==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 3 Failed");
  end

// Test Case 4: 
  //     Port 2 is not broken (#5 on the github)
  WriteRegister = 5'd12;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd12;
  ReadRegister2 = 5'd15;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 4 Failed");
  end


  WriteRegister = 5'd1;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd1;
  ReadRegister2 = 5'd1;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end

  WriteRegister = 5'd2;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd2;
  ReadRegister2 = 5'd2;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end


  WriteRegister = 5'd3;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd3;
  ReadRegister2 = 5'd3;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end


  WriteRegister = 5'd4;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd4;
  ReadRegister2 = 5'd4;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end


  WriteRegister = 5'd5;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd5;
  ReadRegister2 = 5'd5;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end


  WriteRegister = 5'd6;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd6;
  ReadRegister2 = 5'd6;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end


  WriteRegister = 5'd7;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd7;
  ReadRegister2 = 5'd7;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end


  WriteRegister = 5'd8;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd8;
  ReadRegister2 = 5'd8;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end


  WriteRegister = 5'd9;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd9;
  ReadRegister2 = 5'd9;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end

  WriteRegister = 5'd10;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd10;
  ReadRegister2 = 5'd10;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end

    WriteRegister = 5'd11;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd11;
  ReadRegister2 = 5'd11;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end

    WriteRegister = 5'd12;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd12;
  ReadRegister2 = 5'd12;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end

  WriteRegister = 5'd13;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd13;
  ReadRegister2 = 5'd13;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end

    WriteRegister = 5'd14;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd14;
  ReadRegister2 = 5'd14;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end

    WriteRegister = 5'd15;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd15;
  ReadRegister2 = 5'd15;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end

    WriteRegister = 5'd16;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd16;
  ReadRegister2 = 5'd16;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end

  WriteRegister = 5'd17;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd17;
  ReadRegister2 = 5'd17;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end

    WriteRegister = 5'd18;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd18;
  ReadRegister2 = 5'd18;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end

    WriteRegister = 5'd19;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd19;
  ReadRegister2 = 5'd19;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end

  WriteRegister = 5'd20;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd20;
  ReadRegister2 = 5'd20;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end

  WriteRegister = 5'd21;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd21;
  ReadRegister2 = 5'd21;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end

    WriteRegister = 5'd22;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd22;
  ReadRegister2 = 5'd22;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end

  WriteRegister = 5'd23;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd23;
  ReadRegister2 = 5'd23;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end

    WriteRegister = 5'd24;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd24;
  ReadRegister2 = 5'd24;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end

    WriteRegister = 5'd25;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd25;
  ReadRegister2 = 5'd25;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end


    WriteRegister = 5'd26;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd26;
  ReadRegister2 = 5'd26;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end


    WriteRegister = 5'd27;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd27;
  ReadRegister2 = 5'd27;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end

    WriteRegister = 5'd28;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd28;
  ReadRegister2 = 5'd28;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end


  WriteRegister = 5'd29;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd29;
  ReadRegister2 = 5'd29;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end

    WriteRegister = 5'd30;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd30;
  ReadRegister2 = 5'd30;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end

  WriteRegister = 5'd31;
  WriteData = 32'd30;
  RegWrite = 1;
  ReadRegister1 = 5'd31;
  ReadRegister2 = 5'd31;
  #5 Clk=1; #5 Clk=0; // Generate single clock pulse
  // Verify expectations and report test result
  if((ReadData1!==32'd30) || (ReadData2!==32'd30)) begin
    dutpassed = 0;  // Set to 'false' on failure
    $display("Test Case 5 Failed");
  end


  // All done!  Wait a moment and signal test completion.
  #5
  endtest = 1;

end

endmodule