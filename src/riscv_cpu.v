`timescale 1ns / 1ps
module riscv_cpu(
    input clk,
    input reset
);
// PC signals
wire [31:0] pc_current;
wire [31:0] pc_next;
wire [31:0] pc_plus_4;
// Instruction signals
wire [31:0] instruction;
// Decoder signals
wire [6:0] opcode;
wire [4:0] rd;
wire [2:0] funct3;
wire [4:0] rs1;
wire [4:0] rs2;
wire [6:0] funct7;
// Control signals
wire reg_write;
wire mem_read;
wire mem_write;
wire alu_src;
wire branch;
wire jump;
wire mem_to_reg;
wire pc_to_reg;
wire [3:0] alu_control;
wire [2:0] imm_sel;
// Register file signals
wire [31:0] read_data1;
wire [31:0] read_data2;
wire [31:0] write_back_data;
// Immediate generator signals
wire [31:0] immediate;
// ALU signals
wire [31:0] alu_operand_b;
wire [31:0] alu_result;
wire zero;
// Data memory signals
wire [31:0] memory_read_data;

// Program counter
pc pc_inst (
    .clk(clk),
    .reset(reset),
    .next_pc(pc_next),
    .pc_out(pc_current)
);
assign pc_plus_4 = pc_current + 4;
// Instruction memory
instruction_memory instruction_memory_inst (
    .addr(pc_current),
    .instruction(instruction)
);

// Instruction decoder
instruction_decoder decoder_inst (
    .instruction(instruction),
    .opcode(opcode),
    .rd(rd),
    .funct3(funct3),
    .rs1(rs1),
    .rs2(rs2),
    .funct7(funct7)
);

// Control unit
control_unit control_unit_inst (
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),
    .reg_write(reg_write),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .alu_src(alu_src),
    .branch(branch),
    .jump(jump),
    .mem_to_reg(mem_to_reg),
    .pc_to_reg(pc_to_reg),
    .alu_control(alu_control),
    .imm_sel(imm_sel)
);

// Register file
register_file register_file_inst (
    .clk(clk),
    .reset(reset),
    .rs1(rs1),
    .rs2(rs2),
    .rd1(read_data1),
    .rd2(read_data2),
    .reg_write(reg_write),
    .rd(rd),
    .write_data(write_back_data)
);

// Immediate generator
immediate_generator immediate_generator_inst (
    .instruction(instruction),
    .imm_sel(imm_sel),
    .immediate(immediate)
);

// ALU operand mux
assign alu_operand_b =
    (alu_src) ? immediate : read_data2;
// ALU
alu alu_inst (
    .operand_a(read_data1),
    .operand_b(alu_operand_b),
    .alu_control(alu_control),
    .result(alu_result),
    .zero(zero)
);

// Data memory
data_memory data_memory_inst (
    .clk(clk),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .address(alu_result),
    .write_data(read_data2),
    .read_data(memory_read_data)
);

// Writeback mux
assign write_back_data =
    (pc_to_reg) ? pc_plus_4 :
    (mem_to_reg) ? memory_read_data :
    alu_result;
// Next PC logic
assign pc_next =
    (jump) ?
    (pc_current + immediate) :
    (branch && zero) ?
    (pc_current + immediate) :
    (pc_current + 4);

endmodule
