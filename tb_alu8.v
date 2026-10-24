`timescale 1ns/1ps

module tb_alu8;

    reg  [7:0] A, B;
    reg  [2:0] OP;
    wire [7:0] RESULT;
    wire CARRY, ZERO;

    integer errors;

    alu8 DUT (
        .A(A),
        .B(B),
        .OP(OP),
        .RESULT(RESULT),
        .CARRY(CARRY),
        .ZERO(ZERO)
    );

    task check;
        input [7:0] expected;
        begin
            #1;
            if (RESULT !== expected) begin
                $display("FAIL: OP=%b A=%d B=%d RESULT=%d EXPECTED=%d",
                         OP, A, B, RESULT, expected);
                errors = errors + 1;
            end else begin
                $display("PASS: OP=%b RESULT=%d",
                         OP, RESULT);
            end
        end
    endtask

    initial begin
        errors = 0;
        A = 8'd12;
        B = 8'd3;

        OP = 3'b000; check(8'd15);
        OP = 3'b001; check(8'd9);
        OP = 3'b010; check(8'd0);
        OP = 3'b011; check(8'd15);
        OP = 3'b100; check(8'd15);
        OP = 3'b101; check(8'd243);
        OP = 3'b110; check(8'd24);
        OP = 3'b111; check(8'd6);

        // Test addition overflow
        A = 8'd240;
        B = 8'd48;
        OP = 3'b000;
        #1;
        if (RESULT !== 8'd32 || CARRY !== 1'b1) begin
            $display("FAIL: Addition carry test");
            errors = errors + 1;
        end else begin
            $display("PASS: Addition carry test");
        end

        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TESTS FAILED: %0d error(s)", errors);

        $finish;
    end

endmodule
