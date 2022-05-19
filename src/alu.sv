`include "def.sv"

module alu (
    input op,
    input op_imm,
    input [2:0] funct3,
    input [6:0] funct7,

    input [31:0] a,
    input [31:0] b,
    output reg [31:0] t
);

    always_comb begin
        if(op | op_imm) begin
            case(funct3)
                f3OpInt::ADD: begin
                    if(op_imm | funct7 == 7'b0) begin
                        t = a + b;
                    end else if(funct7 == 7'b0100000) begin
                        t = a - b;
                    end else begin
                        t = 32'bx;
                    end
                end
                f3OpInt::AND: begin
                    t = a & b;
                end
                f3OpInt::OR: begin
                    t = a | b;
                end
                f3OpInt::XOR: begin
                    t = a ^ b;
                end
                f3OpInt::SL: begin
                    t = a << b;
                end
                f3OpInt::SR: begin
                    if(funct7 == 7'b0) begin
                        t = a >> b[4:0];
                    end else if(funct7 == 7'b0100000) begin
                        t = $signed(a) >>> b[4:0];
                    end else begin
                        t = 32'bx;
                    end
                end
                f3OpInt::SLT: begin
                    t = $signed(a) < $signed(b) ? 32'b1 : 32'b0;
                end
                f3OpInt::SLTU: begin
                    t = a < b ? 32'b1 : 32'b0;
                end
                default: t = 32'bx;
            endcase
        end else begin
            t = 32'bx;
        end
    end

endmodule