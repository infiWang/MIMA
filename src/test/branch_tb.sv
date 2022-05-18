`timescale 1ns/1ns

module branch_tb();

    localparam period = 1;

    reg branch;
    reg [2:0] funct3;

    reg [31:0] rs1, rs2;

    wire taken;

    initial begin
        branch = 1;

        // Taken
        $display("Running taken test");

        // eq
        rs1 = 32'hdeadbeef;
        rs2 = 32'hdeadbeef;
        funct3 = f3Br::EQ;
        #period;
        if (!taken) $display("eq failed");
        // neq
        rs1 = 32'hbeeff00d;
        rs2 = 32'hcafef00d;
        funct3 = f3Br::NE;
        #period;
        if (!taken) $display("neq failed");
        // lt
        rs1 = 32'hfedcba98;
        rs2 = 32'h12345678;
        funct3 = f3Br::LT;
        #period;
        if (!taken) $display("lt failed");
        // ge
        rs1 = 32'h76543210;
        rs2 = 32'hfedcba98;
        funct3 = f3Br::GE;
        #period;
        if (!taken) $display("ge failed");
        // ltu
        rs1 = 32'h76543210;
        rs2 = 32'h87654321;
        funct3 = f3Br::LTU;
        #period;
        if (!taken) $display("ltu failed");
        // geu
        rs1 = 32'hfedcba98;
        rs2 = 32'h01234567;
        funct3 = f3Br::GEU;
        #period;
        if (!taken) $display("geu failed");

        // Not taken
        $display("Running not taken test");

        // eq
        rs1 = 32'hfeedf00d;
        rs2 = 32'hf00dfeed;
        funct3 = f3Br::EQ;
        #period;
        if (taken) $display("eq failed");
        // neq
        rs1 = 32'hfeedc0de;
        rs2 = 32'hfeedc0de;
        funct3 = f3Br::NE;
        #period;
        if (taken) $display("neq failed");
        // lt
        rs1 = 32'h76543210;
        rs2 = 32'h87654321;
        funct3 = f3Br::LT;
        #period;
        if (taken) $display("lt failed");
        // ge
        rs1 = 32'hfedcba98;
        rs2 = 32'h01234567;
        funct3 = f3Br::GE;
        #period;
        if (taken) $display("ge failed");
        // ltu
        rs1 = 32'hfedcba98;
        rs2 = 32'h12345678;
        funct3 = f3Br::LTU;
        #period;
        if (taken) $display("ltu failed");
        // geu
        rs1 = 32'h76543210;
        rs2 = 32'hfedcba98;
        funct3 = f3Br::GEU;
        #period;
        if (taken) $display("geu failed");
        
    end

    branch brancht (
        .branch(branch), .funct3(funct3),
        .rs1(rs1), .rs2(rs2),
        .taken(taken)
    );

    /*---iverilog---*/
    initial begin
        $dumpfile("branch_wave.vcd");
        $dumpvars(0, branch_tb);
    end
    /*---iverilog---*/

endmodule
