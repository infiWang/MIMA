`include "def.svh"
`timescale 1ns/100ps

module sccpu_tb();

    localparam period = 10;

    reg clk, rst, stall;

    sccpu mimasama(
        .clk(clk), .rst(rst), .stall(stall)
    );

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        stall = 1;
        #period;
        rst = 0;
        stall = 0;

        // forever #10 stall = ~stall;

        #999990;
        #period;

        $finish;
    end


    /*---iverilog---*/
    initial begin
        $dumpfile("sccpu_tb.vcd");
        $dumpvars(0, sccpu_tb);
    end
    /*---iverilog---*/

endmodule