`timescale 1ns / 1ps
module tb_riscv_cpu;

reg clk;
reg reset;

riscv_cpu uut (
    .clk(clk),
    .reset(reset)
);
// Clock generation

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    // Hold reset for some time
    #10;
    reset = 0;
    // Run simulation long enough
    #105;
    $finish;
end

endmodule
