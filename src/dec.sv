`include "def.sv"

module dec (
    input [31:0] instr,
    output [6:0] opcode,
    output [2:0] funct3,
    output [6:0] funct7,
    output [4:0] rs1,
    output [4:0] rs2,
    output [4:0] rd,
    output [4:0] imm5,
    output [6:0] imm7,
    output [11:0] imm12,
    output [19:0] imm20,
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

    assign opcode[6:0] = instr[6:0];
    assign funct3[2:0] = instr[14:12];
    assign funct7[6:0] = instr[31:25];
    assign rs1[4:0]    = instr[19:15];
    assign rs2[4:0]    = instr[24:20];
    assign rd[4:0]     = instr[11:7];
    assign imm5[4:0]   = instr[11:7];
    assign imm7[6:0]   = instr[31:25];
    assign imm12[11:0] = instr[31:20];
    assign imm20[19:0] = instr[31:12];

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

    wire [4:0] sopcode;
    assign sopcode[4:0] = opcode[6:2];
    assign load   = sopcode[4:0] == gopcode::LOAD   ? 1 : 0;
    assign store  = sopcode[4:0] == gopcode::STORE  ? 1 : 0;
    assign branch = sopcode[4:0] == gopcode::BRANCH ? 1 : 0;
    assign jalr   = sopcode[4:0] == gopcode::JALR   ? 1 : 0;
    assign jal    = sopcode[4:0] == gopcode::JAL    ? 1 : 0;
    assign lui    = sopcode[4:0] == gopcode::LUI    ? 1 : 0;
    assign auipc  = sopcode[4:0] == gopcode::AUIPC  ? 1 : 0;
    assign op_imm = sopcode[4:0] == gopcode::OP_IMM ? 1 : 0;
    assign op     = sopcode[4:0] == gopcode::OP     ? 1 : 0;
    assign system = sopcode[4:0] == gopcode::SYSTEM ? 1 : 0;

endmodule
