typedef enum bit [4:0] {
    ADD = 5'b00000,
    SUB = 5'b00001,
    XOR = 5'b00010,
    OR  = 5'b00011,
    AND = 5'b00100,
    SRA = 5'b00101,
    SRL = 5'b00110,
    SLL = 5'b00111,
    LTS = 5'b01000,
    LTU = 5'b01001,
    GES = 5'b01010,
    GEU = 5'b01011,
    EQ  = 5'b01100,
    NE  = 5'b01101
} aluop;