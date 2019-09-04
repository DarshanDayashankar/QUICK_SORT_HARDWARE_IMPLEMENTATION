`timescale 1ns / 1ps

module stack_test;
    parameter WORD_SIZE = 16;

    reg clk, reset, push_en, pop_en;
    reg [WORD_SIZE-1:0] data_in1, data_in2;
    wire [WORD_SIZE-1:0] data_out1, data_out2, stack_pointer;

    stack uut(.clk(clk), .reset(reset), .push_en(push_en), .pop_en(pop_en), .data_in1(data_in1), .data_in2(data_in2), .data_out1(data_out1), .data_out2(data_out2), .stack_pointer(stack_pointer));
    initial begin
        clk=0;
        #10 reset = 0;
        #10 reset = 1;
        #10 reset = 0;
        push_en = 1;
        pop_en = 0;
        data_in1 = 22;
        data_in2 = 23;
        repeat(8) #10 clk = ~clk;
        #10 push_en = 0;
        #10 push_en = 1;
        data_in1 = 24;
        data_in2 = 25;
        repeat(8) #10 clk = ~clk;
        #10 push_en = 0;
        #10 push_en = 1;
        data_in1 = 26;
        data_in2 = 27;
        repeat(8) #10 clk = ~clk;
        push_en = 0;
        pop_en = 1;
        repeat(8) #10 clk = ~clk;
        #10 pop_en = 0;
        #10 pop_en = 1;
        repeat(8) #10 clk = ~clk;
        #10 pop_en = 0;
        #10 pop_en = 1;
        repeat(8) #10 clk = ~clk;

        
    end 

    initial
    begin
        $monitor("data_out1 %d data_out2 %d", data_out1, data_out2);
    end

    initial
        begin
            $dumpfile ("stack.vcd");
            $dumpvars (0, stack_test);
            #30000 $finish;
        end    

endmodule

