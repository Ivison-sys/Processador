`timescale 1ns / 1ps

module ALUController (
    //Inputs
    input logic [1:0] ALUOp,  // 2-bit opcode field from the Controller--00: LW/SW/AUIPC; 01:Branch; 10: Rtype/Itype; 11:JAL/LUI
    input logic [6:0] Funct7,  // bits 25 to 31 of the instruction
    input logic [2:0] Funct3,  // bits 12 to 14 of the instruction

    //Output
    output logic [3:0] Operation  // operation selection for ALU
);

    always_comb begin
        if (ALUOp == 2'b10) begin //Tipo R
            if((Funct3 == 3'b000) && (Funct7 == 7'b0000000)) begin
                Operation <= 4'b0000; // ADD
            end else if((Funct3 == 3'b000) && (Funct7 == 7'b0100000)) begin 
                Operation <= 4'b0001; // SUB
            end else if((Funct3 == 3'b100) && (Funct7 == 7'b0000000)) begin 
                Operation <= 4'b0010; // XOR
            end else if((Funct3 == 3'b110) && (Funct7 == 7'b0000000)) begin 
                Operation <= 4'b0011; // OR
            end else if((Funct3 == 3'b111) && (Funct7 == 7'b0000000)) begin 
                Operation <= 4'b0100; // AND
            end else if((Funct3 == 3'b101) && (Funct7 == 7'b0000000)) begin 
                Operation <= 4'b0101; // srl
            end else if((Funct3 == 3'b001) && (Funct7 == 7'b0000000)) begin
                Operation <= 4'b0110; //sll  
            end else if((Funct3 == 3'b101) && (Funct7 == 7'b0100000)) begin
                Operation <= 4'b0111; //sra
            end else if((Funct3 == 3'b010) && (Funct7 == 7'b0000000)) begin
                Operation <= 4'b1000; //slt
            end else if((Funct3 == 3'b011) && (Funct7 == 7'b0000000)) begin
                Operation <= 4'b1001; //sltu
            end
        end else if (ALUOp == 2'b00) begin
            Operation <= 4'b0000; //Recebe o codigo do add. ULA calcula o endereco de mem. para lw/sw
        end else if (ALUOp == 2'b01) begin
            Operation <= 4'b1010; //BEQ
        end
    end
    
    
    
    
    
    
    
    // always_comb begin
    //     if((ALUOp == 2'b10) && (Funct3 == 3'b000) && (Funct7 == 7'b0000000)) begin
    //         Operation <= 0000; // ADD
    //     end else if((ALUOp == 2'b10) && (Funct3 == 3'b000) && (Funct7 == 7'b0100000)) begin 
    //         Operation <= 0001; // SUB
    //     end else if((ALUOp == 2'b10) && (Funct3 == 3'b100) && (Funct7 == 7'b0000000)) begin 
    //         Operation <= 0010; // XOR
    //     end else if((ALUOp == 2'b10) && (Funct3 == 3'b110) && (Funct7 == 7'b0000000)) begin 
    //         Operation <= 0011; // OR
    //     end else if((ALUOp == 2'b10) && (Funct3 == 3'b111) && (Funct7 == 7'b0000000)) begin 
    //         Operation <= 0100; // AND
    //     end else if((ALUOp == 2'b10) && (Funct3 == 3'b101)) begin 
    //         Operation <= 0101; // srl
    //     end else if((ALUOp == 2'b10) && (Funct3 == 3'b001) && (Funct7 == 7'b0000000)) begin
    //         Operation <= 0110; //sll
    //     end else if((ALUOp == 2'b))
    // end


//   assign Operation[0] = ((ALUOp == 2'b10) && (Funct3 == 3'b110)) ||  // R\I-or
//       ((ALUOp == 2'b10) && (Funct3 == 3'b101) && (Funct7 == 7'b0000000)) ||  // R\I->>
//       ((ALUOp == 2'b10) && (Funct3 == 3'b101) && (Funct7 == 7'b0100000));  // R\I->>>

//   assign Operation[1] = (ALUOp == 2'b00) ||  // LW\SW
//       ((ALUOp == 2'b10) && (Funct3 == 3'b000)) ||  // R\I-add
//       ((ALUOp == 2'b10) && (Funct3 == 3'b101) && (Funct7 == 7'b0100000));  // R\I->>>

//   assign Operation[2] =  ((ALUOp==2'b10) && (Funct3==3'b101) && (Funct7==7'b0000000)) || // R\I->>
//       ((ALUOp == 2'b10) && (Funct3 == 3'b101) && (Funct7 == 7'b0100000)) ||  // R\I->>>
//       ((ALUOp == 2'b10) && (Funct3 == 3'b001)) ||  // R\I-<<
//       ((ALUOp == 2'b10) && (Funct3 == 3'b010));  // R\I-<

//   assign Operation[3] = (ALUOp == 2'b01) ||  // BEQ
//       ((ALUOp == 2'b10) && (Funct3 == 3'b010));  // R\I-<
endmodule
