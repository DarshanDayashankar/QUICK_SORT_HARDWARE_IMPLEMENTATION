`timescale 1ns / 1ps
module quick_sort_datapath(clk, A, lo, hi, 
                            stack_reset, counter_reset, push_en, pop_en, READ_EN, WRITE_EN, swap_en,
                            stack_data_in1_reset, stack_data_in2_reset, reg_addr_reset, reg_data_in_reset, swap_addr1_reset, swap_addr2_reset,
                            stack_data_in1_write_en, stack_data_in2_write_en, reg_addr_write_en, reg_data_in_write_en, swap_addr1_write_en, swap_addr2_write_en,
                            mux_swap_sel, lo_reg_reset, hi_reg_reset, pivot_reset, temp_reset, i_reset, j_reset,
                            lo_reg_write_en, hi_reg_write_en, pivot_write_en, temp_write_en, i_write_en, j_write_en,
                            stack_data_in1_sel, stack_data_in2_sel, adder_in_sel, add_sub_1_i_sel, add_sub_1_j_sel, i_sel, j_sel,
                            stack_pointer, lo_reg_data_out, hi_reg_data_out, i_data_out, j_data_out, reg_data_out, pivot_data_out, count);
    parameter WORD_SIZE = 16;

    //INPUTS
    input [WORD_SIZE-1:0] A, lo, hi;
    input clk;

    //CONTROLLER PATH INPUTS
    input stack_reset, counter_reset, push_en, pop_en, READ_EN, WRITE_EN, swap_en;
    input stack_data_in1_reset, stack_data_in2_reset, reg_addr_reset, reg_data_in_reset, swap_addr1_reset, swap_addr2_reset;
    input stack_data_in1_write_en, stack_data_in2_write_en, reg_addr_write_en, reg_data_in_write_en, swap_addr1_write_en, swap_addr2_write_en;
    input mux_swap_sel, lo_reg_reset, hi_reg_reset, pivot_reset, i_reset, j_reset;
    input lo_reg_write_en, hi_reg_write_en, pivot_write_en, i_write_en, j_write_en;
    input [1:0] stack_data_in1_sel, stack_data_in2_sel, adder_in_sel;
    input add_sub_1_i_sel, add_sub_1_j_sel, i_sel, j_sel;

    //CONTROLLER PATH OUTPUTS

    output [4:0] count;
    output [WORD_SIZE-1:0] stack_pointer, lo_reg_data_out, hi_reg_data_out, i_data_out, j_data_out, reg_data_out, pivot_data_out;
    
    
    wire [WORD_SIZE-1:0] stack_data_in1_data_out, stack_data_in2_data_out, reg_addr_reg_out, reg_data_in_reg_out, swap_addr1_data_out, swap_addr2_data_out;
    wire [WORD_SIZE-1:0] stack_data_in1_data_in, stack_data_in2_data_in, reg_data_in_reg_in;
    wire [WORD_SIZE-1:0] pivot_data_in, i_data_in, j_data_in;

    register  stack_data_in1(.CLK(clk), .RESET(stack_data_in1_reset), .WRITE_EN(stack_data_in1_write_en), .REG_IN(stack_data_in1_data_in), .REG_OUT(stack_data_in1_data_out)); 
    register  stack_data_in2(.CLK(clk), .RESET(stack_data_in2_reset), .WRITE_EN(stack_data_in2_write_en), .REG_IN(stack_data_in2_data_in), .REG_OUT(stack_data_in2_data_out)); 
    register  reg_addr(.CLK(clk), .RESET(reg_addr_reset), .WRITE_EN(reg_addr_write_en), .REG_IN(adder_out), .REG_OUT(reg_addr_reg_out)); 
    register  reg_data_in(.CLK(clk), .RESET(reg_data_in_reset), .WRITE_EN(reg_data_in_write_en), .REG_IN(reg_data_in_reg_in), .REG_OUT(reg_data_in_reg_out)); 
    register  swap_addr1(.CLK(clk), .RESET(swap_addr1_reset), .WRITE_EN(swap_addr1_write_en), .REG_IN(adder_out), .REG_OUT(swap_addr1_data_out)); 
    register  swap_addr2(.CLK(clk), .RESET(swap_addr2_reset), .WRITE_EN(swap_addr2_write_en), .REG_IN(adder_out), .REG_OUT(swap_addr2_data_out));
    register lo_reg(.CLK(clk), .RESET(lo_reg_reset), .WRITE_EN(lo_reg_write_en), .REG_IN(stack_data_out2), .REG_OUT(lo_reg_data_out));
    register hi_reg(.CLK(clk), .RESET(hi_reg_reset), .WRITE_EN(hi_reg_write_en), .REG_IN(stack_data_out1), .REG_OUT(hi_reg_data_out));
    register pivot(.CLK(clk), .RESET(pivot_reset), .WRITE_EN(pivot_write_en), .REG_IN(pivot_data_in), .REG_OUT(pivot_data_out));
    //register temp(.CLK(clk), .RESET(temp_reset), .WRITE_EN(temp_write_en), .REG_IN(temp_data_in), .REG_OUT(temp_data_out));
    register i(.CLK(clk), .RESET(i_reset), .WRITE_EN(i_write_en), .REG_IN(i_data_in), .REG_OUT(i_data_out));
    register j(.CLK(clk), .RESET(j_reset), .WRITE_EN(j_write_en), .REG_IN(j_data_in), .REG_OUT(j_data_out));
        
    wire [WORD_SIZE-1:0] stack_data_out1, stack_data_out2, reg_data_out;
    wire [WORD_SIZE-1:0] swap_reg_addr, swap_reg_data_in;
    wire swap_READ_EN, swap_WRITE_EN;
    wire mux_read_en_out, mux_write_en_out;
    wire [WORD_SIZE-1:0] mux_addr_out, mux_data_in_out;
    wire [WORD_SIZE-1:0] add_sub_1_i_out, add_sub_1_j_out;
    wire [WORD_SIZE-1:0] mux_adder_out, adder_out;

    MUX #(.LENGTH(1)) mux_swap_reg_read_en (.MUX2_IN1(READ_EN), .MUX2_IN2(swap_READ_EN), .MUX2_SEL(mux_swap_sel), .MUX2_OUT(mux_read_en_out));
    MUX #(.LENGTH(1)) mux_swap_reg_write_en (.MUX2_IN1(WRITE_EN), .MUX2_IN2(swap_WRITE_EN), .MUX2_SEL(mux_swap_sel), .MUX2_OUT(mux_write_en_out));
    MUX #(.LENGTH(WORD_SIZE)) mux_swap_reg_addr (.MUX2_IN1(reg_addr_reg_out), .MUX2_IN2(swap_reg_addr), .MUX2_SEL(mux_swap_sel), .MUX2_OUT(mux_addr_out));
    MUX #(.LENGTH(WORD_SIZE)) mux_swap_reg_data_in (.MUX2_IN1(reg_data_in_reg_out), .MUX2_IN2(swap_reg_data_in), .MUX2_SEL(mux_swap_sel), .MUX2_OUT(mux_data_in_out));

    MUX #(.LENGTH(WORD_SIZE)) mux_i_in (.MUX2_IN1(add_sub_1_i_out), .MUX2_IN2(lo_reg_data_out), .MUX2_SEL(i_sel), .MUX2_OUT(i_data_in));
    MUX #(.LENGTH(WORD_SIZE)) mux_j_in (.MUX2_IN1(add_sub_1_j_out), .MUX2_IN2(lo_reg_data_out), .MUX2_SEL(j_sel), .MUX2_OUT(j_data_in));

    MUX3 #(.LENGTH(WORD_SIZE)) mux_stack_data_in1 (.MUX3_IN1(lo), .MUX3_IN2(lo_reg_data_out), .MUX3_IN3(i_data_out), 
                                                    .MUX3_SEL(stack_data_in1_sel), .MUX3_OUT(stack_data_in1_data_in));
    MUX3 #(.LENGTH(WORD_SIZE)) mux_stack_data_in2 (.MUX3_IN1(hi), .MUX3_IN2(hi_reg_data_out), .MUX3_IN3(j_data_out), 
                                                    .MUX3_SEL(stack_data_in2_sel), .MUX3_OUT(stack_data_in2_data_in));
    MUX3 #(.LENGTH(WORD_SIZE)) mux_adder_in (.MUX3_IN1(i_data_out), .MUX3_IN2(j_data_out), .MUX3_IN3(hi_reg_data_out), 
                                                    .MUX3_SEL(adder_in_sel), .MUX3_OUT(mux_addr_out));

    stack stk(.clk(clk), .reset(stack_reset), .push_en(push_en), .pop_en(pop_en), .data_in1(stack_data_in1_data_out), .data_in2(stack_data_in2_data_out), 
    .data_out1(stack_data_out1), .data_out2(stack_data_out2), .stack_pointer(stack_pointer));
    REG reg_file(.clk(clk), .addr(mux_addr_out), .out(reg_data_out), .in(mux_data_in_out), .READ_EN(mux_read_en_out), .WRITE_EN(mux_write_en_out));
    counter ctr(.clk(clk), .reset(counter_reset), .count(count));
    swap sw(.clk(clk), .addr1(swap_addr1), .addr2(swap_addr2), .reg_addr(swap_reg_addr), .reg_out(reg_data_out), .reg_in(swap_reg_data_in), .reg_READ_EN(swap_READ_EN), .reg_WRITE_EN(swap_WRITE_EN), .swap_en(swap_en));
    
    adder #(.LENGTH(WORD_SIZE)) adder1 (.ADD_IN1(A), .ADD_IN2(mux_adder_out), .ADD_OUT(adder_out));
    add_sub_1 #(.LENGTH(WORD_SIZE)) as1i (.in(i_data_out), .add_sub(add_sub_1_i_sel), .out(add_sub_1_i_out));
    add_sub_1 #(.LENGTH(WORD_SIZE)) as1j (.in(j_data_out), .add_sub(add_sub_1_j_sel), .out(add_sub_1_j_out));

endmodule