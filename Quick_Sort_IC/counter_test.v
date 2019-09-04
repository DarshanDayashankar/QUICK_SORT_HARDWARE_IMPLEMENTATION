`timescale 1ns / 1ps

module counter_test;
    reg clk, reset;
    wire [4:0] count;

    counter uut(.clk(clk), .reset(reset), .count(count));

    initial
    begin
        clk = 0;
        reset = 1;
        #100 reset = 0;
    end

    initial repeat (300) #40 clk = ~clk;

    initial $monitor("count = %d", count);

    initial
        begin
            $dumpfile ("count.vcd");
            $dumpvars (0, counter_test);
            #3000 $finish;
        end  

endmodule