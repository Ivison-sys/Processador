`timescale 1ns / 1ps

module ALUController (
    // Inputs
    input  logic [1:0] ALUOp,   // 00: LW/SW | 01: Branch | 10: R/I-type
    input  logic [6:0] Funct7,  // bits 25 to 31
    input  logic [2:0] Funct3,  // bits 12 to 14

    // Output
    output logic [3:0] Operation
);

    always_comb begin
        if (ALUOp == 2'b10) begin
            // Tipo R e I
            if ((Funct3 == 3'b000) && (Funct7 == 7'b0000000)) begin
                Operation <= 4'b0000; // ADD / ADDI
            end else if ((Funct3 == 3'b000) && (Funct7 == 7'b0100000)) begin
                Operation <= 4'b0001; // SUB
            end else if (Funct3 == 3'b100) begin
                Operation <= 4'b0010; // XOR / XORI
            end else if (Funct3 == 3'b110) begin
                Operation <= 4'b0011; // OR / ORI
            end else if (Funct3 == 3'b111) begin
                Operation <= 4'b0100; // AND / ANDI
            end else if (Funct3 == 3'b001) begin
                Operation <= 4'b0110; // SLL / SLLI
            end else if ((Funct3 == 3'b101) && (Funct7 == 7'b0000000)) begin
                Operation <= 4'b0101; // SRL / SRLI
            end else if ((Funct3 == 3'b101) && (Funct7 == 7'b0100000)) begin
                Operation <= 4'b0111; // SRA / SRAI
            end else if (Funct3 == 3'b010) begin
                Operation <= 4'b1000; // SLT / SLTI
            end else if (Funct3 == 3'b011) begin
                Operation <= 4'b1001; // SLTU / SLTIU
            end else begin
                Operation <= 4'b1111; // default
            end
        end else if (ALUOp == 2'b00) begin
            Operation <= 4'b0000; // ADD (LW/SW)
        end else if (ALUOp == 2'b01) begin
            Operation <= 4'b1010; // BEQ
        end else begin
            Operation <= 4'b1111;
        end
    end
endmodule
