`include "def.svh"
`timescale 1ns/1ns

module alu_tb();

    localparam period = 1;

    reg unsigned [31:0] a;
    reg unsigned [31:0] b;
    reg [2:0] funct3;
    reg [6:0] funct7;
    reg op;
    reg op_imm;
    
    wire [31:0] t;

    alu alut (
        .op(op), .op_imm(op_imm),
        .funct3(funct3), .funct7(funct7),
        .a(a), .b(b),
        .t(t)
    );

    initial begin

        // Invalid

        a      = 998244353;
        b      = 10000007;
        op     = 0;
        op_imm = 0;

        funct3 = f3OpI::ADD;
        funct7 = 7'b0000000;
        #period;
        funct7 = 7'b0100000;
        #period;
        funct7 = 7'b0000000;

        funct3 = f3OpI::SL;
        #period;

        funct3 = f3OpI::SLT;
        #period;

        funct3 = f3OpI::SLTU;
        #period;

        funct3 = f3OpI::XOR;
        #period;

        funct3 = f3OpI::SR;
        funct7 = 7'b0000000;
        #period;
        funct7 = 7'b0100000;
        #period;
        funct7 = 7'b0000000;

        funct3 = f3OpI::OR;
        #period;

        funct3 = f3OpI::AND;
        #period;

        // Register

        a      = 20;
        b      = 7;
        op     = 1;
        op_imm = 0;

        funct3 = f3OpI::ADD;
        funct7 = 7'b0000000;
        #period;
        funct7 = 7'b0100000;
        #period;
        funct7 = 7'b0000000;

        funct3 = f3OpI::SL;
        #period;

        funct3 = f3OpI::SLT;
        #period;

        funct3 = f3OpI::SLTU;
        #period;

        funct3 = f3OpI::XOR;
        #period;

        funct3 = f3OpI::SR;
        funct7 = 7'b0000000;
        #period;
        funct7 = 7'b0100000;
        #period;
        funct7 = 7'b0000000;

        funct3 = f3OpI::OR;
        #period;

        funct3 = f3OpI::AND;
        #period;

        a      = -100;
        b      = 4;
        op     = 1;
        op_imm = 0;

        funct3 = f3OpI::ADD;
        funct7 = 7'b0000000;
        #period;
        funct7 = 7'b0100000;
        #period;
        funct7 = 7'b0000000;

        funct3 = f3OpI::SL;
        #period;

        funct3 = f3OpI::SLT;
        #period;

        funct3 = f3OpI::SLTU;
        #period;

        funct3 = f3OpI::XOR;
        #period;

        funct3 = f3OpI::SR;
        funct7 = 7'b0000000;
        #period;
        funct7 = 7'b0100000;
        #period;
        funct7 = 7'b0000000;

        funct3 = f3OpI::OR;
        #period;

        funct3 = f3OpI::AND;
        #period;

        a      = 10000000;
        b      = -10000000;
        op     = 1;
        op_imm = 0;

        funct3 = f3OpI::ADD;
        funct7 = 7'b0000000;
        #period;
        funct7 = 7'b0100000;
        #period;
        funct7 = 7'b0000000;

        funct3 = f3OpI::SL;
        #period;

        funct3 = f3OpI::SLT;
        #period;

        funct3 = f3OpI::SLTU;
        #period;

        funct3 = f3OpI::XOR;
        #period;

        funct3 = f3OpI::SR;
        funct7 = 7'b0000000;
        #period;
        funct7 = 7'b0100000;
        #period;
        funct7 = 7'b0000000;

        funct3 = f3OpI::OR;
        #period;

        funct3 = f3OpI::AND;
        #period;

        // Immediate

        a      = 32'h20001000;
        b      = 32'h504;
        op     = 0;
        op_imm = 1;

        funct3 = f3OpI::ADD;
        funct7 = 7'b0000000;
        #period;
        funct7 = 7'b0100000;
        #period;
        funct7 = 7'b0000000;

        funct3 = f3OpI::SL;
        #period;

        funct3 = f3OpI::SLT;
        #period;

        funct3 = f3OpI::SLTU;
        #period;

        funct3 = f3OpI::XOR;
        #period;

        funct3 = f3OpI::SR;
        funct7 = 7'b0000000;
        #period;
        funct7 = 7'b0100000;
        #period;
        funct7 = 7'b0000000;

        funct3 = f3OpI::OR;
        #period;

        funct3 = f3OpI::AND;
        #period;


        $finish;
    end

    /*---iverilog---*/
    initial begin
        $dumpfile("alu_wave.vcd");
        $dumpvars(0, alu_tb);
    end
    /*---iverilog---*/
  
endmodule
