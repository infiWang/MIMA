`include "def.sv"
`timescale 1ns/100ps

module sccpu_tb();
    localparam period = 10;

    reg clk, rst;

    sccpu my_cpu(
        .clk(clk), .rst(rst)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        #period;
        rst = 0;

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