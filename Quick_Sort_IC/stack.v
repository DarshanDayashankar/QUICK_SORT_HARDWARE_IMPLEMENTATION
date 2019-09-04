module stack(clk, reset, push_en, pop_en, data_in1, data_in2, data_out1, data_out2, stack_pointer);
    parameter WORD_SIZE = 16;
    input clk, reset, push_en, pop_en;
    input [WORD_SIZE-1:0] data_in1, data_in2;
    output reg [WORD_SIZE-1:0] data_out1, data_out2, stack_pointer;
    reg [WORD_SIZE-1:0] stack [0:4095];
    reg [2:0] push_state, pop_state;

    always@ (posedge reset) stack_pointer <= 0;
    always@ (posedge push_en) push_state <= 0;
    always@ (posedge pop_en) pop_state <= 0;

    always@ (negedge clk) 
    begin
        if(push_en == 1) 
        begin
            case (push_state)
            default: begin
                
            end
            0:      begin 
                        stack_pointer = stack_pointer + 1;
                        $display("sp %d", stack_pointer);
                        push_state = 1;
                    end  
            1:      begin 
                        stack[stack_pointer] = data_in1;
                        $display("push %d", stack[stack_pointer]);
                        push_state = 2;
                    end  
            2:      begin 
                        stack_pointer = stack_pointer + 1;
                        $display("sp %d", stack_pointer);
                        push_state = 3;
                    end  
            3:      begin 
                        stack[stack_pointer] = data_in2;
                        $display("push %d", stack[stack_pointer]);
                        push_state = 4;
                    end
            4:      begin

                    end
            endcase
        end                   
        else if (pop_en == 1) 
        begin

           case (pop_state)
                default: begin
                    
                end

                0:  begin    
                    data_out1 = stack[stack_pointer];
                    $display("pop %d", stack[stack_pointer]); 
                    pop_state = 1;
                    end

                1:  begin    
                    stack_pointer = stack_pointer - 1;
                    $display("sp %d", stack_pointer);
                    pop_state = 2;
                    end

                2:  begin  
                    data_out2 = stack[stack_pointer];
                    $display("pop %d", stack[stack_pointer]); 
                    pop_state = 3;
                    end

                3:  begin    
                    stack_pointer = stack_pointer - 1;
                    $display("sp %d", stack_pointer);
                    pop_state = 4;
                    end
                4:  begin
                    
                    end
           endcase            
        end    
    end

endmodule