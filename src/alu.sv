`include "def.svh"

module alu (
    input op, op_imm,
    input [2:0] funct3,
    input [6:0] funct7,

    input  [31:0] a, b,
    output [31:0] t
);

    wire [31:0] t_alui;
    alui alui0(
        .op_imm(op_imm),
        .funct3(funct3), .funct7(funct7),
        .a(a), .b(b), .t(t_alui)
    );

    `ifdef __feature_RVM
    wire [31:0] t_alum;
    alum alum0(
        .funct3(funct3), .funct7(funct7),
        .a(a), .b(b), .t(t_alum)
    );

    assign t = op ? (funct7 == f7OpM::MULDIV) ? t_alum : t_alui
    `else
    assign t = op ? t_alui
    `endif
             : op_imm ? t_alui
             : 32'hxxxxxxxx;

endmodule

module alui (
    input op_imm,
    input [2:0] funct3,
    input [6:0] funct7,

    input [31:0] a, b,
    output reg [31:0] t
);

    always @(*) begin
        case(funct3)
            f3OpI::ADD: begin
                if(op_imm | funct7 == 7'b0) begin
                    t = a + b;
                end else if(funct7 == 7'b0100000) begin
                    t = a - b;
                end else begin
                    t = 32'bx;
                end
            end
            f3OpI::AND: begin
                t = a & b;
            end
            f3OpI::OR: begin
                t = a | b;
            end
            f3OpI::XOR: begin
                t = a ^ b;
            end
            f3OpI::SL: begin
                t = a << b;
            end
            f3OpI::SR: begin
                if(funct7 == 7'b0) begin
                    t = a >> b[4:0];
                end else if(funct7 == 7'b0100000) begin
                    t = $signed(a) >>> b[4:0];
                end else begin
                    t = 32'bx;
                end
            end
            f3OpI::SLT: begin
                t = $signed(a) < $signed(b) ? 32'b1 : 32'b0;
            end
            f3OpI::SLTU: begin
                t = a < b ? 32'b1 : 32'b0;
            end
            default: t = 32'bx;
        endcase
    end

endmodule

module alum (
    input [2:0] funct3,
    input [6:0] funct7,

    input [31:0] a, b,
    output reg [31:0] t
);

    wire [63:0] mul, mulu, mulsu;
    wire [31:0] div, divu, rem, remu;
    assign mul   = $signed(a) * $signed(b);
    assign mulu  = a * b;
    assign mulsu = $signed(a) * b;
    assign div  = $signed(a) / $signed(b);
    assign divu = a / b;
    assign rem  = $signed(a) % $signed(b);
    assign remu = a % b;

    always @(*) begin
        case(funct3)
            f3OpM::MUL: begin
                t = mul[31:0];
            end
            f3OpM::MULH: begin
                t = mul[63:32];
            end
            f3OpM::MULHSU: begin
                t = mulu[63:32];
            end
            f3OpM::MULHU: begin
                t = mulsu[63:32];
            end
            f3OpM::DIV: begin
                t = div;
            end
            f3OpM::DIVU: begin
                t = divu;
            end
            f3OpM::REM: begin
                t = rem;
            end
            f3OpM::REMU: begin
                t = remu;
            end
            default: t = 32'hxxxxxxxx;
        endcase
    end

endmodule
