`timescale 1ns / 1ps

module quick_sort_test;
    parameter WORD_SIZE = 16;
    reg [WORD_SIZE-1:0] A, lo, hi;
    reg clk;
    quick_sort uut(.clk(clk), .A(A), .lo(lo), .hi(hi));

    initial begin
        #10
        uut.flag <= 0;
        //uut.stack_pointer <= 0;
        uut.reg_file.REG_FILE[0] <= 55;
        uut.reg_file.REG_FILE[1] <= 8;
        uut.reg_file.REG_FILE[2] <= 34;
        uut.reg_file.REG_FILE[3] <= 6;
        uut.reg_file.REG_FILE[4] <= 5;
        uut.reg_file.REG_FILE[5] <= 22;
        uut.reg_file.REG_FILE[6] <= 33;
        uut.reg_file.REG_FILE[7] <= 2;
        uut.reg_file.REG_FILE[8] <= 1;
        uut.reg_file.REG_FILE[9] <= 13;

        #20 A = 0;
        lo = 0;
        hi = 9; 
    end
    initial 
    begin
    clk = 0;
    repeat (40000) #40 clk = ~clk;
    end

    initial
    begin
        $monitor("time=%t %d %d %d %d %d %d %d %d %d %d  pivot=%d i=%d j=%d lo_reg=%d, hi_reg=%d stack_pointer=%d \n",$time, uut.reg_file.REG_FILE[0], uut.reg_file.REG_FILE[1], 
        uut.reg_file.REG_FILE[2], uut.reg_file.REG_FILE[3], uut.reg_file.REG_FILE[4], uut.reg_file.REG_FILE[5], uut.reg_file.REG_FILE[6], uut.reg_file.REG_FILE[7], uut.reg_file.REG_FILE[8], 
        uut.reg_file.REG_FILE[9], uut.pivot, uut.i, uut.j, uut.lo_reg, uut.hi_reg, uut.stack_pointer);
    end 

    
    initial
        begin
            $dumpfile ("quick.vcd");
            $dumpvars (0, quick_sort_test);
            #300000000000 $finish;
        end
endmodule