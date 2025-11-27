`timescale 1ns / 1ps

module Controller (
    //Input
    input logic [6:0] Opcode,
    //7-bit opcode field from the instruction

    //Outputs
    output logic ALUSrc,
    //0: The second ALU operand comes from the second register file output (Read data 2); 
    //1: The second ALU operand is the sign-extended, lower 16 bits of the instruction.
    output logic [1:0] MemtoReg,
    //0: The value fed to the register Write data input comes from the ALU.
    //1: The value fed to the register Write data input comes from the data memory.
    output logic RegWrite, //The register on the Write register input is written with the value on the Write data input 
    output logic MemRead,  //Data memory contents designated by the address input are put on the Read data output
    output logic MemWrite, //Data memory contents designated by the address input are replaced by the value on the Write data input.
    output logic [1:0] ALUOp,  //00: LW/SW; 01:Branch; 10: Rtype
    output logic Branch,  //0: branch is not taken; 1: branch is taken
    output logic Jump,
    output logic Sel_jalr
);

  logic [6:0] R_TYPE, LW, SW, BR, I_TYPE, JAL, JALR;

  assign R_TYPE = 7'b0110011;  //add, and ...
  assign I_TYPE = 7'b0010011;  //addi, slti ...
  assign LW = 7'b0000011;  //lw
  assign SW = 7'b0100011;  //sw
  assign BR = 7'b1100011;  //beq, bne, blt, bge
  assign JAL = 7'b1101111;
  assign JALR = 7'b1100111;

  assign ALUSrc = (Opcode == LW || Opcode == SW || Opcode == I_TYPE || Opcode == JALR); //jalr usa a ula
  assign MemtoReg[1] = (Opcode == JAL || Opcode == JALR);
  assign MemtoReg[0] = (Opcode == LW);
  assign RegWrite = (Opcode == R_TYPE || Opcode == LW || Opcode == I_TYPE || Opcode == JAL || Opcode == JALR); //jal e jalr escrevem em registrador
  assign MemRead = (Opcode == LW);
  assign MemWrite = (Opcode == SW);
  assign ALUOp[1] = (Opcode == R_TYPE || Opcode == I_TYPE || Opcode == JAL || Opcode == JALR);
  assign ALUOp[0] = (Opcode == BR || Opcode == JAL || Opcode == JALR);
  assign Branch = (Opcode == BR);
  assign Jump = (Opcode == JAL || Opcode == JALR); // SINAL QUE DIZ SE HÁ UMA INSTRUÇÃO DE JUMP PARA O BRANCHUNIT
  assign Sel_jalr = (Opcode == JALR); //SINAL QUE DIZ SE A INSTRUÇÃO É UM JALR(CASO FOR A BRANCHUNIT DEVE ATRIBUIR O RESULTADO DA ULA AO BrPc)
endmodule