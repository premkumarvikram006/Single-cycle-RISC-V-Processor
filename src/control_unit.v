`timescale 1ns / 1ps
module control_unit(

    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,

    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg alu_src,
    output reg branch,
    output reg jump,
    output reg mem_to_reg,
    output reg pc_to_reg,
    output reg [3:0] alu_control,
    output reg [2:0] imm_sel
);

always @(*) begin  
    // DEFAULT VALUES
    reg_write  = 1'b0;
    mem_read   = 1'b0;
    mem_write  = 1'b0;
    alu_src    = 1'b0;
    branch     = 1'b0;
    jump       = 1'b0;
    mem_to_reg = 1'b0;
    pc_to_reg  = 1'b0;
    alu_control = 4'b0000;
    imm_sel     = 3'b000;
    case(opcode)
        // R-TYPE INSTRUCTIONS
        // ADD, SUB, AND, XOR
        7'b0110011: begin
            reg_write = 1'b1;
            alu_src   = 1'b0;
            case(funct3)
                // ADD / SUB
                3'b000: begin
                    if(funct7 == 7'b0000000)
                        alu_control = 4'b0000; // ADD
                    else if(funct7 == 7'b0100000)
                        alu_control = 4'b0001; // SUB
                end
                // XOR
                3'b100: begin
                    alu_control = 4'b1001;
                end
                // AND
                3'b111: begin
                    alu_control = 4'b1000;
                end
                default: begin
                    alu_control = 4'b0000;
                end
            endcase
        end

        // ADDI    
        7'b0010011: begin
            reg_write = 1'b1;
            alu_src   = 1'b1;
            alu_control = 4'b0010;
            // I-TYPE
            imm_sel = 3'b000;
        end
        
        // LW
        7'b0000011: begin
            reg_write = 1'b1;
            mem_read  = 1'b1;
            alu_src   = 1'b1;
            mem_to_reg = 1'b1;
            alu_control = 4'b0011;

            // I-TYPE
            imm_sel = 3'b000;
        end
        
        // SW
        7'b0100011: begin
            mem_write = 1'b1;
            alu_src   = 1'b1;
            alu_control = 4'b0100;
            // S-TYPE
            imm_sel = 3'b001;
        end
        // BEQ
        7'b1100011: begin
            branch = 1'b1;
            alu_control = 4'b0101;
            // B-TYPE
            imm_sel = 3'b010;
        end
        // JAL
        7'b1101111: begin
            jump      = 1'b1;
            reg_write = 1'b1;
            alu_src   = 1'b1;
            pc_to_reg = 1'b1;
            alu_control = 4'b0110;
            // J-TYPE
            imm_sel = 3'b100;
        end
        // LUI
        7'b0110111: begin
            reg_write = 1'b1;
            alu_src   = 1'b1;
            alu_control = 4'b0111;
            // U-TYPE
            imm_sel = 3'b011;
        end
        // DEFAULT
        default: begin
            reg_write  = 1'b0;
            mem_read   = 1'b0;
            mem_write  = 1'b0;
            alu_src    = 1'b0;
            branch     = 1'b0;
            jump       = 1'b0;
            mem_to_reg = 1'b0;
            alu_control = 4'b0000;
            imm_sel     = 3'b000;
        end
    endcase
end

endmodule
