`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2024 17:55:01
// Design Name: 
// Module Name: random
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//module pseudo_random(input  clk, ce, rst, output reg [2:0] q);
//// 3-bit uniform pseudo-random number generator, based on fibonacci LFSR

 
//wire feedback = q[2] ^ q[0];
 
//always @(posedge clk or posedge rst)
//  if (rst) 
//    q <= 3'b101;   
//  else if (ce)
//    q <= {q[1:0], feedback};
    
//endmodule
 
//''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
module pseudo_random(input  clk, ce, rst, output reg [7:0] q);
  // 6-bit uniform pseudo-random number generator, based on fibonacci LFSR
 
  wire feedback = q[5] ^ q[2]; 

  always @(posedge clk or posedge rst) begin
    if (rst) 
      q <= 6'b110110 % 40;   
    else if (ce)
      q <= {q[6:0], feedback} % 40;
  end
endmodule


