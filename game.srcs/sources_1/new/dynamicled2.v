`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/22 20:08:33
// Design Name: 
// Module Name: dynamicled2
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


module dynamicled2(
input [3:0]disp_data_right0,
input [3:0]disp_data_right1,
input [3:0]disp_data_right4,
input [4:0]disp_data_right5,


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
        if (num>=5)
            num=0;
        else
            num=num+1;
    end
    
    //译码器
    always @ (num)
    begin    
        case(num)
        0:dig=6'b111110;
        1:dig=6'b111101;
        2:dig=6'b111011;
        3:dig=6'b110111;
        4:dig=6'b101111;
        5:dig=6'b011111;
        default: dig=6'b111111;
        endcase
    end
    
    //选择器，确定显示数据
    reg [4:0] disp_data;
    always @ (num)
    begin    
        case(num)
        0:disp_data=disp_data_right0;
        1:disp_data=disp_data_right1;
        2:disp_data=0;
        3:disp_data=0;
        4:disp_data=disp_data_right4;
        5:disp_data=disp_data_right5;
        default: disp_data=0;
        endcase
    end
    //显示译码器
    always@(disp_data)
    begin
    if(num == 1)begin
        case(disp_data)
              4'b0000: seg = 8'b11111101;
                4'b0001: seg = 8'b01100001;
                4'b0010: seg = 8'b11011011;
                4'b0011: seg = 8'b11110011;
                4'b0100: seg = 8'b01100111;
                4'b0101: seg = 8'b10110111;
                4'b0110: seg = 8'b10111111;
                4'b0111: seg = 8'b11100001;
                4'b1000: seg = 8'b11111111;
                4'b1001: seg = 8'b11100111;
                4'b1010: seg = 8'b11101111;
                4'b1011: seg = 8'b00111111;
                4'b1100: seg = 8'b10011101;
                4'b1101: seg = 8'b01111011;
                4'b1110: seg = 8'b10011111;
                4'b1111: seg = 8'b10001111;
          default: seg = 8'b00000000;
            endcase
    end else begin
        case(disp_data)
          5'b00000: seg = 8'b11111100;
            5'b00001: seg = 8'b01100000;
            5'b00010: seg = 8'b11011010;
            5'b00011: seg = 8'b11110010;
            5'b00100: seg = 8'b01100110;
            5'b00101: seg = 8'b10110110;
            5'b00110: seg = 8'b10111110;
            5'b00111: seg = 8'b11100000;
            5'b01000: seg = 8'b11111110;
            5'b01001: seg = 8'b11100110;
            5'b01010: seg = 8'b11101110;
            5'b01011: seg = 8'b00111110;
            5'b01100: seg = 8'b10011100;
            5'b01101: seg = 8'b01111010;
            5'b01110: seg = 8'b10011110;
            5'b01111: seg = 8'b10001110;
            5'b10000: seg = 8'b00011100;
            5'b10001: seg = 8'b01101110;
      default: seg = 8'b00000000;
        endcase
    end
end
   
endmodule

