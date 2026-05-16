# RV32I Single-Cycle RISC-V Processor

## Overview

This project implements a 32-bit single-cycle RISC-V processor in Verilog based on a subset of the RV32I ISA. The processor supports arithmetic, logical, memory, branch, and jump instructions and demonstrates the complete instruction execution flow including fetch, decode, execute, memory access, and writeback.

---

## Features

- 32-bit RV32I single-cycle CPU
- Modular Verilog design
- Harvard architecture
- Dual-read single-write register file
- Arithmetic and logical ALU
- Immediate generation for multiple instruction formats
- Branch and jump support
- Memory read/write operations
- Waveform verified execution

---

## Supported Instructions

| Category | Instructions |
|---|---|
| Arithmetic | ADD, SUB, ADDI |
| Logical | AND, XOR |
| Memory | LW, SW |
| Branch | BEQ |
| Jump | JAL |
| Immediate | LUI |

---

## Datapath Flow

```text
PC
↓
Instruction Memory
↓
Instruction Decoder
↓
Control Unit
↓
Register File
↓
Immediate Generator
↓
ALU
↓
Data Memory
↓
Writeback
```

---

## Modules

- pc.v – Program Counter
- instruction_memory.v – Instruction Memory
- instruction_decoder.v – Instruction Decoder
- control_unit.v – Control Signal Generation
- register_file.v – Register File
- immediate_generator.v – Immediate Generator
- alu.v – Arithmetic Logic Unit
- data_memory.v – Data Memory
- riscv_cpu.v – Top-Level CPU
- tb_riscv_cpu.v – Testbench

---

## Example Program

```assembly
ADDI x1, x0, 5
ADDI x2, x0, 10
ADD  x3, x1, x2
SUB  x4, x2, x1
AND  x5, x1, x2
XOR  x6, x1, x2
SW   x3, 0(x0)
LW   x9, 0(x0)
BEQ  x1, x2, label
LUI  x10, 0x12345
JAL  x0, target
```

---

## Simulation Steps

1. Add all Verilog files to Vivado/ModelSim:
   - pc.v
   - instruction_memory.v
   - instruction_decoder.v
   - control_unit.v
   - register_file.v
   - immediate_generator.v
   - alu.v
   - data_memory.v
   - riscv_cpu.v
   - tb_riscv_cpu.v

2. Add `program.mem` to simulation sources.

3. Set `tb_riscv_cpu.v` as the top module.

4. Run simulation.

5. Add these signals to waveform:
   - pc_current
   - instruction
   - opcode
   - reg_write
   - alu_control
   - read_data1
   - read_data2
   - immediate
   - alu_result
   - write_back_data

---

## Expected Results

| Instruction | Expected Result |
|---|---|
| ADDI | x1 = 5, x2 = 10 |
| ADD | x3 = 15 |
| SUB | x4 = 5 |
| AND | x5 = 0 |
| XOR | x6 = 15 |
| SW | memory[0] = 15 |
| LW | x9 = 15 |
| BEQ | branch not taken |
| LUI | x10 = 0x12345000 |
| JAL | PC jumps correctly |

---

## Tools Used

- Verilog HDL
- Vivado Simulator
- GTKWave

---

## Future Improvements

- Pipelined CPU
- Hazard detection and forwarding
- Cache memory
- FPGA implementation
- UART support
- AI accelerator integration
- MNIST/CNN hardware accelerator

---

## Conclusion

This project demonstrates the complete implementation of a modular RV32I single-cycle RISC-V processor in Verilog with support for arithmetic, logical, memory, branch, and jump instructions. The processor was successfully verified through simulation and waveform analysis.
