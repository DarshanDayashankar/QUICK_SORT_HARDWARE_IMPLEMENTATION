`timescale 1ns / 1ps
module quick_sort(clk, A, lo, hi);
    parameter WORD_SIZE = 16;

    input [WORD_SIZE-1:0] A, lo, hi;
    input clk;
    reg stack_reset, counter_reset, push_en, pop_en, READ_EN, WRITE_EN, swap_en;
    reg [WORD_SIZE-1:0] stack_data_in1, stack_data_in2, reg_addr, reg_data_in, swap_addr1, swap_addr2;
    wire [WORD_SIZE-1:0] stack_data_out1, stack_data_out2, stack_pointer, reg_data_out;
    wire [4:0] count;

    wire [WORD_SIZE-1:0] swap_reg_addr, swap_reg_data_in;
    wire swap_READ_EN, swap_WRITE_EN;


    reg mux_swap_sel;
    wire mux_read_en_out, mux_write_en_out;
    wire [WORD_SIZE-1:0] mux_addr_out, mux_data_in_out;


    MUX #(.LENGTH(1)) mux_swap_reg_read_en (.MUX2_IN1(READ_EN), .MUX2_IN2(swap_READ_EN), .MUX2_SEL(mux_swap_sel), .MUX2_OUT(mux_read_en_out));
    MUX #(.LENGTH(1)) mux_swap_reg_write_en (.MUX2_IN1(WRITE_EN), .MUX2_IN2(swap_WRITE_EN), .MUX2_SEL(mux_swap_sel), .MUX2_OUT(mux_write_en_out));
    MUX #(.LENGTH(WORD_SIZE)) mux_swap_reg_addr (.MUX2_IN1(reg_addr), .MUX2_IN2(swap_reg_addr), .MUX2_SEL(mux_swap_sel), .MUX2_OUT(mux_addr_out));
    MUX #(.LENGTH(WORD_SIZE)) mux_swap_reg_data_in (.MUX2_IN1(reg_data_in), .MUX2_IN2(swap_reg_data_in), .MUX2_SEL(mux_swap_sel), .MUX2_OUT(mux_data_in_out));


    stack stk(.clk(clk), .reset(stack_reset), .push_en(push_en), .pop_en(pop_en), .data_in1(stack_data_in1), .data_in2(stack_data_in2), 
    .data_out1(stack_data_out1), .data_out2(stack_data_out2), .stack_pointer(stack_pointer));
    
    REG reg_file(.clk(clk), .addr(mux_addr_out), .out(reg_data_out), .in(mux_data_in_out), .READ_EN(mux_read_en_out), .WRITE_EN(mux_write_en_out));
    counter ctr(.clk(clk), .reset(counter_reset), .count(count));
    swap sw(.clk(clk), .addr1(swap_addr1), .addr2(swap_addr2), .reg_addr(swap_reg_addr), .reg_out(reg_data_out), .reg_in(swap_reg_data_in), .reg_READ_EN(swap_READ_EN), .reg_WRITE_EN(swap_WRITE_EN), .swap_en(swap_en));
    
    
    reg [WORD_SIZE-1:0] lo_reg, hi_reg, pivot, temp, i, j;
    reg [5:0] state;
    reg [1:0] flag;
    //initial
    
    always @ (posedge clk)
    begin
        case (flag)
            0: begin
                $display("intialstate0");
                stack_reset = 1;
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
                push_en = 1;
                stack_data_in1 = lo;
                stack_data_in2 = hi;
                counter_reset = 1;
                flag = 2;
            end

            2: begin
                $display("intialstate2");
                counter_reset = 0;
                //$display("count =  %d", count);
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
            0: begin
                //$display("state0");
                push_en = 0;
                pop_en = 0;
                READ_EN = 0;
                WRITE_EN = 0;
                counter_reset = 1;
                if(stack_pointer > 0 && flag > 1) state = 1;
            end

            1: begin
                $display("state1");
                pop_en = 1;
                state =2;
            end

            2: begin
                $display("state2");
                counter_reset = 0;
                //$display("count =  %d", count);
                if (count > 3 ) state = 3;
            end

            3: begin
                $display("state3");
                hi_reg = stack_data_out1;
                lo_reg = stack_data_out2;
                pop_en = 0;
                if (lo_reg < hi_reg) state = 4;
                else state = 0;
            end

            4: begin
                $display("state4");
                mux_swap_sel = 0;
                READ_EN = 1;
                reg_addr = A+hi_reg;
                //$display("reg_addr = %d", reg_addr);
                i = lo_reg;
                j = lo_reg;
                state =5; 
            end

            5: begin
                $display("state5");
                pivot = reg_data_out;
                state = 6;
            end

            6: begin
                $display("state6");
                READ_EN = 1;
                WRITE_EN = 0;
                reg_addr = A + j;
                mux_swap_sel = 0;
                if(j<hi_reg) state = 7;
                else state =11;
            end

            7: begin
                $display("state7");
                counter_reset = 1;
                //$display("reg_data_out = %d pivot = %d", reg_data_out, pivot); 
                if(reg_data_out < pivot) state = 8;
                else  state = 10;
            end

            8: begin
                $display("state8");
                swap_addr1 = A+i;
                swap_addr2 = A+j;
                swap_en = 1;
                i=i+1;
                mux_swap_sel =1;
                state = 9;
            end

            9: begin
                $display("state9");
                swap_en = 0;
                counter_reset = 0;
                //$display("count =  %d", count);
                if (count > 3) state = 10;
            end
            
            10: begin 
                j=j+1;
                state = 6;
            end

            11: begin
                $display("state11");
                swap_addr1 = A+i;
                swap_addr2 = A+hi_reg;
                swap_en = 1;
                mux_swap_sel = 1;
                counter_reset = 1;
                state = 12;
            end

            12: begin
                $display("state12");
                swap_en = 0;
                counter_reset = 0;
                if (count > 3 && i> lo_reg) state = 13;
                else if (count >3 && i < hi_reg) state = 15;
                else if (count > 3) state = 0;
            end

            13: begin
                $display("state13");
                mux_swap_sel = 0;
                push_en = 1;
                counter_reset = 1;
                stack_data_in1 = lo_reg;
                stack_data_in2 = i-1;
                state = 14;
            end

            14: begin
                counter_reset = 1;
                state = 15;
            end

            15: begin
                $display("state15");
                counter_reset = 0;
                //push_en = 0;
                //$display("count = %d", count);
                if (count > 3 && i < hi_reg) state = 16;
                else if(count > 3) state =0;
            end

            16: begin
                $display("state16");
                push_en = 0;
                counter_reset = 1;
                stack_data_in1 = i+1;
                stack_data_in2 = hi_reg;
                state = 17;
            end

            17: begin
                push_en = 1;
                counter_reset = 1;
                state = 18;
            end

            18: begin
                $display("state18");
                //push_en = 0;
                counter_reset = 0;
                if (count > 3) state = 0;
            end
        endcase
    end

    
endmodule