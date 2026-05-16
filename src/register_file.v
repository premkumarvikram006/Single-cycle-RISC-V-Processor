`timescale 1ns / 1ps
module register_file(

    input clk,
    input reset,

    // READ PORTS
    input [4:0] rs1,
    input [4:0] rs2,

    output [31:0] rd1,
    output [31:0] rd2,

    // WRITE PORT
    input reg_write,
    input [4:0] rd,
    input [31:0] write_data
);

reg [31:0] registers [0:31];

integer i;

// READ PORTS
assign rd1 = (rs1 == 0) ? 32'b0 : registers[rs1];
assign rd2 = (rs2 == 0) ? 32'b0 : registers[rs2];

// WRITE PORT
always @(posedge clk or posedge reset) begin

    if(reset) begin
        for(i = 0; i < 32; i = i + 1)
            registers[i] <= 0;
    end

    else if(reg_write && rd != 0) begin
        registers[rd] <= write_data;
    end

end

endmodule
