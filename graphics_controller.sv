module graphics_controller(
    input [6:0] x,
    input [6:0] y,
	 input [1:0] state,
	 input [3:0] buttons [0:7],
    output reg [7:0] color
);

	wire [7:0] bs1_color;
	bomb_stage_1 bs1(x, y, state, bs1_color);

	wire [6:0] yme = y - 11;
	
	wire [7:0] symbol_colors [0:7];
	
	symbol_generator s0(x-11, yme, buttons[0][2:0], buttons[0][3], symbol_colors[0]);
	symbol_generator s1(x-18, yme, buttons[1][2:0], buttons[1][3], symbol_colors[1]);
	symbol_generator s2(x-25, yme, buttons[2][2:0], buttons[2][3], symbol_colors[2]);
	symbol_generator s3(x-32, yme, buttons[3][2:0], buttons[3][3], symbol_colors[3]);
	symbol_generator s4(x-39, yme, buttons[4][2:0], buttons[4][3], symbol_colors[4]);
	symbol_generator s5(x-46, yme, buttons[5][2:0], buttons[5][3], symbol_colors[5]);
	symbol_generator s6(x-53, yme, buttons[6][2:0], buttons[6][3], symbol_colors[6]);
	symbol_generator s7(x-60, yme, buttons[7][2:0], buttons[7][3], symbol_colors[7]);
	
	always_comb begin
		if (x >= 11 && x <= 16 && y >= 11 && y <= 16) begin
			color = (symbol_colors[0] == 8'b0) ? bs1_color : symbol_colors[0];
		end else if (x >= 18 && x <= 23 && y >= 11 && y <= 16) begin
			color = (symbol_colors[1] == 8'b0) ? bs1_color : symbol_colors[1];
		end else if (x >= 25 && x <= 30 && y >= 11 && y <= 16) begin
			color = (symbol_colors[2] == 8'b0) ? bs1_color : symbol_colors[2];
		end else if (x >= 32 && x <= 37 && y >= 11 && y <= 16) begin
			color = (symbol_colors[3] == 8'b0) ? bs1_color : symbol_colors[3];
		end else if (x >= 39 && x <= 44 && y >= 11 && y <= 16) begin
			color = (symbol_colors[4] == 8'b0) ? bs1_color : symbol_colors[4];
		end else if (x >= 46 && x <= 51 && y >= 11 && y <= 16) begin
			color = (symbol_colors[5] == 8'b0) ? bs1_color : symbol_colors[5];
		end else if (x >= 53 && x <= 58 && y >= 11 && y <= 16) begin
			color = (symbol_colors[6] == 8'b0) ? bs1_color : symbol_colors[6];
		end else if (x >= 60 && x <= 65 && y >= 11 && y <= 16) begin
			color = (symbol_colors[7] == 8'b0) ? bs1_color : symbol_colors[7];
		end else begin
			color = bs1_color;
		end
	end
endmodule

module symbol_generator(
	input [2:0] symbol_x,
	input [2:0] symbol_y,
	input [2:0] symbol_type,
	input symbol_color,
	output [7:0] color_out
);

	localparam LEFT  = 0;
	localparam RIGHT = 1;
	localparam UP    = 2;
	localparam DOWN  = 3;
	localparam A     = 4;
	localparam B     = 5;
	
	wire [0:5] left_arrow  [0:5] = '{ 6'b000000, 6'b001000, 6'b011000, 6'b111111, 6'b011000, 6'b001000 };
	wire [0:5] right_arrow [0:5] = '{ 6'b000000, 6'b000100, 6'b000110, 6'b111111, 6'b000110, 6'b000100 };
	wire [0:5] up_arrow    [0:5] = '{ 6'b001000, 6'b011100, 6'b111110, 6'b001000, 6'b001000, 6'b001000 };
	wire [0:5] down_arrow  [0:5] = '{ 6'b001000, 6'b001000, 6'b001000, 6'b111110, 6'b011100, 6'b001000 };
	wire [0:5] A_button    [0:5] = '{ 6'b001100, 6'b010010, 6'b010010, 6'b011110, 6'b010010, 6'b010010 };
	wire [0:5] B_button    [0:5] = '{ 6'b011100, 6'b010010, 6'b011100, 6'b010010, 6'b010010, 6'b011100 };
	
	wire [0:5] all_symbols [0:5] [0:5] = '{ left_arrow, right_arrow, up_arrow, down_arrow, A_button, B_button };

	reg [2:0] red;
	reg [2:0] green;
	reg [1:0] blue;
	
	assign color_out = { red, green, blue };
	
	always_comb begin
		if (all_symbols[symbol_type][symbol_y][symbol_x]) begin
			if (symbol_color) begin // red
				red = 3'd7;
				green = 3'd4;
				blue = 2'd2;
			end else begin // blue
				red = 3'd0;
				green = 3'd5;
				blue = 2'd3;
			end
		end else begin
			red = 0;
			green = 0;
			blue = 0;
		end
	end

endmodule