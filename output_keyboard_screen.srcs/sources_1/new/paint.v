`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2023 15:05:29
// Design Name: 
// Module Name: paint
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


module paint(
    input clk_100M,clk_25M, clk_12p5M, clk_6p25M, slow_clk,
    input mouse_l, reset, enable,  
    input [11:0] mouse_x, mouse_y,
    input [12:0] pixel_index,
    input drawer_init,
    output [6:0] seg, 
    output reg [15:0] colour_chooser
);   
    reg clockMouse;    
    reg clk_s;    
    reg clk_6p25MHz;    
    reg clk_25;
   
    // 361 elements, each element in the 'pixel data' array is 3 bits wide
    reg [2:0]pixel_data[6143:0]; //going for 28 x 28, the scale down of 56 x 56. Original is 32 x 32, scale down of 64 x 64
    integer k;
    initial begin
        for (k=0; k<6144; k=k+1) begin
            pixel_data[k] = 0;
        end
    end
    
    parameter WHITE = 16'b11111_111111_11111;
    parameter ORANGE = 16'b11111_101101_00000;
    parameter BLUE = 16'b00000_000000_11111;
    parameter GREEN = 16'b00000_111111_00000;
    parameter RED = 16'b11111_000000_00000;
    parameter PURPLE = 16'b11111_000000_11110;    
    parameter outline_color = 16'b00000_000000_00000;
    parameter BLACK = 16'b00000_000000_00000;
    parameter background_color = 16'b00000_000000_00000;
    
    wire [6:0] row, col;
    assign col = pixel_index % 96;
    assign row = pixel_index / 96;        
    
    reg [2:0] state_choice = 3'b000;
    reg [2:0] state;
    
    // check if right click for reset with bounce detection
    reg [31:0] reset_count = 0;
    
    // initialize the reset to prevent unwanted error
    reg mouse_reset;
    reg [7:0] strokes = 8'd0; //256 possible strokes
    reg isStroke = 0;
    
    initial begin
        mouse_reset = 1'b1;
    end
    
    always @ (posedge clk_100M) begin
        // if (drawer_init) begin
            clk_25 = clk_25M;
            clockMouse = clk_12p5M; 
            clk_6p25MHz = clk_6p25M;  
            clk_s = slow_clk;
            // will held reset for 100ms if activate
            if (reset || reset_count > 0) begin
                reset_count = (reset_count > 999_999) ? 0 : reset_count + 1;
            end
            // double if statement to prevent premature detection under clear screen        
        // end
        mouse_reset = (reset_count > 0) ? 1 : ((mouse_reset && mouse_l && mouse_x < 96 && mouse_y < 64) ? 0 : mouse_reset);

    end
    
    // To determine the color at each x-y coordinate, configurable    
    wire screen;
    assign screen = (col < 96 && row < 64); // create a 96 x 64 screen

    
    // create a 2x2 cursor
    wire within_cursor; wire [15:0] cursor_color;
    assign within_cursor = ((col == mouse_x) || ((col - mouse_x) == 1)) && ((row == mouse_y) || ((row - mouse_y) == 1));
    assign cursor_color = ((col == mouse_x) || ((col - mouse_x) == 1)) && ((row == mouse_y) || ((row - mouse_y) == 1)) ? PURPLE : 0;
    
    
    // This is for color selection
    // for every click, select colour
    always @ (posedge mouse_l) begin
        // if (drawer_init) begin
            if (enable) begin            
                if (mouse_l) begin
                    state_choice <= state; // Set colour
                end
            end
        // end
    end
    
    // We use 2 pixel per lines or per click
    // includes stroke classification here (unused) 
    always @ (posedge clockMouse, posedge reset) begin
        // if(drawer_init) begin
            if (reset) begin
                for (k=0; k<6144; k=k+1) begin //  here corresponding change from 1024 to 784
                    pixel_data[k] <= 2'b00;
                end
                isStroke <= 0;
                strokes <= 8'd0;
            end 
            else if (enable && mouse_l && mouse_x < 96 && mouse_y < 64) begin                                 
                pixel_data[(mouse_y/2)*57 + (mouse_x/2)] <= 3'b011; // update pixel_data to chosen colour based on clicks   
                if (isStroke == 0) begin
                    isStroke <= 1;
                end
            end
            else if (!mouse_l && isStroke == 1) begin
                strokes <= strokes + 1;
                isStroke <= 0;
            end
            // end
    end
    
    // This portion to generate the pixel data output
    always @ (pixel_index) begin
        // if (drawer_init) begin
            if (enable) begin
                if (within_cursor && cursor_color != 16'b1111_11111_1111) colour_chooser <= cursor_color;
                else if (screen) begin                
                    case (pixel_data[((row/2)*57 + (col/2))])
                        0: colour_chooser <= WHITE;
                        3: colour_chooser <= BLACK;
                    endcase
                end else colour_chooser <= background_color;
            end
        // end
    end    
//    assign led[12:0] = strokes;
endmodule
