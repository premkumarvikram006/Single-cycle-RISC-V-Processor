`timescale 1ns / 1ps
module immediate_generator(

    input [31:0] instruction,
    input [2:0] imm_sel,

    output reg [31:0] immediate
);

always @(*) begin

    case(imm_sel)

        // I-TYPE
        3'b000: begin
            immediate = {
                {20{instruction[31]}},
                instruction[31:20]
            };
        end

        // S-TYPE
        3'b001: begin
            immediate = {
                {20{instruction[31]}},
                instruction[31:25],
                instruction[11:7]
            };
        end

        // B-TYPE
        3'b010: begin
            immediate = {
                {19{instruction[31]}},
                instruction[31],
                instruction[7],
                instruction[30:25],
                instruction[11:8],
                1'b0
            };
        end

        // U-TYPE
        3'b011: begin
            immediate = {
                instruction[31:12],
                12'b0
            };
        end

        // J-TYPE
        3'b100: begin
            immediate = {
                {11{instruction[31]}},
                instruction[31],
                instruction[19:12],
                instruction[20],
                instruction[30:21],
                1'b0
            };
        end

        default: begin
            immediate = 32'b0;
        end

    endcase

end

endmodule
