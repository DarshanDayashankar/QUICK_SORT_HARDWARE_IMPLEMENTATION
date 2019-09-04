`timescale 1ns / 1ps
module REG_test;
    parameter WORD_SIZE = 16;

    reg clk;
    reg [WORD_SIZE-1:0] reg_addr, reg_in;
    wire [WORD_SIZE-1:0] reg_out;
    reg WRITE_EN, READ_EN;
    REG reg_file(.clk(clk), .addr(reg_addr), .out(reg_out), .in(reg_in), .READ_EN(READ_EN), .WRITE_EN(WRITE_EN));
    initial begin
        clk=0;
        READ_EN =0;
        WRITE_EN =1;
        reg_addr = 0;
        reg_in = 23;
        #40 clk = ~clk;
        #40 clk = ~clk;
        READ_EN =0;
        WRITE_EN =1;
        reg_addr = 1;
        reg_in = 24;
        #40 clk = ~clk;
        #40 clk = ~clk;
        READ_EN =0;
        WRITE_EN =1;
        reg_addr = 2;
        reg_in = 25;
        #40 clk = ~clk;
        #40 clk = ~clk;
        READ_EN =1;
        WRITE_EN =0;
        reg_addr = 0;
        #40 clk = ~clk;
        #40 clk = ~clk;
        $display("reg_out %d", reg_out);
        READ_EN =1;
        WRITE_EN =0;
        reg_addr = 1;
        #40 clk = ~clk;
        #40 clk = ~clk;
        $display("reg_out %d", reg_out);
        READ_EN =1;
        WRITE_EN =0;
        reg_addr = 2;
        #40 clk = ~clk;
        #40 clk = ~clk;
        $display("reg_out %d", reg_out);

        
    end 

    initial
    begin
        $monitor("%d %d %d \n", reg_file.REG_FILE[0], reg_file.REG_FILE[1], 
        reg_file.REG_FILE[2]);
    end

    initial
        begin
            $dumpfile ("REG.vcd");
            $dumpvars (0, REG_test);
            #3000 $finish;
        end    
endmodule