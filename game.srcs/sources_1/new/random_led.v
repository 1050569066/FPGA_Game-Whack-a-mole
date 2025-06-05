`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/29 19:46:29
// Design Name: 
// Module Name: random_led
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


module random_led(
    input clk,
    input [3:0] Q_1,
    input CLR_R,
    input start,
    input [15:0] key,
    input stop,
    input [1:0] speed,
    input random_sw,
    input interesting,
    output reg [3:0] success,
    output reg [15:0] led
    );

reg [3:0] random_num;
reg [3:0] random_led2;
reg [4:0] lfsr = 5'b00001;
reg [4:0] lfsr1 = 5'b00110;
reg [31:0] cnt = 25'd24999999;
reg [15:0] check_led;
wire feedback = lfsr[4] ^ lfsr[2];
wire feedback1 = lfsr1[4] ^ lfsr1[2];
wire clk_out;
wire [31:0] random_num2;
wire [31:0] final_cnt;


reg [31:0] stable_random = 24999999;
always @(posedge clk_out) begin
    stable_random <= random_num2;
end





random_generator rand_gen (
    .clk(clk),
    .rst_n(CLR_R),
    .random_num(random_num2)
);



always @(posedge clk)begin
    case(speed)
        2'b00:cnt <= 25'd24999999;
        2'b01:cnt <= 25'd24999999;
        2'b10:cnt <= 26'd49999999;
        2'b11:cnt <= 25'd12499999;
        default:cnt <= 25'd24999999;
    endcase
end

assign final_cnt = random_sw? stable_random:cnt;

clk_div clk_div(
    .clk_in(clk),
    .clk_out(clk_out),
    .cnt(final_cnt)
);



always@ (posedge clk or negedge CLR_R)begin
    if(~CLR_R)begin
        lfsr <= 5'b1;
        lfsr1 <= 5'b00110;
    end else begin
        lfsr <= {lfsr[3:0] , feedback};
        lfsr1 <= {lfsr1[3:0] , feedback1};
    end
    
    
end

reg flag = 0;
reg toggle_clr = 0;
reg sync_toggle0, sync_toggle1;
wire clear_flag;


// 原第一个always块：改为在clk_out域生成同步信号
always @(posedge clk_out) begin
    random_num <= lfsr[3:0];  // 保持随机数更新
    random_led2 <= lfsr1[3:0];
    toggle_clr <= ~toggle_clr; // 生成跨时钟域同步信号
end

// 同步toggle_clr到clk域
always @(posedge clk or negedge CLR_R) begin
    if (~CLR_R) begin
        sync_toggle0 <= 0;
        sync_toggle1 <= 0;
    end else begin
        sync_toggle0 <= toggle_clr;
        sync_toggle1 <= sync_toggle0;
    end
end

// 检测边沿生成清零脉冲（持续1个clk周期）
assign clear_flag = (sync_toggle0 ^ sync_toggle1);

// 重构后的控制逻辑
always @(posedge clk or negedge CLR_R) begin
    if (~CLR_R) begin
        led <= 16'b1111111111111111;
        check_led <= 16'b1111111111111111;
        success <= 0;
        flag <= 0;          // 复位flag
    end else begin
        // 先处理跨时钟域清零
        if (clear_flag) 
            flag <= 0;
        
        if (start && ~stop) begin
            led <= 0;
            check_led <= 0;
            led[random_num] <= 1; // 使用最新随机数
            led[random_led2] <= interesting?1:0;
            check_led[random_num] <= 1;
            // 匹配检测（仅在flag未置位时）
            if (~flag && (key == check_led)) begin
                success <= success + 1;
                flag <= 1;  // 标记已匹配
            end
        end
    end
end
 
   
endmodule

module random_generator(
    input clk,          // 时钟输入
    input rst_n,        // 异步低电平复位
    output reg [31:0] random_num  // 生成的随机数 (12499999-99999999)
);

// 32位LFSR寄存器
reg [31:0] lfsr;

// LFSR反馈多项式：x^32 + x^22 + x^2 + x^1 + 1
wire feedback = lfsr[31] ^ lfsr[21] ^ lfsr[1] ^ lfsr[0];

// 范围参数
localparam MIN_VAL = 6249999;
localparam MAX_VAL = 49999999;
localparam RANGE = MAX_VAL - MIN_VAL + 1;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        // 复位时初始化LFSR为非零值
        lfsr <= 32'hABCD1234;
    end else begin
        // LFSR移位更新
        lfsr <= {lfsr[30:0], feedback};
    end
end

// 将LFSR值映射到指定范围
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        random_num <= MIN_VAL;  // 复位时输出最小值
    end else begin
        // 映射公式：MIN_VAL + (lfsr % RANGE)
        // 使用位操作避免昂贵的取模运算
        random_num <= MIN_VAL + (lfsr % RANGE);
    end
end

endmodule
