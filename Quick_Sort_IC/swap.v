module swap(clk, addr1, addr2, reg_addr, reg_out, reg_in, reg_READ_EN, reg_WRITE_EN, swap_en);
    parameter WORD_SIZE =16;
    input clk, swap_en;
    input [WORD_SIZE-1:0] addr1, addr2, reg_out;
    output reg [WORD_SIZE-1:0] reg_addr, reg_in;
    output reg reg_READ_EN, reg_WRITE_EN;
    reg [WORD_SIZE-1:0] temp1, temp2;
    reg [2:0] state;

    always @(posedge swap_en) state = 0;
    
    
    always @(posedge clk) 
    begin
        case (state)
            
            default :  
                begin
                reg_READ_EN = 1;
                reg_WRITE_EN = 0;
                reg_addr = addr1;
                //$display("default reg_addr=%d", reg_addr);
                state=1;
                end
            
            0:  
                begin
                reg_READ_EN = 1;
                reg_WRITE_EN = 0;
                reg_addr = addr1;
                
                //$display("state0 reg_addr=%d ", reg_addr);
                state =1;
                end
            1:  
                begin
                reg_addr = addr2;
                temp1 = reg_out;
                //$display("state1 reg_addr=%d temp1=%d", reg_addr, temp1);
                state =2;
                end    
            
            2: 
                begin
                reg_READ_EN = 0;
                reg_WRITE_EN = 1;
                reg_addr = addr1;
                temp2 = reg_out;
                reg_in = temp2;
                //$display("state2 reg_addr=%d temp2=%d", reg_addr, temp2);
                state=3;
                end
            3: 
                begin
                reg_addr = addr2;
                reg_in = temp1;
                //$display("state3 reg_addr=%d reg_in=%d", reg_addr, reg_in);
                state = 4;
                end
            4:
                begin
                    reg_WRITE_EN = 0;    
                end          

        endcase
    end
endmodule