`ifndef _Definition
`define _Definition

package f3OpInt;
    typedef enum bit [2:0] {
        ADD = 3'b000,
        AND = 3'b111,
        OR = 3'b110,
        XOR = 3'b100,
        SL = 3'b001,
        SR = 3'b101,
        SLT = 3'b010,
        SLTU = 3'b011
    } funct3OpcodeInt;
endpackage

package f3Br;
    enum bit [2:0] {
        EQ = 3'b000,
        NE = 3'b001,
        LT = 3'b100,
        GE = 3'b101,
        LTU = 3'b110,
        GEU = 3'b111
    } funct3Branch;
endpackage

`endif