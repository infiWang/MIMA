`include "def.sv"

module instr (
    input wire [31:0] instr,
    output wire [6:0] opcode,
    output wire [2:0] funct3,
    output wire [6:0] funct7,
    output wire [4:0] rs1,
    output wire [4:0] rs2,
    output wire [4:0] rd,
    output wire [4:0] imm5,
    output wire [11:0] imm12,
    output wire [19:0] imm20
);

    assign opcode[6:0] = instr[6:0];
    assign funct3[2:0] = instr[14:12];
    assign funct7[6:0] = instr[31:25];
    assign rs1[4:0]    = instr[19:15];
    assign rs2[4:0]    = instr[24:20];
    assign rd[4:0]     = instr[11:7];
    assign imm5[4:0]   = instr[11:7];
    assign imm12[11:0] = instr[31:20];
    assign imm20[19:0] = instr[31:12];

endmodule
