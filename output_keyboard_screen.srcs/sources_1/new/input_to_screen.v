`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2024 01:05:38 PM
// Design Name: 
// Module Name: input_to_screen
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


module input_to_screen(
    input guess_init,
    input clk,
    input [7:0]ow_0, input [7:0]ow_1,
    input [7:0]ow_2, input [7:0]ow_3,
    input [7:0]ow_4, input [7:0]ow_5,
    input [7:0]ow_6, input [7:0]ow_7,
    input [7:0]ow_8, input [7:0]ow_9,
    
    input [7:0]tw_0, input [7:0]tw_1,
    input [7:0]tw_2, input [7:0]tw_3,
    input [7:0]tw_4, input [7:0]tw_5,
    input [7:0]tw_6, input [7:0]tw_7,
    input [7:0]tw_8, input [7:0]tw_9,
    input [3:0]tw_length,
    input [5:0]game_time,
    output reg [159:0] display_mapping);
    
    wire [7:0]A = 8'h1C;
    wire [7:0]B = 8'h32;
    wire [7:0]C = 8'h21;
    wire [7:0]D = 8'h23;
    wire [7:0]E = 8'h24;
    wire [7:0]F = 8'h2B;
    wire [7:0]G = 8'h34;
    wire [7:0]H = 8'h33;
    wire [7:0]I = 8'h43;
    wire [7:0]J = 8'h3B;
    wire [7:0]K = 8'h42;
    wire [7:0]L = 8'h4B;
    wire [7:0]M = 8'h3A;
    wire [7:0]N = 8'h31;
    wire [7:0]O = 8'h44;
    wire [7:0]P = 8'h4D;
    wire [7:0]Q = 8'h15;
    wire [7:0]R = 8'h2D;
    wire [7:0]S = 8'h1B;
    wire [7:0]T = 8'h2C;
    wire [7:0]U = 8'h3C;
    wire [7:0]V = 8'h2A;
    wire [7:0]W = 8'h1D;
    wire [7:0]X = 8'h22;
    wire [7:0]Y = 8'h35;
    wire [7:0]Z = 8'h1A;
    wire [7:0]space = 8'h29;
    wire [7:0]underline = 8'h1;
    wire [7:0]separator = 8'h2;
    reg [7:0]null = 8'd0;

    
    always @ (posedge clk) begin
        // top half of screen shows underlines or user hints
        if (tw_0 == 8'h0) begin
            display_mapping[7:0] = null;
        end
        else if (game_time < 6'd30) begin
            display_mapping[7:0] = tw_0;
        end
        else begin
            display_mapping[7:0] = underline;
        end
        if (tw_1 == 8'h0) begin
            display_mapping[15:8] = null;
        end
        else if (game_time < 6'd15) begin
            display_mapping[15:8] = tw_1;
        end
        else begin
            display_mapping[15:8] = underline;
        end
        if (tw_2 == 8'h0) begin
            display_mapping[23:16] = null;
        end
        else begin
            display_mapping[23:16] = underline;
        end
        if (tw_3 == 8'h0) begin
            display_mapping[31:24] = null;
        end
        else begin
            display_mapping[31:24] = underline;
        end
        if (tw_4 == 8'h0) begin
            display_mapping[39:32] = null;
        end
        else begin
            display_mapping[39:32] = underline;
        end
        if (tw_5 == 8'h0) begin
            display_mapping[47:40] = null;
        end
        else begin
            display_mapping[47:40] = underline;
        end
        if (tw_6 == 8'h0) begin
            display_mapping[55:48] = null;
        end
        else begin
            display_mapping[55:48] = underline;
        end
        if (tw_7 == 8'h0) begin
            display_mapping[63:56] = null;
        end
        else begin
            display_mapping[63:56] = underline;
        end
        if (tw_8 == 8'h0) begin
            display_mapping[71:64] = null;
        end
        else begin
            display_mapping[71:64] = underline;
        end
        if (tw_9 == 8'h0) begin
            display_mapping[79:72] = null;
        end
        else begin
            display_mapping[79:72] = underline;
        end
        // bottom half of screen shows user input
        if (ow_0 == 8'h0) begin
            display_mapping[87:80] = null;
        end
        else begin
            display_mapping[87:80] = ow_0;
        end
        if (ow_1 == 8'h0) begin
            display_mapping[95:88] = null;
        end
        else begin
            display_mapping[95:88] = ow_1;
        end
        if (ow_2 == 8'h0) begin
            display_mapping[103:96] = null;
        end
        else begin
            display_mapping[103:96] = ow_2;
        end
        if (ow_3 == 8'h0) begin
            display_mapping[111:104] = null;
        end
        else begin
            display_mapping[111:104] = ow_3;
        end
        if (ow_4 == 8'h0) begin
            display_mapping[119:112] = null;
        end
        else begin
            display_mapping[119:112] = ow_4;
        end
        if (ow_5 == 8'h0) begin
            display_mapping[127:120] = null;
        end
        else begin
            display_mapping[127:120] = ow_5;
        end
        if (ow_6 == 8'h0) begin
            display_mapping[135:128] = null;
        end
        else begin
            display_mapping[135:128] = ow_6;
        end
        if (ow_7 == 8'h0) begin
            display_mapping[143:136] = null;
        end
        else begin
            display_mapping[143:136] = ow_7;
        end
        if (ow_8 == 8'h0) begin
            display_mapping[151:144] = null;
        end
        else begin
            display_mapping[151:144] = ow_8;
        end
        if (ow_9 == 8'h0) begin
            display_mapping[159:152] = null;
        end
        else begin
            display_mapping[159:152] = ow_9;
        end
        if (game_time < 6'd1) begin
            display_mapping[7:0] = tw_0;
            display_mapping[15:8] = tw_1;
            display_mapping[23:16] = tw_2;
            display_mapping[31:24] = tw_3;
            display_mapping[39:32] = tw_4;
            display_mapping[47:40] = tw_5;
            display_mapping[55:48] = tw_6;
            display_mapping[63:56] = tw_7;
            display_mapping[71:64] = tw_8;
            display_mapping[79:72] = tw_9;
        end
    end
    
endmodule
