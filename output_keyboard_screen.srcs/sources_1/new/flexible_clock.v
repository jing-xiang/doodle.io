`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2024 14:26:15
// Design Name: 
// Module Name: flexible_clock
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


module flexible_clock(input clk, [31:0] m, output reg my_clk=0);    
    reg [31:0]count = 0;
    always @ (posedge clk) begin
        count <= (count == m) ? 0: count + 1;
        my_clk <= (count == 0) ? ~my_clk : my_clk;
     end
endmodule