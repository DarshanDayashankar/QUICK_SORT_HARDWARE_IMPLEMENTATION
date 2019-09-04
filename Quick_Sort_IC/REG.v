module REG (clk, addr, out, in, READ_EN, WRITE_EN);
    parameter WORD_SIZE = 16;

    input [WORD_SIZE-1:0] addr, in;
    input READ_EN, WRITE_EN, clk;
    output reg [WORD_SIZE-1:0] out;

    reg [WORD_SIZE-1:0] REG_FILE [0:4095];

    always  @(negedge clk) 
    begin
        if (WRITE_EN==1) begin
        REG_FILE[addr] <= in;
        //$display("Write %d at %d", in, addr);
        end
        else if (READ_EN==1) begin
        out <= REG_FILE[addr];
        //$display("Read %d at %d", REG_FILE[addr], addr);
        end
    end

endmodule