`timescale 1ns / 1ps

module alu#(
        parameter DATA_WIDTH = 32,
        parameter OPCODE_LENGTH = 4
        )
        (
        input logic [DATA_WIDTH-1:0]    SrcA,
        input logic [DATA_WIDTH-1:0]    SrcB,

        input logic [OPCODE_LENGTH-1:0]    Operation,
        output logic[DATA_WIDTH-1:0] ALUResult
        );
    
        always_comb begin
          
        end
        begin 
            case(Operation)
            4'b0000: // ADD
                ALUResult = SrcA + SrcB;
            4'b0001: // SUB
                ALUResult = SrcA - SrcB;
            4'b0010: // XOR   
                ALUResult = SrcA ^ SrcB;
            4'b0011: // OR
                ALUResult = SrcA | SrcB;
            4'b0100: // AND
                ALUResult = SrcA & SrcB;
            4'b0101: // srl
                ALUResult = SrcA >> SrcB;
            4'b0110: // sll
                ALUResult = SrcA << SrcB;
            4'b0111: //sra
                ALUResult = SrcA >>> SrcB;
            4'b1000: //slt
                ALUResult = ($signed(SrcA) < $signed(SrcB)) ? 1 : 0; 
            4'b1001: //sltu
                ALUResult = (SrcA < SrcB) ? 1 : 0;
            4'b1010: // Equal(BEQ)
                ALUResult = (SrcA == SrcB) ? 1 : 0;
            default:
                ALUResult = 1;
            endcase
        end
endmodule

