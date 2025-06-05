`timescale 1ns/1ps

module tb_random_generator();
    reg clk;
    reg rst_n;
    wire [31:0] random_num;
    
    // ʵ��������ģ��
    random_generator uut (
        .clk(clk),
        .rst_n(rst_n),
        .random_num(random_num)
    );
    
    // ����ʱ���ź� (100MHz)
    initial begin
        clk = 0;
        forever #10 clk = ~clk;  // 10ns���� (100MHz)
    end
    
    // ���Կ��Ʊ���
    reg [31:0] cycle_count;
    
    // ��������
    initial begin
        // ��ʼ���ź�
        rst_n = 0;
        cycle_count = 0;
        
        // ��λϵͳ
        #20 rst_n = 1;
        
        // �ȴ�100��ʱ������
        wait(cycle_count == 100);
        
        // ��������
        $finish;
    end
    
    // ��ÿ��ʱ����������ʾ���
    always @(posedge clk) begin
        if (rst_n) begin
            // ��ʾ��ǰ�����
            $display("Time = %0t ns, Cycle = %0d, Random Number = %0d", 
                     $time, cycle_count, random_num);
            
            // �������ڼ���
            cycle_count <= cycle_count + 1;
            
            // ��������Χ
            if (random_num < 12499999 || random_num > 99999999) begin
                $display("ERROR: Value %0d out of range at time %0t ns", 
                         random_num, $time);
                $finish;
            end
        end
    end
    
    // ��λʱ�����ڼ�������
    always @(negedge rst_n) begin
        cycle_count <= 0;
    end
    
endmodule