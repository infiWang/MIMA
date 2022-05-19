`ifndef _Definition
`define _Definition

package gopcode;
    typedef enum bit [4:0] {
        LOAD     = 5'b00000,
        STORE    = 5'b01000,
        LOAD_FP  = 5'b00001,
        STORE_FP = 5'b01001,
        MISC_MEM = 5'b00011,
        AMO      = 5'b01011,

        OP        = 5'b01100,
        OP_32     = 5'b01110,
        OP_IMM    = 5'b00100,
        OP_IMM_32 = 5'b00110,
        OP_FP     = 5'b10100,

        BRANCH = 5'b11000,
        JALR   = 5'b11001,
        JAL    = 5'b11011,
        AUIPC  = 5'b00101,
        LUI    = 5'b01101,

        MADD  = 5'b10000,
        MSUB  = 5'b10001,
        NMSUB = 5'b10010,
        NMADD = 5'b10011,

        SYSTEM = 5'b11100
    } genericOpcode;
endpackage

package f3OpI;
    typedef enum bit [2:0] {
        ADD  = 3'b000,
        AND  = 3'b111,
        OR   = 3'b110,
        XOR  = 3'b100,
        SL   = 3'b001,
        SR   = 3'b101,
        SLT  = 3'b010,
        SLTU = 3'b011
    } funct3OpI;
endpackage

package f3OpM;
    typedef enum bit [2:0] {
        MUL    = 3'b000,
        MULH   = 3'b001,
        MULHSU = 3'b010,
        MULHU  = 3'b011,
        DIV    = 3'b100,
        DIVU   = 3'b101,
        REM    = 3'b110,
        REMU   = 3'b111
    } funct3OpM;
endpackage

package f3Br;
    typedef enum bit [2:0] {
        EQ  = 3'b000,
        NE  = 3'b001,
        LT  = 3'b100,
        GE  = 3'b101,
        LTU = 3'b110,
        GEU = 3'b111
    } funct3Branch;
endpackage

package f3Ld;
    typedef enum bit [2:0] {
        LB  = 3'b000,
        LH  = 3'b001,
        LW  = 3'b010,
        LBU = 3'b100,
        LHU = 3'b101
    } funct3Load;
endpackage

package f3St;
    typedef enum bit [2:0] {
        SB = 3'b000,
        SH = 3'b001,
        SW = 3'b010
    } funct3Store;
endpackage

`endif