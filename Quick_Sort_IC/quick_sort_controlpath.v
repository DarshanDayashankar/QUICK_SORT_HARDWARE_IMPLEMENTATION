module quick_sort_controlpath(clk, A, lo, hi, 
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

    //CONTROLLER PATH OUTPUTS
    output reg stack_reset, counter_reset, push_en, pop_en, READ_EN, WRITE_EN, swap_en;
    output reg stack_data_in1_reset, stack_data_in2_reset, reg_addr_reset, reg_data_in_reset, swap_addr1_reset, swap_addr2_reset;
    output reg stack_data_in1_write_en, stack_data_in2_write_en, reg_addr_write_en, reg_data_in_write_en, swap_addr1_write_en, swap_addr2_write_en;
    output reg mux_swap_sel, lo_reg_reset, hi_reg_reset, pivot_reset, temp_reset, i_reset, j_reset;
    output reg lo_reg_write_en, hi_reg_write_en, pivot_write_en, temp_write_en, i_write_en, j_write_en;
    output reg [1:0] stack_data_in1_sel, stack_data_in2_sel, adder_in_sel;
    output reg add_sub_1_i_sel, add_sub_1_j_sel, i_sel, j_sel;
    
    //CONTROLLER PATH INPUTSS

    input [4:0] count;
    input [WORD_SIZE-1:0] stack_pointer, lo_reg_data_out, hi_reg_data_out, i_data_out, j_data_out, reg_data_out, pivot_data_out;

    reg [5:0] state;
    reg [1:0] flag;
    //initial
    
    always @ (posedge clk)
    begin
        case (flag)
            0: begin
                $display("intialstate0");
                //RESETS
                stack_reset = 1;
                stack_data_in1_reset=1;
                stack_data_in2_reset=1; 
                reg_addr_reset=1; 
                reg_data_in_reset=1; 
                swap_addr1_reset=1; 
                swap_addr2_reset=1;
                lo_reg_reset=1; 
                hi_reg_reset=1; 
                pivot_reset=1; 
                temp_reset=1; 
                i_reset=1; 
                j_reset=1;
                //REG WRITE_EN
                stack_data_in1_write_en=0; 
                stack_data_in2_write_en=0; 
                reg_addr_write_en=0; 
                reg_data_in_write_en=0; 
                swap_addr1_write_en=0; 
                swap_addr2_write_en=0;
                lo_reg_write_en=0; 
                hi_reg_write_en=0; 
                pivot_write_en=0; 
                temp_write_en=0; 
                i_write_en=0; 
                j_write_en=0;

                push_en = 0;
                pop_en = 0;
                READ_EN = 0;
                WRITE_EN = 0;
                swap_en = 0;
                mux_swap_sel = 0;
                counter_reset = 1;
                flag = 1;
            end

            1: begin
                $display("intialstate1");
                stack_reset = 0;
                stack_data_in1_reset=0;
                stack_data_in2_reset=0; 
                reg_addr_reset=0; 
                reg_data_in_reset=0; 
                swap_addr1_reset=0; 
                swap_addr2_reset=0;
                lo_reg_reset=0; 
                hi_reg_reset=0; 
                pivot_reset=0; 
                temp_reset=0; 
                i_reset=0; 
                j_reset=0;
                push_en = 1;
                stack_data_in1_sel = 0;
                stack_data_in1_write_en = 1;
                stack_data_in2_sel = 0;
                stack_data_in2_write_en = 1;
                counter_reset = 1;
                flag = 2;
            end

            2: begin
                $display("intialstate2");
                counter_reset = 0;
                //$display("count =  %d", count);
                stack_data_in2_write_en = 0;
                stack_data_in1_write_en = 0;
                if (count > 3) state = 0;
                if (count > 3) flag =3;
            end

            3: begin
                
            end
        endcase
    end
    
    
    
    always@ (posedge clk) 
    begin
        case (state)
        ASM 0
            0: begin
                $display("state0");
                push_en = 0;
                pop_en = 0;
                READ_EN = 0;
                WRITE_EN = 0;
                counter_reset = 1;
                //REG WRITE_EN
                stack_data_in1_write_en=0; 
                stack_data_in2_write_en=0; 
                reg_addr_write_en=0; 
                reg_data_in_write_en=0; 
                swap_addr1_write_en=0; 
                swap_addr2_write_en=0;
                lo_reg_write_en=0; 
                hi_reg_write_en=0; 
                pivot_write_en=0; 
                temp_write_en=0; 
                i_write_en=0; 
                j_write_en=0;
                
                if(stack_pointer > 0 && flag > 1) state = 1;
            end
        ASM 1
            1: begin
                $display("state1");
                pop_en = 1;
                state =2;
            end
        ASM 2
            2: begin
                $display("state2");
                counter_reset = 0;
                //$display("count =  %d", count);
                if (count > 3 ) state = 3;
            end
        ASM 3
            3: begin
                //$display("state3");
                hi_reg_write_en = 1;
                lo_reg_write_en = 1;
                pop_en = 0;
                state = 4;
                
            end

            4: begin
                hi_reg_write_en = 0;
                lo_reg_write_en = 0;
                if (lo_reg_data_out < hi_reg_data_out) state = 5;
                else state = 0;
            end
        ASM 4
            5: begin
                $display("state4");
                
                mux_swap_sel = 0;
                READ_EN = 1;
                reg_addr_write_en = 1;
                adder_in_sel = 2;
                i_write_en =1;
                j_write_en =1;
                i_sel =1;
                j_sel =1;
                state =6; 
            end
        ASM 5
            6: begin
                $display("state5");
                i_write_en =0;
                j_write_en =0;
                reg_addr_write_en = 0;
                pivot_write_en = 1;
                state = 7;
            end
        ASM 6
            7: begin
                $display("state6");
                pivot_write_en = 0;
                j_write_en = 0;
                READ_EN = 1;
                WRITE_EN = 0;
                reg_addr_write_en =1;
                adder_in_sel = 1;
                mux_swap_sel = 0;
                if(j_data_out<hi_reg_data_out) state = 8;
                else state =12;
            end
        ASM 7
            8: begin
                $display("state7");
                reg_addr_write_en =0;
                counter_reset = 1;
                $display("reg_data_out = %d pivot = %d", reg_data_out, pivot_data_out); 
                if(reg_data_out < pivot_data_out) state = 9;
                else  state = 13;
            end
        ASM 8
            9: begin
                $display("state8");
                swap_addr1_write_en =1;
                adder_in_sel = 0;
                state = 10;
            end

            10: begin
                $display("state9");
                swap_addr1_write_en = 0;
                swap_addr2_write_en = 1;
                adder_in_sel = 1;
                add_sub_1_i_sel = 1;
                i_sel = 0;
                i_write_en =1;
                //swap_addr2 = A+j;
                //i=i+1;
                swap_en = 1;
                mux_swap_sel =1;
                state = 11;
            end
        ASM 9
            11: begin
                $display("state10");
                swap_addr2_write_en = 0;
                i_write_en = 0;
                swap_en = 0;
                counter_reset = 0;
                //$display("count =  %d", count);
                if (count > 3) state = 12;
            end
        ASM 10    
            12: begin 
                j_sel =0;
                j_write_en = 1;
                add_sub_1_j_sel = 1;
                //j=j+1;
                state = 7;
            end
        ASM 11
            13: begin
                $display("state12");
                reg_addr_write_en =0;
                swap_addr1_write_en = 1;
                adder_in_sel = 0;
                //swap_addr1 = A+i;
                state = 14;
            end

            14: begin
                $display("state13");
                swap_addr1_write_en = 0;
                swap_addr2_write_en = 1;
                adder_in_sel = 3;
                swap_en = 1;
                mux_swap_sel = 1;
                counter_reset = 1; 
                //swap_addr2 = A+hi_reg;
                state =15;
            end

        ASM 12
            15: begin
                $display("state14");
                swap_addr2_write_en = 0;
                swap_en = 0;
                counter_reset = 0;
                if (count > 3 && i_data_out> lo_reg_data_out) state = 16;
                else if (count >3 && i_data_out < hi_reg_data_out) state = 18;
                else if (count > 3) state = 0;
            end
        ASM 13
            16: begin
                $display("state15");
                mux_swap_sel = 0;
                push_en = 1;
                counter_reset = 1;
                stack_data_in1_write_en =1;
                stack_data_in2_write_en =1;
                stack_data_in1 = lo_reg;
                stack_data_in2 = i-1;
                state = 17;
            end
        ASM 14
            17: begin
                counter_reset = 1;
                state = 18;
            end
        ASM 15
            18: begin
                $display("state17");
                counter_reset = 0;
                //push_en = 0;
                //$display("count = %d", count);
                if (count > 3 && i_data_out+lo_reg_data_out < hi_reg_data_out) state = 19;
                else if(count > 3) state =0;
            end
        ASM 16
            19: begin
                $display("state18");
                push_en = 0;
                counter_reset = 1;
                stack_data_in1 = i+1;
                stack_data_in2 = hi_reg;
                state = 20;
            end
        ASM 17
            20: begin
                push_en = 1;
                counter_reset = 1;
                state = 21;
            end
        ASM 18
            21: begin
                $display("state20");
                //push_en = 0;
                counter_reset = 0;
                if (count > 3) state = 0;
            end
        endcase
    end
endmodule    