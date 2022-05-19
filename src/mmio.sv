`include "def.svh"

module mmio (
    input clk, rst,

    input load, store,
    input [2:0] funct3,

    input [31:0] addr,
    input [31:0] wdata,
    output reg [31:0] rdata
);

    ram dmem0(
        .clk(clk), .rst(rst),
        .load(load), .store(store),
        .funct3(funct3),
        .addr(addr), .wdata(wdata), .rdata(rdata)
    );

endmodule
