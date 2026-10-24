module alu8 (
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire [2:0] OP,
    output reg  [7:0] RESULT,
    output reg        CARRY,
    output wire       ZERO
);

    reg [8:0] TEMP;

    always @(*) begin
        RESULT = 8'b0;
        CARRY  = 1'b0;
        TEMP   = 9'b0;

        case (OP)

            3'b000: begin
                // Addition
                TEMP   = {1'b0, A} + {1'b0, B};
                RESULT = TEMP[7:0];
                CARRY  = TEMP[8];
            end

            3'b001: begin
                // Subtraction
                RESULT = A - B;
                CARRY  = (A >= B);
            end

            3'b010: begin
                // Bitwise AND
                RESULT = A & B;
            end

            3'b011: begin
                // Bitwise OR
                RESULT = A | B;
            end

            3'b100: begin
                // Bitwise XOR
                RESULT = A ^ B;
            end

            3'b101: begin
                // Bitwise NOT
                RESULT = ~A;
            end

            3'b110: begin
                // Shift A left by one bit
                RESULT = A << 1;
                CARRY  = A[7];
            end

            3'b111: begin
                // Shift A right by one bit
                RESULT = A >> 1;
                CARRY  = A[0];
            end

        endcase
    end

    assign ZERO = (RESULT == 8'b0);

endmodule
