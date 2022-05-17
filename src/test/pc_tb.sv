`include "def.sv"
`timescale 1ns/100ps

module pc_tb();

    localparam period = 10;

    reg clk, rst;

    wire [31:0] addr_pc_cur;

    reg pc_jmp, pc_jmp_rel;
    reg [31:0] addr_pc_nxt;

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        pc_jmp     = 0;
        pc_jmp_rel = 0;
        addr_pc_nxt  = 32'b0;
        #period;
        rst = 0;
        #period;

        #50;

        pc_jmp     = 1;
        pc_jmp_rel = 0;
        addr_pc_nxt  = 32'h00001000;
        #period;
        pc_jmp     = 0;
        addr_pc_nxt  = 32'b0;

        #50;

        pc_jmp     = 1;
        pc_jmp_rel = 1;
        addr_pc_nxt = 32'hffffffec;
        #period;
        pc_jmp     = 0;
        pc_jmp_rel = 0;
        addr_pc_nxt = 32'b0;

        #90;

        $finish;
    end

    pc pct (
        .clk(clk), .rst(rst),
        .cur(addr_pc_cur),
        .jmp(pc_jmp), .rel(pc_jmp_rel),
        .nxt(addr_pc_nxt)
    );

    /*===iverilog===*/
    initial begin
        $dumpfile("pc_wave.vcd");
        $dumpvars(0, pc_tb);
    end
    /*---iverilog---*/

endmodule
