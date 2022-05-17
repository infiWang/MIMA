`include "def.sv"
`timescale 1ns/100ps

module regfile_tb();
    reg clk, rst;

    reg [4:0] raddr1, raddr2;
    wire [31:0] rdata1, rdata2;

    reg wen;
    reg [4:0] waddr;
    reg [31:0] wdata;
    
    
    localparam period = 10;

    initial begin
        clk = 0;
        forever #1 clk = ~clk;
    end

    initial begin
        rst    = 1;
        raddr1 = 0;
        raddr2 = 1;
        wen   = 0;
        waddr = 0;
        wdata = 32'b0;
        #period;

        rst = 0;
        #period;

        wen   = 1;
        waddr = 0;
        wdata = 32'hb105f00d;
        #period;

        wen = 1;
        waddr = 1;
        wdata = 32'hdeadbeef;
        #period;

        wen = 1;
        waddr = 1;
        wdata = 32'h8badf00d;
        #period;

        wen = 1;
        waddr = 2;
        wdata = 32'hbaadcafe;
        #period;

        wen = 1;
        waddr = 3;
        wdata = 32'hcafed00d;
        #period;

        wen   = 0;
        waddr = 0;
        wdata = 32'b0;
        #period;

        raddr1 = 0;
        raddr2 = 1;
        #period;

        raddr1 = 2;
        raddr2 = 3;
        #period;

        rst = 1;
        #period;
        rst = 0;
        #period;

        raddr1 = 0;
        raddr2 = 1;
        #period;

        raddr1 = 2;
        raddr2 = 3;
        #period;

        $finish;
    end

    /*===iverilog===*/
    initial begin
        $dumpfile("regfile_wave.vcd");
        $dumpvars(0, regfile_tb);
    end
    /*---iverilog---*/
    regfile regfilet (
        .clk(clk), .rst(rst),
        .raddr1(raddr1), .raddr2(raddr2),
        .rdata1(rdata1), .rdata2(rdata2),
        .wen(wen),
        .waddr(waddr),
        .wdata(wdata)
    );
endmodule
