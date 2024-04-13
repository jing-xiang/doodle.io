`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2024 09:54:05 PM
// Design Name: 
// Module Name: top_main
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


module top_main(input drawer, guesser,
    clk, btnR, btnC, btnD,
    inout PS2Data, PS2Clk,
    output reg [15:0]led,
    output reg [7:0]JB,
    output reg [7:0]JC,
    output reg[6:0]seg,
    output reg [3:0]an,
    output dp,
    output reg tx,
    input rx
    );
    
//    reg start_flag = 0;
    reg guesser_flag;
    reg drawer_flag;
    
//    wire PS2Data_mouse;
    wire PS2Data_keyboard;
    
//    wire PS2Clk_mouse;
    wire PS2Clk_keyboard;
    wire [7:0] JB_guesser;
    wire [7:0] JC_guesser;
    wire tx_guesser;
    wire [3:0] an_guesser;
    wire [6:0] seg_guesser;
    wire [15:0] led_guesser;
    wire [7:0] JB_drawer;
    wire [7:0] JC_drawer;
    wire tx_drawer;
    wire [3:0] an_drawer;
    wire [6:0] seg_drawer;
    wire [15:0] led_drawer;
    assign PS2Clk_keyboard = PS2Clk;
    assign PS2Data_keyboard = PS2Data;
    
    always @ (posedge clk) begin 
        if(drawer) begin 
            guesser_flag <= 0;
            drawer_flag <= 1;
        end
        if(guesser) begin
            guesser_flag <= 1;
            drawer_flag <= 0;
        end
        else begin 
            guesser_flag <= 0;
            drawer_flag <= 0;
        end
    end
  
//    always @ (posedge clk) begin 
//        if (guesser_flag) begin
//            JB <= JB_guesser;
//            JC <= JC_guesser;
//            an <= an_guesser;
//            seg <= seg_guesser;
//            led <=  led_guesser;
//            tx <= tx_guesser;
//        end
//        else begin
//            JB <= 0;
//            JC <= 0;
//            an <= 0;
//            seg <= 0;
//            led <=  0;
//            tx <= 0;
//        end
//        if (drawer_flag) begin
//            JB <= JB_drawer;
//            JC <= JC_drawer;
//            an <= an_drawer;
//            seg <= seg_drawer;
//            led <=  led_drawer;
//            tx <= tx_drawer;
//        end
//        else begin
//            JB <= 0;
//            JC <= 0;
//            an <= 0;
//            seg <= 0;
//            led <=  0;
//            tx <= 0;
//        end
//    end

    
    guesser_main guess(
         .guess_init(1),
//        .guess_init(1),
        .clk(clk),
        .btnR(btnR),
//        .PS2Data(PS2Data_keyboard),
//        .PS2Clk(PS2Clk_keyboard),
        .PS2Data(PS2Data),
        .PS2Clk(PS2Clk),
        .led(led_guesser),
//        .JB(JB_guesser),
        .JB(JB),
//        .JC(JC_guesser),
        .JC(JC),
//        .seg(seg_guesser),
        .seg(seg),
//        .an(an_guesser),
        .an(an),
        .dp(dp),
//        .tx(tx_guesser),
        .tx(tx),
        .rx(rx));
        
//    drawer_main draw(
//    .drawer_init(1),
//    .PS2Data(PS2Data), 
//    .PS2Clk(PS2Clk),
//    .clk(clk), 
//    .btnD(btnD), 
//    .btnR(btnR),
//    .JB(JB_drawer), 
//    .JC(JC_drawer), 
//    .an(an_drawer), 
//    .seg(seg_drawer),
//    .dp(dp), 
//    .led(led_drawer),
//    .tx(tx_drawer),
//    .rx(rx));
    
endmodule