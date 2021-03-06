`include "def.svh"

module branch (
    input branch,
    input [2:0] funct3,

    input [31:0] rs1, rs2,

    output reg taken
);

    always_comb begin
        if(branch) begin
            case(funct3)
                f3Br::EQ: begin
                    taken = (rs1 == rs2) ? 1'b1 : 1'b0;
                end
                f3Br::NE: begin
                    taken = (rs1 != rs2) ? 1'b1 : 1'b0;
                end
                f3Br::LT: begin
                    taken = ($signed(rs1) < $signed(rs2)) ? 1'b1 : 1'b0;
                end
                f3Br::GE: begin
                    taken = ($signed(rs1) >= $signed(rs2)) ? 1'b1 : 1'b0;
                end
                f3Br::LTU: begin
                    taken = (rs1 < rs2) ? 1'b1 : 1'b0;
                end
                f3Br::GEU: begin
                    taken = (rs1 >= rs2) ? 1'b1 : 1'b0;
                end
                default: begin
                    taken = 1'b0;
                end
            endcase
        end else begin
            taken = 1'b0;
        end
    end
    
endmodule