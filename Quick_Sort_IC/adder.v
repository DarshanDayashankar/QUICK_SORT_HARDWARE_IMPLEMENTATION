module adder (ADD_IN1, ADD_IN2, ADD_OUT);

    parameter LENGTH = 16;
    input [LENGTH-1:0] ADD_IN1, ADD_IN2;
    output [LENGTH-1:0] ADD_OUT;

    assign ADD_OUT = ADD_IN1 + ADD_IN2;

endmodule