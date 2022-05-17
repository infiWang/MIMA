`include "def.sv"

module pc (
    input clk, rst,

    input jmp,
    input rel,
    input [31:0] diff,
    input [31:0] nxt,

    output [31:0] cur
);

    reg [31:0] r;
    assign cur = r;

    initial begin
        r = 32'b0;
    end

    always_ff @(posedge clk) begin
        if(rst) begin
            r <= 32'b0;
        end else begin
            if(jmp) begin
                if(rel) begin
                    r <= r + diff;
                end else begin
                    r <= nxt;
                end
            end else begin
                r <= r + 4;
            end
        end
    end

endmodule