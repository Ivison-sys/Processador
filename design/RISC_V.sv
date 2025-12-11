`timescale 1ns / 1ps

module riscv #(
    parameter DATA_W = 32
) (
    input logic clk,
    input logic reset,  // clock and reset signals
    
    // Debug / Outputs visíveis
    output logic [31:0] WB_Data,  // The ALU_Result
    output logic [4:0] reg_num,
    output logic [31:0] reg_data,
    output logic reg_write_sig,
    output logic wr,
    output logic rd,
    output logic [8:0] addr,
    output logic [DATA_W-1:0] wr_data,
    output logic [DATA_W-1:0] rd_data,
    output logic Halt_Out // Output externo para indicar fim de simulação
);

  logic [6:0] opcode;
  logic ALUSrc, RegWrite, MemRead, MemWrite, Branch, Jump, Sel_jalr;
  logic [1:0] MemtoReg; // Corrigido para 2 bits
  logic [1:0] ALUop;
  logic [1:0] ALUop_Reg;
  logic [6:0] Funct7;
  logic [2:0] Funct3;
  logic [4:0] Operation;

  logic Halt_Internal; // Fio que conecta Controller -> Datapath

  // --- Conectando o Controller ---
  Controller c (
      .Opcode(opcode),
      .ALUSrc(ALUSrc),
      .MemtoReg(MemtoReg),
      .RegWrite(RegWrite),
      .MemRead(MemRead),
      .MemWrite(MemWrite),
      .ALUOp(ALUop),
      .Branch(Branch),
      .Jump(Jump),       // Ajustado para o nome correto
      .Sel_jalr(Sel_jalr), // Ajustado para o nome correto
      .Halt(Halt_Internal) // Conecta a saída do Halt
  );

  // --- Conectando o ALU Controller ---
  ALUController ac (
      .ALUOp(ALUop_Reg),
      .Funct7(Funct7),
      .Funct3(Funct3),
      .Operation(Operation)
  );

  // --- Conectando o Datapath ---
  Datapath dp (
      .clk(clk),
      .reset(reset),
      .RegWrite(RegWrite),
      .MemtoReg(MemtoReg), // Agora passa 2 bits corretamente
      .ALUSrc(ALUSrc),
      .MemWrite(MemWrite),
      .MemRead(MemRead),
      .Branch(Branch),
      .Jump(Jump),         // Passa o sinal Jump
      .Sel_jalr(Sel_jalr), // Passa o sinal Sel_jalr
      .Halt(Halt_Internal), // Passa o sinal de Halt para dentro do Datapath
      .ALUOp(ALUop),
      .Operation(Operation),
      .Opcode(opcode),
      .Funct7(Funct7),
      .Funct3(Funct3),
      .ALUOp_Current(ALUop_Reg), // Verifique se o nome no Datapath é ALUOp_Reg ou similar
      .WB_Data(WB_Data),
      .reg_num(reg_num),
      .reg_data(reg_data),
      .reg_write_sig(reg_write_sig),
      .wr(wr),
      .rd(rd),
      .addr(addr),
      .wr_data(wr_data),
      .rd_data(rd_data)
  );

  assign Halt_Out = Halt_Internal; // Joga o sinal para fora do processador

endmodule