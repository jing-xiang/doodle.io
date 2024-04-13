`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2024 09:52:53 AM
// Design Name: 
// Module Name: drawer_main
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


module drawer_main(
    input rx,
    output tx,
    input drawer_init,
    inout PS2Data, 
    inout PS2Clk,
    input clk, btnD, btnR,
    output [7:0] JB,
    output [7:0] JC,
    output [3:0] an, output [6:0] seg,
    output dp, 
    output [15:0] led);
    //change here
    wire [7:0] q;
    mouse mouseCtrller(.drawer_init(drawer_init), .rx(rx), .tx(tx),
        .clk(clk), .PS2Clk(PS2Clk), .PS2Data(PS2Data),
        .JB(JB), .seg(seg),.q(q));
    
    menu_screen menu(
        .clk(clk), .btnD(btnD), .btnR(btnR), 
        .JC(JC), .an(an), 
        .seg(seg), .dp(dp),.q(q));
    

endmodule
