`timescale 1ns/1ps

module tb_random_generator();
    reg clk;
    reg rst_n;
    wire [31:0] random_num;
    
    // 实例化被测模块
    random_generator uut (
        .clk(clk),
        .rst_n(rst_n),
        .random_num(random_num)
    );
    
    // 生成时钟信号 (100MHz)
    initial begin
        clk = 0;
        forever #10 clk = ~clk;  // 10ns周期 (100MHz)
    end
    
    // 测试控制变量
    reg [31:0] cycle_count;
    
    // 测试序列
    initial begin
        // 初始化信号
        rst_n = 0;
        cycle_count = 0;
        
        // 复位系统
        #20 rst_n = 1;
        
        // 等待100个时钟周期
        wait(cycle_count == 100);
        
        // 结束仿真
        $finish;
    end
    
    // 在每个时钟上升沿显示结果
    always @(posedge clk) begin
        if (rst_n) begin
            // 显示当前随机数
            $display("Time = %0t ns, Cycle = %0d, Random Number = %0d", 
                     $time, cycle_count, random_num);
            
            // 增加周期计数
            cycle_count <= cycle_count + 1;
            
            // 检查输出范围
            if (random_num < 12499999 || random_num > 99999999) begin
                $display("ERROR: Value %0d out of range at time %0t ns", 
                         random_num, $time);
                $finish;
            end
        end
    end
    
    // 复位时的周期计数处理
    always @(negedge rst_n) begin
        cycle_count <= 0;
    end
    
endmodule