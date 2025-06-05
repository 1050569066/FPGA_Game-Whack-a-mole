`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/30 00:47:32
// Design Name: 
// Module Name: check
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


module check(
    input clk,
    input [3:0] success,
    input stop,
    input CLR_R,
    output reg [4:0] win,
    output reg B
    );
    
always @( posedge clk or negedge CLR_R)begin
    if(~CLR_R)begin
        win <= 0;
    end else if(stop && (success >= 5))begin
        win <= 5'b10001;
    end else if(stop && (success < 5))begin
        win <= 5'b10000;
    end

end
    
always @(posedge clk)begin
    case(win)
        5'b10000:B <= 0;
        5'b10001:B <= 1;
        default:B <= 0;
    endcase
end
    
    
    
endmodule
