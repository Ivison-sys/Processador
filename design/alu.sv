`timescale 1ns / 1ps

module alu#(
        parameter DATA_WIDTH = 32,
        parameter OPCODE_LENGTH = 5
        )
        (
        input logic [DATA_WIDTH-1:0]    SrcA,
        input logic [DATA_WIDTH-1:0]    SrcB,

        input logic [OPCODE_LENGTH-1:0]    Operation,
        output logic[DATA_WIDTH-1:0] ALUResult
        );
    
        always_comb begin
        case(Operation)
        5'b00000: // ADD, JALR 
            ALUResult = SrcA + SrcB;
        5'b00001: // SUB
            ALUResult = SrcA - SrcB;
        5'b00010: // XOR   
            ALUResult = SrcA ^ SrcB;
        5'b00011: // OR
            ALUResult = SrcA | SrcB;
        5'b00100: // AND
            ALUResult = SrcA & SrcB;
        5'b00101: // srl
            ALUResult = SrcA >> SrcB[4:0]; 
        5'b00110: // sll
            ALUResult = SrcA << SrcB[4:0]; 
        5'b00111: //sra
            ALUResult = $signed(SrcA) >>> SrcB[4:0]; 
        5'b01000: //slt
            ALUResult = ($signed(SrcA) < $signed(SrcB)) ? 1 : 0; 
        5'b01001: //sltu
            ALUResult = (SrcA < SrcB) ? 1 : 0;
        5'b01010: // Equal(BEQ)
            ALUResult = (SrcA == SrcB) ? 1 : 0;
        5'b01011: // BNE
            ALUResult = (SrcA != SrcB) ? 1 : 0;
        5'b01100: // BGE 
           ALUResult = (SrcA >= SrcB) ? 1 : 0;
        5'b01101: // BLT
            ALUResult = (SrcA < SrcB) ? 1 : 0;
        default:
            ALUResult = 0;
        endcase
    end
endmodule