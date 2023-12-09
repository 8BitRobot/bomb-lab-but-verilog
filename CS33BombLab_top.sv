module CS33BombLab_top(
    input clk,
	 input rst,
	 input start,
	 input nes_data_1,
	 input nes_data_2,
    output hsync,
    output vsync,
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue,
	 output [47:0] segs,
	 output nes_clock,
	 output nes_latch_1,
	 output nes_latch_2
);
   wire rst_active_high = ~rst;
	wire start_active_high = ~start;
	
   wire vga_clk;
	wire gen_button_clk;
   plls vgaclock(clk, vga_clk, gen_button_clk); // 25 MHz, 1 MHz
	
	assign nes_clock = gen_button_clk;
	wire [7:0] nes_controls_1;
	wire [7:0] nes_controls_2;
	nes_controller n1(nes_clock, nes_data_1, nes_latch_1, nes_controls_1);
	nes_controller n2(nes_clock, nes_data_2, nes_latch_2, nes_controls_2);
	 
	wire game_clk;

   clockDivider #(25000000) gameclock(vga_clk, 'd100, rst_active_high, game_clk);
	 
	wire [3:0] buttons [0:15];
	wire [1:0] game_state;
	localparam WAITING = 2'd0;
	localparam COUNTDOWN = 2'd1;
	localparam SUCCESS = 2'd2;
	localparam FAILURE = 2'd3;
	
	wire [0:11] controller_inputs = {nes_controls_1[6], nes_controls_1[7], nes_controls_1[4], nes_controls_1[5], nes_controls_1[0], nes_controls_1[1], nes_controls_2[6], nes_controls_2[7], nes_controls_2[4], nes_controls_2[5], nes_controls_2[0], nes_controls_2[1]}; // THIS IS REVERSED! TAKE NOTE!
	
	wire [11:0] time_remaining;
	reg [10:0] initial_time;
	reg [5:0] button_count;
	reg [2:0] level_num;
	reg [1:0] past_game_states [1:0];

	game_controller(game_clk, gen_button_clk, rst_active_high, start_active_high, controller_inputs, initial_time, button_count, game_state, buttons, time_remaining);
	 
   vga_controller screen(vga_clk, rst_active_high, buttons[0:7], game_state, hsync, vsync, red, green, blue);
	 
	sevenSegDisp(time_remaining, 1, segs[47:40], segs[39:32], segs[31:24], segs[23:16], segs[15:8], segs[7:0]);

	initial begin
		initial_time = 'd1500;
		button_count = 'd6;
		level_num = 0;
		past_game_states = '{ WAITING, WAITING };
	end

	reg [10:0] initial_time_d;
	reg [5:0] button_count_d;
	reg [2:0] level_num_d;
	
	always @(posedge game_clk) begin
		button_count <= button_count_d;
		initial_time <= initial_time_d;
		past_game_states <= '{ past_game_states[0], game_state };
	end
	
	always_comb begin
		if (rst_active_high) begin
			initial_time_d = 'd1500;
			button_count_d = 'd6;
			level_num_d = 0;
		end else if (past_game_states[1] != SUCCESS && past_game_states[0] == SUCCESS) begin
			// increment to next level
			initial_time_d = initial_time - 100;
			button_count_d = button_count + 1;
			level_num_d = level_num + 1;
		end else if (past_game_states[1] != FAILURE && past_game_states[0] == FAILURE) begin
			// go back to first level
			initial_time_d = 'd1500;
			button_count_d = 'd6;
			level_num_d = 0;
		end else begin
			initial_time_d = initial_time;
			button_count_d = button_count;
			level_num_d = level_num;
		end
	end

endmodule