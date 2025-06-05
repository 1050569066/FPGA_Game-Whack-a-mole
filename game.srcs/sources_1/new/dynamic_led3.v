`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/22 19:09:05
// Design Name: 
// Module Name: dynamic_led3
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


module dynamic_led3(
input [3:0]disp_data_right4,
input [3:0]disp_data_right5,

input clk,
output  reg  [7:0] seg,
output  reg  [5:0] dig
    );

    reg[24:0] clk_div_cnt=0;
    reg clk_div=0;
    always @ (posedge clk)
    begin
        if (clk_div_cnt==24999)
        begin
            clk_div<=~clk_div;
            clk_div_cnt<=0;
        end
        else 
            clk_div_cnt<=clk_div_cnt+1;
    end
    //3进制计数器
    reg [2:0] num=0;
    always @ (posedge clk_div)
    begin
        if (num>=1)
            num=0;
        else
            num=num+1;
    end
    
    //译码器
    always @ (num)
    begin    
        case(num)
        0:dig=6'b101111;
        1:dig=6'b011111;
        default: dig=6'b111111;
        endcase
    end
    
    //选择器，确定显示数据
    reg [3:0] disp_data;
    always @ (num)
    begin    
        case(num)
        0:disp_data=disp_data_right4;
        1:disp_data=disp_data_right5;

//        3:disp_data=disp_data_right3;
//        4:disp_data=disp_data_right4;
//        5:disp_data=disp_data_right5;
        default: disp_data=0;
        endcase
    end
    //显示译码器
    always@(disp_data)
    begin
        case(disp_data)
          4'b0000: seg = 8'b11111100;
            4'b0001: seg = 8'b01100000;
            4'b0010: seg = 8'b11011010;
            4'b0011: seg = 8'b11110010;
            4'b0100: seg = 8'b01100110;
            4'b0101: seg = 8'b10110110;
            4'b0110: seg = 8'b10111110;
            4'b0111: seg = 8'b11100000;
            4'b1000: seg = 8'b11111110;
            4'b1001: seg = 8'b11100110;
            4'b1010: seg = 8'b11101110;
            4'b1011: seg = 8'b00111110;
            4'b1100: seg = 8'b10011100;
            4'b1101: seg = 8'b01111010;
            4'b1110: seg = 8'b10011110;
            4'b1111: seg = 8'b10001110;
      default: seg = 8'b00000000;
        endcase
    end
   
endmodule
