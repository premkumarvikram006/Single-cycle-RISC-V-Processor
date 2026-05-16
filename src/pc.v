`timescale 1ns / 1ps
module pc(clk, reset, next_pc, pc_out);
    //declare inputs
    input clk, reset;
    input [31:0] next_pc;
    //declare outputs
    output reg [31:0] pc_out;
    //update program counter on clock edge or reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc_out<= 0;
        else
            pc_out<= next_pc;
    end

endmodule
