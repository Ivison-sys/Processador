always_comb begin
    case (Operation)
        4'b0000:
            ALUResult = SrcA + SrcB;        // ADD
        4'b0001: 
            ALUResult = SrcA - SrcB;        // SUB
        4'b0010: 
            ALUResult = SrcA ^ SrcB;        // XOR
        4'b0011: 
            ALUResult = SrcA | SrcB;        // OR
        4'b0100: 
            ALUResult = SrcA & SrcB;        // AND
        4'b0101: 
            ALUResult = SrcA >> SrcB;       // SRL
        4'b0110: 
            ALUResult = SrcA << SrcB;       // SLL
        4'b0111: 
            ALUResult = SrcA >>> SrcB;      // SRA
        4'b1000: 
            ALUResult = ($signed(SrcA) < $signed(SrcB)) ? 1 : 0; // SLT
        4'b1001: 
            ALUResult = (SrcA < SrcB) ? 1 : 0;                   // SLTU
        4'b1010: 
            ALUResult = (SrcA == SrcB) ? 1 : 0;                  // BEQ
        default: ALUResult = 32'b0;
    endcase
end
