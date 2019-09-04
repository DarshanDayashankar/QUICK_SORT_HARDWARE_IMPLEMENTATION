module quick_sort_rtl (clk, A, lo, hi);
    
    parameter WORD_SIZE =  16;
    
    //INPUTS
    input [WORD_SIZE-1:0] A, lo, hi;
    input clk;

    //CONTROLLER PATH INPUTS
    wire stack_reset, counter_reset, push_en, pop_en, READ_EN, WRITE_EN, swap_en;
    wire stack_data_in1_reset, stack_data_in2_reset, reg_addr_reset, reg_data_in_reset, swap_addr1_reset, swap_addr2_reset;
    wire stack_data_in1_write_en, stack_data_in2_write_en, reg_addr_write_en, reg_data_in_write_en, swap_addr1_write_en, swap_addr2_write_en;
    wire mux_swap_sel, lo_reg_reset, hi_reg_reset, pivot_reset, i_reset, j_reset;
    wire lo_reg_write_en, hi_reg_write_en, pivot_write_en, i_write_en, j_write_en;
    wire [1:0] stack_data_in1_sel, stack_data_in2_sel, adder_in_sel;
    wire add_sub_1_i_sel, add_sub_1_j_sel, i_sel, j_sel;

    //CONTROLLER PATH OUTPUTS

    wire [4:0] count;
    wire [WORD_SIZE-1:0] stack_pointer, lo_reg_data_out, hi_reg_data_out, i_data_out, j_data_out, reg_data_out, pivot_data_out;
    
    quick_sort_datapath  qsd1(clk, A, lo, hi, 
                            stack_reset, counter_reset, push_en, pop_en, READ_EN, WRITE_EN, swap_en,
                            stack_data_in1_reset, stack_data_in2_reset, reg_addr_reset, reg_data_in_reset, swap_addr1_reset, swap_addr2_reset,
                            stack_data_in1_write_en, stack_data_in2_write_en, reg_addr_write_en, reg_data_in_write_en, swap_addr1_write_en, swap_addr2_write_en,
                            mux_swap_sel, lo_reg_reset, hi_reg_reset, pivot_reset, temp_reset, i_reset, j_reset,
                            lo_reg_write_en, hi_reg_write_en, pivot_write_en, temp_write_en, i_write_en, j_write_en,
                            stack_data_in1_sel, stack_data_in2_sel, adder_in_sel, add_sub_1_i_sel, add_sub_1_j_sel, i_sel, j_sel,
                            stack_pointer, lo_reg_data_out, hi_reg_data_out, i_data_out, j_data_out, reg_data_out, pivot_data_out, count);

    quick_sort_controlpath qsc1(clk, A, lo, hi, 
                            stack_reset, counter_reset, push_en, pop_en, READ_EN, WRITE_EN, swap_en,
                            stack_data_in1_reset, stack_data_in2_reset, reg_addr_reset, reg_data_in_reset, swap_addr1_reset, swap_addr2_reset,
                            stack_data_in1_write_en, stack_data_in2_write_en, reg_addr_write_en, reg_data_in_write_en, swap_addr1_write_en, swap_addr2_write_en,
                            mux_swap_sel, lo_reg_reset, hi_reg_reset, pivot_reset, temp_reset, i_reset, j_reset,
                            lo_reg_write_en, hi_reg_write_en, pivot_write_en, temp_write_en, i_write_en, j_write_en,
                            stack_data_in1_sel, stack_data_in2_sel, adder_in_sel, add_sub_1_i_sel, add_sub_1_j_sel, i_sel, j_sel,
                            stack_pointer, lo_reg_data_out, hi_reg_data_out, i_data_out, j_data_out, reg_data_out, pivot_data_out, count);                        


endmodule