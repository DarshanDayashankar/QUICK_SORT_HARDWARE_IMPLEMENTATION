`timescale 1ns / 1ps
module swap_test;
    parameter WORD_SIZE = 16;
    reg [WORD_SIZE-1:0] addr1, addr2;
    reg clk, swap_en;
    wire [WORD_SIZE-1:0] reg_addr, reg_out, reg_in;
    wire WRITE_EN, READ_EN;
    swap uut(.clk(clk), .addr1(addr1),  .addr2(addr2), .reg_addr(reg_addr), .reg_out(reg_out), .reg_in(reg_in), .reg_READ_EN(READ_EN), .reg_WRITE_EN(WRITE_EN), .swap_en(swap_en));
    REG reg_file(.clk(clk), .addr(reg_addr), .out(reg_out), .in(reg_in), .READ_EN(READ_EN), .WRITE_EN(WRITE_EN));
    initial begin
        addr1 <= 0;
        addr2 <= 3;
        
        reg_file.REG_FILE[0] <= 9;
        reg_file.REG_FILE[1] <= 8;
        reg_file.REG_FILE[2] <= 7;
        reg_file.REG_FILE[3] <= 6;
        reg_file.REG_FILE[4] <= 5;
        reg_file.REG_FILE[5] <= 3;
        reg_file.REG_FILE[6] <= 4;
        reg_file.REG_FILE[7] <= 2;
        reg_file.REG_FILE[8] <= 1;
        reg_file.REG_FILE[9] <= 13;
        #2000
        swap_en <= 1;
        addr1 <= 4;
        addr2 <= 7;


        
    end 

    initial
    begin
        $monitor("%d %d %d %d %d %d %d %d %d %d\n", reg_file.REG_FILE[0], reg_file.REG_FILE[1], 
        reg_file.REG_FILE[2], reg_file.REG_FILE[3], reg_file.REG_FILE[4], reg_file.REG_FILE[5], reg_file.REG_FILE[6], reg_file.REG_FILE[7], 
        reg_file.REG_FILE[8], reg_file.REG_FILE[9]);
    end

    initial 
    begin
    #100 clk = 0;
    repeat (300) #40 clk = ~clk;
    end
    initial
        begin
            $dumpfile ("swap.vcd");
            $dumpvars (0, swap_test);
            #3000 $finish;
        end    
endmodule