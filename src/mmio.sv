module mmio (
    input clk, rst,
    input load, store,
    input [2:0] access,
    input [31:0] addr,
    input [31:0] data_in,
    output reg [31:0] data_out
);

    ram ram0(
        .clk(clk), .rst(rst),
        .load(load), .store(store),
        .access(access),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

endmodule
