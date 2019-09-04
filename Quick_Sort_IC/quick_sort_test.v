`timescale 1ns / 1ps

module quick_sort_test;
    parameter WORD_SIZE = 16;
    reg [WORD_SIZE-1:0] A, lo, hi;
    reg clk;
    quick_sort uut(.clk(clk), .A(A), .lo(lo), .hi(hi));

    initial begin
        #10
        uut.flag <= 0;
        uut.stack_pointer <= 0;
        uut.REG[0] <= 55;
        uut.REG[1] <= 8;
        uut.REG[2] <= 34;
        uut.REG[3] <= 6;
        uut.REG[4] <= 5;
        uut.REG[5] <= 22;
        uut.REG[6] <= 33;
        uut.REG[7] <= 2;
        uut.REG[8] <= 1;
        uut.REG[9] <= 13;

        #20 A = 0;
        lo = 0;
        hi = 9; 
    end
    initial 
    begin
    clk = 0;
    repeat (300) #40 clk = ~clk;
    end

    initial
    begin
        $monitor("time=%t %d %d %d %d %d %d %d %d %d %d temp=%d pivot=%d i=%d j=%d lo_reg=%d, hi_reg=%d stack_pointer=%d stack_lo_0=%d stack_hi_0=%d\n",$time, uut.REG[0], uut.REG[1], 
        uut.REG[2], uut.REG[3], uut.REG[4], uut.REG[5], uut.REG[6], uut.REG[7], uut.REG[8], uut.REG[9],  uut.temp, uut.pivot, uut.i, uut.j, uut.lo_reg, uut.hi_reg, uut.stack_pointer, uut.stack[1], uut.stack[2]);
    end 

    
    initial
        begin
            $dumpfile ("quick.vcd");
            $dumpvars (0, quick_sort_test);
            #3000 $finish;
        end
endmodule