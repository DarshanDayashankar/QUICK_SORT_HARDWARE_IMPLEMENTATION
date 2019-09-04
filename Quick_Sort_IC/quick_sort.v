`timescale 1ns / 1ps
module quick_sort(clk, A, lo, hi);
    parameter WORD_SIZE = 16;

    input [WORD_SIZE-1:0] A, lo, hi;
    input clk;

    
    reg [WORD_SIZE-1:0] stack[0:4095];
    reg [WORD_SIZE-1:0] REG [0:4095];
    reg [WORD_SIZE-1:0] lo_reg, hi_reg, pivot, temp, i, j;
    reg [WORD_SIZE-1:0] stack_pointer;
    reg flag;
    //initial
    always @ (posedge clk)
    begin
        if (flag==0) begin
            $display("intial");
            stack_pointer=0;
            stack_pointer = stack_pointer + 1;
            stack[stack_pointer] = lo;
            //$display("intial\n");

            stack_pointer = stack_pointer + 1;
            stack[stack_pointer] = hi;
            flag=1;
        end
    end        

    always @ (posedge clk)
    begin    
        if(stack_pointer > 0 && flag>0)
        begin
            //$display("sorter1");
            hi_reg = stack[stack_pointer];
            stack_pointer = stack_pointer - 1;
            lo_reg = stack[stack_pointer];
            stack_pointer = stack_pointer - 1;
            
            if(lo_reg<hi_reg)
            begin
                pivot = REG[A+hi_reg];
               //$display("pivot=%d ", pivot);
                i = lo_reg;
                //$display("i=%d ", i);
                for (j=lo_reg; j<hi_reg; j=j+1)
                begin
                    //$display("j=%d ", j);
                    if(REG[A+j]<pivot)
                    begin
                        //$display("swap1\n");
                        //$display("%d %d", REG[A+i], REG[A+j]);
                        temp = REG[A+i];
                        REG[A+i] = REG[A+j];
                        REG[A+j] = temp;
                        i=i+1;
                    end
                end
                //$display("swap2\n");
                //$display("%d %d", REG[A+i], REG[A+hi_reg]);
                temp = REG[A+i];
                REG[A+i] = REG[A+hi_reg];
                REG[A+hi_reg] = temp;
                if(i>lo_reg) begin
                stack_pointer = stack_pointer + 1;
                stack[stack_pointer] = lo_reg;
                stack_pointer = stack_pointer + 1;
                stack[stack_pointer] = i-1;
                end
                if(i<hi_reg) begin
                stack_pointer = stack_pointer + 1;
                stack[stack_pointer] = i+1;
                stack_pointer = stack_pointer + 1;
                stack[stack_pointer] = hi_reg;
                end
            end
        end     
    end
/*
    always @ (posedge clk)
    begin    
        if(stack_pointer > 0 && flag>0)
        begin
            $display("sorter2");
            hi_reg = stack[stack_pointer];
            stack_pointer = stack_pointer - 1;
            lo_reg = stack[stack_pointer];
            stack_pointer = stack_pointer - 1;
            
            if(lo_reg<hi_reg)
            begin
                pivot = REG[A+hi_reg];
                //$display("pivot=%d ", pivot);
                i = lo_reg;
               // $display("i=%d ", i);
                for (j=lo_reg; j<hi_reg; j=j+1)
                begin
                   // $display("j=%d ", j);
                    if(REG[A+j]<pivot)
                    begin
                        //$display("swap1\n");
                        //$display("%d %d", REG[A+i], REG[A+j]);
                        temp = REG[A+i];
                        REG[A+i] = REG[A+j];
                        REG[A+j] = temp;
                        i=i+1;
                    end
                end
                //$display("swap2\n");
                //$display("%d %d", REG[A+i], REG[A+hi_reg]);
                temp = REG[A+i];
                REG[A+i] = REG[A+hi_reg];
                REG[A+hi_reg] = temp;
                if(i>1) begin
                stack_pointer = stack_pointer + 1;
                stack[stack_pointer] = lo_reg;
                stack_pointer = stack_pointer + 1;
                stack[stack_pointer] = i-1;
                end
                if(i+lo_reg<hi_reg) begin
                stack_pointer = stack_pointer + 1;
                stack[stack_pointer] = i+1;
                stack_pointer = stack_pointer + 1;
                stack[stack_pointer] = hi_reg;
                end
            end
        end
    end
    always @ (posedge clk)
    begin
        if(stack_pointer > 0 && flag>0)
        begin
            $display("sorter3");
            hi_reg = stack[stack_pointer];
            stack_pointer = stack_pointer - 1;
            lo_reg = stack[stack_pointer];
            stack_pointer = stack_pointer - 1;
            
            if(lo_reg<hi_reg)
            begin
                pivot = REG[A+hi_reg];
                //$display("pivot=%d ", pivot);
                i = lo_reg;
               // $display("i=%d ", i);
                for (j=lo_reg; j<hi_reg; j=j+1)
                begin
                   // $display("j=%d ", j);
                    if(REG[A+j]<pivot)
                    begin
                        //$display("swap1\n");
                        //$display("%d %d", REG[A+i], REG[A+j]);
                        temp = REG[A+i];
                        REG[A+i] = REG[A+j];
                        REG[A+j] = temp;
                        i=i+1;
                    end
                end
                //$display("swap2\n");
                //$display("%d %d", REG[A+i], REG[A+hi_reg]);
                temp = REG[A+i];
                REG[A+i] = REG[A+hi_reg];
                REG[A+hi_reg] = temp;
                if(i>1) begin
                stack_pointer = stack_pointer + 1;
                stack[stack_pointer] = lo_reg;
                stack_pointer = stack_pointer + 1;
                stack[stack_pointer] = i-1;
                end
                if(i+lo_reg<hi_reg) begin
                stack_pointer = stack_pointer + 1;
                stack[stack_pointer] = i+1;
                stack_pointer = stack_pointer + 1;
                stack[stack_pointer] = hi_reg;
                end
            end
        end
    end*/
endmodule