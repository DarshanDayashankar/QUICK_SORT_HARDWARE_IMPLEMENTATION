module counter(clk, reset, count);
    input clk, reset;
    output reg [4:0] count;

    always @ (posedge clk)
    begin
    //$display("reset = %d", reset);
        if(reset == 1) count = 0;
        else count = count + 1;
    end 

endmodule