`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2023 14:25:39
// Design Name: 
// Module Name: Clock_divider
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


module slow_clock(
    input CLOCK,
    input [31:0] divider,
    output  reg out_clock = 0
    );  
    reg[31:0] counter = 1'd1;
    always@(posedge CLOCK) begin
        out_clock <= (counter == 32'd0)? 1 : 0 ;
        counter <= (counter == divider)? 32'd0 :counter + 1;
    end
endmodule
