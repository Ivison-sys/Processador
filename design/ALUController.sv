`timescale 1ns / 1ps

module ALUController (
    // Inputs
    input  logic [1:0] ALUOp,   // 00: LW/SW | 01: Branch | 10: R/I-type
    input  logic [6:0] Funct7,  // bits 25 to 31
    input  logic [2:0] Funct3,  // bits 12 to 14

    // Output
    output logic [4:0] Operation
);

   always_comb begin
    if (ALUOp == 2'b10) begin
        // Tipo R e I
        if (Funct3 == 3'b000) begin // ADD, ADDI, SUB
            if (Funct7 == 7'b0100000) begin
                Operation <= 5'b00001; // SUB
            end else begin
                Operation <= 5'b00000; // ADD / ADDI
            end
        end else if (Funct3 == 3'b100) begin
            Operation <= 5'b00010; // XOR / XORI
        end else if (Funct3 == 3'b110) begin
            Operation <= 5'b00011; // OR / ORI
        end else if (Funct3 == 3'b111) begin
            Operation <= 5'b00100; // AND / ANDI
        end else if (Funct3 == 3'b001) begin
            Operation <= 5'b00110; // SLL / SLLI
        end else if ((Funct3 == 3'b101) && (Funct7 == 7'b0000000)) begin
            Operation <= 5'b00101; // SRL / SRLI
        end else if ((Funct3 == 3'b101) && (Funct7 == 7'b0100000)) begin
            Operation <= 5'b00111; // SRA / SRAI
        end else if (Funct3 == 3'b010) begin
            Operation <= 5'b01000; // SLT / SLTI
        end else if (Funct3 == 3'b011) begin
            Operation <= 5'b01001; // SLTU / SLTIU
        end else begin
            Operation <= 5'b01111; // default
        end
    end else if (ALUOp == 2'b00) begin
        Operation <= 5'b00000; // ADD (LW/SW)
    end else if (ALUOp == 2'b01) begin
        if(Funct3 == 3'b000) begin
            Operation <= 5'b01010; // BEQ
        end else if(Funct3 == 3'b001) begin
            Operation <= 5'b01011; // BNE
        end else if(Funct3 == 3'b101) begin
            Operation <= 5'b01100; // BGE
        end else if(Funct3 == 3'b100) begin
            Operation <= 5'b01101; // BLT
        end else begin
            Operation <= 5'b01111; // DEFAULT
        end
    end else begin
        Operation <= 5'b00000; //aluop == 11, significa instrucao de jump. ULA vai calcular o endereço de retorno.
    end
end
endmodule