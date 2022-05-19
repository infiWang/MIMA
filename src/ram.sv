`include "def.svh"

module ram (
    input clk, rst,

    input [2:0] funct3,
    input load, store,

    input [31:0] addr,
    input [31:0] wdata,
    output reg [31:0] rdata
);

    localparam addr_width = 11;
    localparam mem_size   = (2**addr_width);

    reg [31:0] mem[mem_size-1:0];
    integer i;
    initial begin
        for(int i = 0; i < mem_size; i++) mem[i] = 32'b0;
    end

    wire [addr_width-1:0] actual_address;
    assign actual_address[addr_width-1:0] = addr[addr_width+1:2];
    wire [1:0] byte_offset, half_word_offset;
    assign byte_offset      = addr[1:0];
    assign half_word_offset = {addr[1], 1'b0};

    wire [31:0] data_word;
    wire [31:0] data_shifted;
    wire [3:0] byte_we_pattern;
    we_pattern_gen we_gen0(
        .funct3(funct3),
        .addr(byte_offset),
        .wdata(wdata),

        .byte_we_pattern(byte_we_pattern),
        .data_shifted(data_shifted)
    );

    assign data_word = mem[actual_address];

    always_comb begin
        if (load) begin
            case (funct3)
                f3Ld::LB: begin
                    rdata = {
                        { 24{data_word[byte_offset*8 + 7]} }, data_word[byte_offset*8 +: 8]
                    };
                end
                f3Ld::LH: begin
                    rdata = {
                        { 16{data_word[half_word_offset*8 + 15]} }, data_word[half_word_offset*8 +: 16]
                    };
                end
                f3Ld::LW: begin
                    rdata = data_word;
                end
                f3Ld::LBU: begin
                    rdata = {
                        24'b0, data_word[byte_offset * 8 +: 8]
                    };
                end
                f3Ld::LHU: begin
                    rdata = {
                        16'b0, data_word[half_word_offset * 8 +: 16]
                    };
                end
                default: begin
                  rdata = 32'hxxxxxxxx;
                end
            endcase
        end else begin
            rdata = 32'hxxxxxxxx;
        end
    end

    always@(posedge clk) begin
        if(store) begin
            if (byte_we_pattern[0]) begin
                mem[actual_address][7:0] <= data_shifted[7:0];
            end

            if (byte_we_pattern[1]) begin
                mem[actual_address][15:8] <= data_shifted[15:8];
            end

            if (byte_we_pattern[2]) begin
                mem[actual_address][23:16] <= data_shifted[23:16];
            end

            if (byte_we_pattern[3]) begin
                mem[actual_address][31:24] <= data_shifted[31:24];
            end
        end
    end

endmodule
    
module we_pattern_gen (
    input [2:0] funct3,
    input [1:0] addr,
    input [31:0] wdata,

    output reg [3:0] byte_we_pattern,
    output reg [31:0] data_shifted
);

    always @(*) begin
        data_shifted <= wdata;
        case (funct3[2:0])
            f3St::SB: begin
                case (addr[1:0])
                    2'b00: begin
                        byte_we_pattern <= 4'b0001;
                    end
                    2'b01: begin
                        byte_we_pattern <= 4'b0010;
                        data_shifted    <= (wdata << 8);
                    end
                    2'b10: begin
                        byte_we_pattern <= 4'b0100;
                        data_shifted    <= (wdata << 16);
                    end
                    2'b11: begin
                        byte_we_pattern <= 4'b1000;
                        data_shifted    <= (wdata << 24);
                    end
                endcase
            end
            f3St::SH: begin
                case (addr[1])
                    1'b0: begin
                        byte_we_pattern <= 4'b0011;
                        data_shifted    <= wdata;
                    end
                    1'b1: begin
                        byte_we_pattern <= 4'b1100;
                        data_shifted    <= (wdata << 16);
                    end
                endcase
            end
            f3St::SW: begin
                byte_we_pattern <= 4'b1111;
            end
            default: begin
                byte_we_pattern <= 4'bxxxx;
            end
        endcase
    end

endmodule
