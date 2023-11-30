module lfsr(
  input clk, // clock input
  input rst, // reset input
  output reg [3:0] randOut // 4-bit random output
);

	// player 1
	localparam UP1 = 4'b0000;
	localparam DOWN1 = 4'b0001;
	localparam RIGHT1 = 4'b0010;
	localparam LEFT1 = 4'b0011;
	localparam A1 = 4'b0100;
	localparam B1 = 4'b0101;
	// player 2
	localparam UP2 = 4'b0110;
	localparam DOWN2 = 4'b0111;
	localparam RIGHT2 = 4'b1000;
	localparam LEFT2 = 4'b1001;
	localparam A2 = 4'b1010;
	localparam B2 = 4'b1011;

    reg [7:0] state; // LFSR state register

    initial begin
        state <= 8'b10101010;
    end

    always @(posedge clk) begin
        if (rst) begin
            state <= 8'b10101010; // reset to initial state
        end else begin
            // calculate next state using XOR feedback
            state <= {state[6:0], state[7] ^ state[5] ^ state[4] ^ state[3]};
        end
    end

	// each button is equally probable to be chosen
    always_comb begin
        if (state[5:0] < 21) begin
            randOut = UP1;
        end else if (state[5:0] < 42)  begin
            randOut = DOWN1;
        end else if (state[5:0] < 63) begin
            randOut = RIGHT1;
        end else if (state[5:0] < 84) begin
            randOut = LEFT1;
        end else if (state[5:0] < 105) begin
            randOut = A1;
        end else if (state[5:0] < 126) begin
            randOut = B1;
        end else if (state[5:0] < 147) begin
            randOut = UP2;
		end else if (state[5:0] < 168) begin
            randOut = DOWN2;
		end else if (state[5:0] < 189) begin
            randOut = RIGHT2;
		end else if (state[5:0] < 210) begin
            randOut = LEFT2;
		end else if (state[5:0] < 231) begin
            randOut = A2;
        end else begin
            randOut = B2;
        end
    end

    // assign randOut = {1'b0, state[2:0]} + 1; // use the LFSR output as random number

endmodule