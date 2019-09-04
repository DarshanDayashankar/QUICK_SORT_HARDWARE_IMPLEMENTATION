module register (CLK, RESET, WRITE_EN, REG_IN, REG_OUT);
    parameter WORD_SIZE = 16;
    
    input CLK, RESET, WRITE_EN;
    input [WORD_SIZE-1:0] REG_IN;
    output reg [WORD_SIZE-1:0] REG_OUT;

    always @(negedge CLK) begin
        if(RESET==1) REG_OUT <= 0;
        else if(WRITE_EN==1) REG_OUT <= REG_IN;
    end    
endmodule