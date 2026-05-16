`timescale 1ns / 1ps
module alu(
    input [31:0] operand_a,
    input [31:0] operand_b,

    input [3:0] alu_control,

    output reg [31:0] result,
    output reg zero
);

always @(*) begin

    // default outputs
    result = 32'b0;
    zero  = 1'b0;

    case(alu_control)

        // ADD
        4'b0000: begin
            result = operand_a + operand_b;
        end

        // SUB
        4'b0001: begin
            result = operand_a - operand_b;
        end

        // ADDI
        4'b0010: begin
            result = operand_a + operand_b;
        end

        // LW address calculation
        4'b0011: begin
            result = operand_a + operand_b;
        end

        // SW address calculation
        4'b0100: begin
            result = operand_a + operand_b;
        end

        // BEQ comparison
        4'b0101: begin

            if(operand_a == operand_b)
                zero = 1'b1;
            else
                zero = 1'b0;

        end

        // JAL target calculation
        4'b0110: begin
            result = operand_a + operand_b;
        end

        // LUI
        4'b0111: begin
            result = operand_b;
        end

        // AND
        4'b1000: begin
            result = operand_a & operand_b;
        end

        // XOR
        4'b1001: begin
            result = operand_a ^ operand_b;
        end

        default: begin
            result = 32'b0;
            zero  = 1'b0;
        end
    endcase
end

endmodule
