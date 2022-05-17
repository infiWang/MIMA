module iram (
    input  [31:0] addr,
    output [31:0] rdata
);

    localparam addr_width = 12;
    localparam mem_size   = (2**addr_width);

    wire [addr_width-1:0] actual_address;
    assign actual_address[addr_width-1:0] = addr[addr_width+1:2];

    reg [31:0] mem[0:mem_size-1];
    initial begin
        $readmemh("/path/to/***.rv32i.i", mem);
    end

    assign rdata = mem[actual_address][31:0];

endmodule