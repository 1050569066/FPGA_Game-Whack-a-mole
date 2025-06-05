`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/08 17:56:37
// Design Name: 
// Module Name: keyboard
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

module matrix_scan(
    input clk,           // 50MHz时钟
    input [3:0] col_in,  // 列输入（上拉）
    output [3:0] row_out,// 行输出（低有效）
    output [15:0] key    // LED输出（高电平亮）
);

// 分频计数器参数（200Hz扫描频率）
parameter DIVIDER = 32'd249999; // 50MHz/(200Hz*2) = 125000
// 按键状态寄存器
reg [15:0] key_state = 16'd0;
// 分频器生成扫描使能信号
reg [31:0] cnt = 0;
reg scan_en = 0;


always @(posedge clk) begin
    if(cnt >= DIVIDER) begin
        cnt <= 0;
        scan_en <= 1;
    end
    else begin
        cnt <= cnt + 1;
        scan_en <= 0;
    end
end

// 行扫描计数器（0-3循环）
reg [1:0] row_cnt = 0;

always @(posedge clk) begin
    if(scan_en)
        row_cnt <= row_cnt + 1;
end

// 行选择逻辑
reg [3:0] row_reg;
always @(*) begin
    case(row_cnt)
        2'd0: row_reg = 4'b1110;
        2'd1: row_reg = 4'b1101;
        2'd2: row_reg = 4'b1011;
        2'd3: row_reg = 4'b0111;
        default: row_reg = 4'b1111;
    endcase
end
assign row_out = row_reg;

// 列输入消抖模块
wire [3:0] col_debounced;

ajxd debounce_col0(
    .btn_in(col_in[0]),
    .btn_clk(clk),
    .btn_out(col_debounced[0])
);

ajxd debounce_col1(
    .btn_in(col_in[1]),
    .btn_clk(clk),
    .btn_out(col_debounced[1])
);

ajxd debounce_col2(
    .btn_in(col_in[2]),
    .btn_clk(clk),
    .btn_out(col_debounced[2])
);

ajxd debounce_col3(
    .btn_in(col_in[3]),
    .btn_clk(clk),
    .btn_out(col_debounced[3])
);



// 按键状态更新逻辑
always @(posedge clk) begin
    if(scan_en) begin
        case(row_cnt)
            2'd0: key_state[3:0]  <= {~col_debounced[3], ~col_debounced[2], ~col_debounced[1], ~col_debounced[0]};
            2'd1: key_state[7:4]  <= {~col_debounced[3], ~col_debounced[2], ~col_debounced[1], ~col_debounced[0]};
            2'd2: key_state[11:8] <= {~col_debounced[3], ~col_debounced[2], ~col_debounced[1], ~col_debounced[0]};
            2'd3: key_state[15:12]<= {~col_debounced[3], ~col_debounced[2], ~col_debounced[1], ~col_debounced[0]};
        endcase
    end
end



assign key = key_state;

endmodule

module ajxd(
    input btn_in,
    input btn_clk,
    output btn_out
    );  
    reg  btn0=0;//定义了btn0寄存器
    reg  btn1=0;//定义了btn1寄存器
    reg  btn2=0;//定义了btn2寄存器
  //在下面参考课件程序，自己填写对按键btn_in的消抖程序
    always@ (posedge btn_clk)
    begin
        btn0<=btn_in;
        btn1<=btn0;
       btn2<=btn1;
    end
assign btn_out=(btn2&btn1&btn0)|(~btn2&btn1&btn0);//btn_out信号
 
 //上面须填写对按键btn_in的消抖程序
endmodule
