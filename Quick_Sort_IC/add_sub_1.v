module add_sub_1 (in, add_sub, out);
    parameter LENGTH = 16; 
    input [LENGTH-1:0] in;
    input add_sub;
    output [LENGTH-1:0] out;

    assign out = add_sub ? in+1 : in-1;

endmodule