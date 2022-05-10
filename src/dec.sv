`include "def.sv"

module dec (
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [4:0] imm5,
    input [6:0] imm7,
    input [11:0] imm12,
    input [19:0] imm20,
    output [31:0] imm_i,
    output [31:0] imm_s,
    output [31:0] imm_b,
    output [31:0] imm_u,
    output [31:0] imm_j,
    output load,
    output store,
    output branch,
    output jalr,
    output jal,
    output lui,
    output auipc,
    output op_imm,
    output op,
    output system
);

    wire sopcode[4:0];
    assign sopcode[4:0] = opcode[6:2];
    assign load   = sopcode[4:0] == 5'b00000 ? 1 : 0;
    assign store  = sopcode[4:0] == 5'b01000 ? 1 : 0;
    assign branch = sopcode[4:0] == 5'b11000 ? 1 : 0;
    assign jalr   = sopcode[4:0] == 5'b11001 ? 1 : 0; 
    assign jal    = sopcode[4:0] == 5'b11011 ? 1 : 0;
    assign lui    = sopcode[4:0] == 5'b01101 ? 1 : 0;
    assign auipc  = sopcode[4:0] == 5'b00101 ? 1 : 0;
    assign op_imm = sopcode[4:0] == 5'b00100 ? 1 : 0;
    assign op     = sopcode[4:0] == 5'b01100 ? 1 : 0;
    assign system = sopcode[4:0] == 5'b11100 ? 1 : 0;
    // TODO: move sopcode to def?

    /*
    assign imm_i[31:0] = { { 20{imm12[11]} }, imm12 };
    assign imm_s[31:0] = { { 20{imm7[6]} }, imm7, imm5 };
    assign imm_b[31:0] = { { 20{imm7[6]} }, imm5[0], imm7[5:0], imm5[4:1], 1'b0 };
    assign imm_u[31:0] = { imm20, 12'b0 };
    assign imm_j[31:0] = { { 12{imm20[19]} }, imm20[7:0], imm20[8], imm20[18:9], 1'b0 };
    */
    assign imm_i[31:0] = { { 20{imm12[11]} }, imm12[11:5], imm12[4:1], imm12[0] };
    assign imm_s[31:0] = { { 20{imm7[6]} }, imm7[6], imm7[5:0], imm5[4:1], imm5[0] };
    assign imm_b[31:0] = { { 19{imm7[6]} }, imm7[6], imm5[0], imm7[5:0], imm5[4:1], 1'b0 };
    assign imm_u[31:0] = { imm20[19], imm20[18:9], imm20[8], imm20[7:0], 12'b0 };
    assign imm_j[31:0] = { { 12{imm20[19]} }, imm20[19], imm20[7:0], imm20[8], imm20[18:9], 1'b0 };
    // Does this really provide any benifit?
    // Maybe during synthesize?
    // Reminds me of LTO somehow...

endmodule
