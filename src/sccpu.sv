`include "def.sv"

module sccpu (
    input clk, rst,
    input stall
);

    // IF

    wire pc_jmp, pc_rel;
    wire [31:0] pc_cur, pc_nxt;

    pc pc0(
        .clk(clk), .rst(rst), .stall(stall),
        .cur(pc_cur),
        .jmp(pc_jmp), .rel(pc_rel),
        .nxt(pc_nxt)
    );

    wire [31:0] instr;

    imem imem0(
        // .clk(clk), .rst(rst),
        .addr(pc_cur), .rdata(instr)
    );

    wire [6:0] opcode; wire [2:0] funct3; wire [6:0] funct7;
    wire [4:0] addr_rs1, addr_rs2, addr_rd;
    wire [4:0] imm5; wire [6:0] imm7; wire [11:0] imm12; wire [19:0] imm20;
    wire [31:0] imm_i, imm_s, imm_b, imm_u, imm_j;
    wire load, store, branch, jalr, jal, auipc, lui, op, op_imm, system;

    // ID

    dec dec0(
        .instr(instr),
        .opcode(opcode), .funct3(funct3), .funct7(funct7),
        .rs1(addr_rs1), .rs2(addr_rs2), .rd(addr_rd),
        .imm5(imm5), .imm7(imm7), .imm12(imm12), .imm20(imm20),
        .imm_i(imm_i), .imm_s(imm_s), .imm_b(imm_b), .imm_u(imm_u), .imm_j(imm_j),
        .load(load), .store(store), .branch(branch), .jalr(jalr), .jal(jal), .auipc(auipc), .lui(lui), .op_imm(op_imm), .op(op), .system(system)
    );

    wire [31:0] rf_rdata_rs1, rf_rdata_rs2;
    reg rf_wen; reg [4:0] rf_waddr; reg [31:0] rf_wdata;

    regfile rf0(
        .clk(clk), .rst(rst),
        .raddr1(addr_rs1), .raddr2(addr_rs2), .rdata1(rf_rdata_rs1), .rdata2(rf_rdata_rs2),
        .wen(rf_wen), .waddr(rf_waddr), .wdata(rf_wdata)
    );

    // EX

    wire [31:0] alu_a, alu_b, alu_t;
    assign alu_a = rf_rdata_rs1;
    assign alu_b = op_imm ? imm_i : rf_rdata_rs2;

    alu alu0(
        .op(op), .op_imm(op_imm),
        .funct3(funct3), .funct7(funct7),
        .a(alu_a), .b(alu_b), .t(alu_t)
    );

    wire branch_taken;

    branch br0(
        .branch(branch), .funct3(funct3),
        .rs1(alu_a), .rs2(alu_b),
        .taken(branch_taken)
    );

    wire [31:0] addr_br, addr_jal, addr_jalr,
                addr_br_tgt, addr_jal_tgt, addr_jalr_tgt;
    assign addr_br   = imm_b;
    assign addr_jal  = imm_j;
    assign addr_jalr = rf_rdata_rs1 + imm_i;
    assign addr_br_tgt   = pc_cur + imm_b;
    assign addr_jal_tgt  = pc_cur + imm_j;
    assign addr_jalr_tgt = rf_rdata_rs1 + imm_i;
    assign pc_jmp = branch_taken | jal | jalr;
    assign pc_rel = branch_taken | jal;
    assign pc_nxt = jal ? addr_jal
                  : branch_taken ? addr_br
                  : jalr ? addr_jalr
                  : 32'b0;
    // always_comb begin
    //     pc_nxt = 32'b0;
    //     if (branch_taken) begin
    //         pc_nxt = addr_br;
    //     end else if (jalr) begin
    //         pc_nxt = addr_jalr;
    //     end else if (jal) begin
    //         pc_nxt = addr_jal;
    //     end else begin
    //         pc_nxt = 32'b0;
    //     end
    // end

    // MEM

    wire [31:0] addr_ld, addr_st;
    assign addr_ld = rf_rdata_rs1 + imm_i;
    assign addr_st = rf_rdata_rs1 + imm_s;

    // WB

    wire [31:0] res_auipc;
    assign rf_waddr = addr_rd;
    assign res_auipc = pc_cur[31:0] + imm_u[31:0];

    always_comb begin
        rf_wen = 1;
        if (auipc) begin
            rf_wdata = res_auipc;
        end else if (jal | jalr) begin
            rf_wdata = pc_cur + 4;
        end else if (load) begin
            // rf_wdata[31:0] = dmem_data_out[31:0];
            rf_wdata = 32'b0;
        end else if (lui) begin
            rf_wdata = imm_u;
        end else if (op | op_imm) begin
            rf_wdata = alu_t;
        end else begin
            rf_wen = 0;
            rf_wdata = 32'b0;
        end
    end

endmodule