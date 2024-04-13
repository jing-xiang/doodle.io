`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2023 15:30:53
// Design Name: 
// Module Name: display_manager
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

// guesser == switch 0
// drawer == switch 15
//removed input
module guesser_main(
    input clk,
    input btnR,
    input PS2Data,
    input PS2Clk,
    output [10:0]led,
    output [7:0]JB,
    output [6:0]seg,
    output [3:0]an,
    output dp,
    output [7:0] JC,
    input rx,
    output tx);
    wire guess_init = 1;
    wire clk_6p25m;
    slow_clock screen_clock(clk, 32'd16, clk_6p25m);
    
    wire [12:0]pixel_index;
    wire [15:0]pixel_data;
    wire[7:0] q;
    assign led = q;
    
    rx_main(    
        .clk_100MHz(clk),      
        .rx(rx),        
        .tx(tx),        
        .JC(JC),
        .q(q)
        );
    
    Oled_Display screen(
        .clk(clk_6p25m), 
        .reset(), 
        .frame_begin(), 
        .sending_pixels(),
        .sample_pixel(), 
        .pixel_index(pixel_index[12:0]), 
        .pixel_data(pixel_data[15:0]), 
        .cs(JB[0]), 
        .sdin(JB[1]), 
        .sclk(JB[3]), 
        .d_cn(JB[4]), 
        .resn(JB[5]), 
        .vccen(JB[6]),
        .pmoden(JB[7]));
    
    wire [7:0] ow_0; wire [7:0] ow_1;
    wire [7:0] ow_2; wire [7:0] ow_3;
    wire [7:0] ow_4; wire [7:0] ow_5;
    wire [7:0] ow_6; wire [7:0] ow_7;
    wire [7:0] ow_8; wire [7:0] ow_9;

    wire [7:0] tw_0; wire [7:0] tw_1;
    wire [7:0] tw_2; wire [7:0] tw_3;
    wire [7:0] tw_4; wire [7:0] tw_5;
    wire [7:0] tw_6; wire [7:0] tw_7;
    wire [7:0] tw_8; wire [7:0] tw_9;
        
    wire [159:0] display_mapping;
    wire [5:0] game_time;
    wire [1:0] correct_word;
    wire [15:0] colour;
    
    
    display_keys key_output(
        .clk(clk),
        .guess_init(guess_init),
        .clk_6p25m(clk_6p25m),
        .JB(JB),
        .display_mapping(display_mapping),
        .pixel_index(pixel_index),
        .game_time(game_time),
        .pixel_data(pixel_data),
        .correct_word(correct_word),
        .colour(colour));
    
    input_to_screen parser(
        .guess_init(guess_init), .clk(clk),
        .ow_0(ow_0), .ow_1(ow_1),
        .ow_2(ow_2), .ow_3(ow_3),
        .ow_4(ow_4), .ow_5(ow_5),
        .ow_6(ow_6), .ow_7(ow_7),
        .ow_8(ow_8), .ow_9(ow_9),
        
        .tw_0(tw_0), .tw_1(tw_1),
        .tw_2(tw_2), .tw_3(tw_3),
        .tw_4(tw_4), .tw_5(tw_5),
        .tw_6(tw_6), .tw_7(tw_7),
        .tw_8(tw_8), .tw_9(tw_9),
        .game_time(game_time),
        .display_mapping(display_mapping));
                
    timer game_timer(.clk(clk),
    .guess_init(guess_init),
    .btnR(btnR),
    .dp(dp),
    .an(an),
    .seg(seg),
    .game_time(game_time),
    .correct_word(correct_word));
    
    
    
    keyboard_input typer (.guess_init(guess_init), .q(q),

.btnR(btnR),.clk(clk), .game_time(game_time),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
     .PS2Data(PS2Data), .PS2Clk(PS2Clk), 
     //.led(led),
    .ow_0(ow_0), .ow_1(ow_1),
    .ow_2(ow_2), .ow_3(ow_3),
    .ow_4(ow_4), .ow_5(ow_5),
    .ow_6(ow_6), .ow_7(ow_7),
    .ow_8(ow_8), .ow_9(ow_9),

    .tw_0(tw_0), .tw_1(tw_1),
    .tw_2(tw_2), .tw_3(tw_3),
    .tw_4(tw_4), .tw_5(tw_5),
    .tw_6(tw_6), .tw_7(tw_7),
    .tw_8(tw_8), .tw_9(tw_9),
    .correct_word(correct_word),
    .colour(colour));
        
endmodule