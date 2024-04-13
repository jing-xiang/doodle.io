`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2024 14:20:48
// Design Name: 
// Module Name: timer
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


module timer(
    input guess_init,
    input clk, 
    input btnR,
    input dp,
    input [1:0] correct_word,
    output reg [3:0] an, 
    output reg [6:0] seg,
    output reg [5:0] game_time
    );
    reg [26:0] one_second_counter;
    wire one_second_enable;
    reg [15:0] display; 
    reg [3:0] BCD;
    reg [19:0] refresh;
    wire [1:0] LED_counter; 
    always @(posedge clk)
    begin
        if (guess_init) begin
            if(btnR == 1)
                one_second_counter <= 0;
            else begin
                if(one_second_counter >= 99999999) 
                    one_second_counter <= 0;
                else
                    one_second_counter <= one_second_counter + 1;
            end
        end
    end 
    assign one_second_enable = (one_second_counter == 99999999) ? 1 : 0;

    always @(posedge clk)
    begin
        if (guess_init) begin
            if (btnR == 1) begin
                display <= 60; // Change initial value to 20 for countdown
            end
            else if (correct_word == 2'd1) begin
                display <= display;
            end
            else if (one_second_enable == 1 && display > 0) begin
                display <= display - 1;
            end
            game_time <= display;
        end
    end
    always @(posedge clk)
    begin 
        if (guess_init) begin
            if(btnR == 1)
                refresh <= 0;
            else
                refresh <= refresh + 1;
        end
    end
    assign LED_counter = refresh[19:18];
    always @(*)
    begin
        if (guess_init) begin
            case(LED_counter)
            2'b00: begin
                an = 4'b0111; 
                BCD = display/10;
                  end
            2'b01: begin
                an = 4'b1011; 
                BCD = display % 10;
                  end
            2'b10: begin
                an = 4'b1111; 
                BCD = 4'b0000; 
                    end
            2'b11: begin
                an = 4'b1111; 
                BCD = 4'b0000; 
                   end
            endcase
            
            // 7 segment display
            case(BCD)
                4'b0000: seg = 7'b1000000;      
                4'b0001: seg = 7'b1111001;  
                4'b0010: seg = 7'b0100100; 
                4'b0011: seg = 7'b0110000;
                4'b0100: seg = 7'b0011001;
                4'b0101: seg = 7'b0010010;
                4'b0110: seg = 7'b0000010;
                4'b0111: seg = 7'b1111000;
                4'b1000: seg = 7'b0000000;    
                4'b1001: seg = 7'b0010000;
                default: seg = 7'b1000000;    
            endcase
        end
        
        // init state
        else begin
            an = 4'b1111;
            seg = 7'b1111111;
        end
    end
    
 endmodule