`include "def.sv"

module regfile (
    input clk,
    input rst,

    input  [4:0]  raddr1, raddr2,
    output [31:0] rdata1, rdata2,

    input wen,
    input [4:0]  waddr,
    input [31:0] wdata
);

    integer i;
    reg [31:0] regs[32];

    initial begin
        for(i = 0; i < 32; i++) begin
            regs[i] = 32'b0;
        end
    end

    assign rdata1 = regs[raddr1];
    assign rdata2 = regs[raddr2];

    always_ff @(posedge clk) begin
        if(rst) begin
            for(i = 0; i < 32; i++) begin
                regs[i] <= 32'b0;
            end
        end
        else begin
            if(wen & waddr != 5'b0) begin 
                regs[waddr] <= wdata;
            end
        end
    end
   
endmodule