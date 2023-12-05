module game_controller(
	input clk,
	input gen_button_clk,
	input rst,
	input start,
	input [0:11] controller_inputs,
	input [10:0] initial_time,
	input [5:0] button_count,
	output reg [1:0] state,
	output reg [3:0] display_buttons [0:15],
	output reg [10:0] time_remaining
);

	localparam WAITING = 0;
	localparam COUNTDOWN = 1;
	localparam SUCCESS = 2;
	localparam FAILURE = 3;
	
	reg [1:0] controls_srs [0:11]; // controls_srs[0] = P1_left, P1_right, up, down, A, B, P2_left, ... , controls_srs[11] = P2_B
	reg [0:11] controls_pulsed;
	
	reg [0:11] expected_controls;
	
	reg [1:0] rst_sr;
	reg [1:0] start_sr;
	
	reg [1:0] next_state;
	reg [10:0] time_remaining_d;
	reg [3:0] display_buttons_d [0:15];
	
	reg [3:0] generated_buttons [0:15] = '{ 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111 };
	wire [3:0] generated_buttons_temp [0:15];
	wire valid;
	button_generation bg(gen_button_clk, rst, start, button_count, generated_buttons_temp, valid);
	
	always @(posedge gen_button_clk) begin
		if (valid) begin
			generated_buttons <= generated_buttons_temp;
		end
	end
	
	initial begin
	    time_remaining = 0;
		state = WAITING;
		for (integer i = 0; i < 12; i = i + 1) begin
			controls_srs[i] = 2'b0;
		end
		rst_sr = 2'b0;
		start_sr = 2'b0;
		display_buttons = '{ 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111 };
	end
	
	always @(posedge clk) begin
		for (integer i = 0; i < 12; i = i + 1) begin
			controls_srs[i] <= { controls_srs[i][0], controller_inputs[i] };
		end
		rst_sr <= { rst_sr[0], rst };
		start_sr <= { start_sr[0], start };
		
		state <= next_state;
		time_remaining <= time_remaining_d;
		display_buttons <= display_buttons_d;
	end
	
	always_comb begin
		for (integer i = 0; i < 12; i = i + 1) begin
			controls_pulsed[i] = controls_srs[i] == 2'b01;
			expected_controls[i] = (i == display_buttons[0]);
		end
		
		case (state)
			WAITING: begin
				if (start_sr == 2'b01) begin
					next_state = COUNTDOWN;
					display_buttons_d = generated_buttons;
				end else begin
					next_state = WAITING;
					display_buttons_d = display_buttons;
				end
				
				time_remaining_d = initial_time;
			end
			COUNTDOWN: begin
				if (rst_sr == 2'b01) begin
					next_state = WAITING;
				end else if (display_buttons[0] == 4'b1111) begin
					next_state = SUCCESS;
				end else if (time_remaining == 0 || (|controls_pulsed && expected_controls != controls_pulsed)) begin
					next_state = FAILURE;
				end else begin
					next_state = COUNTDOWN;
				end
				
				time_remaining_d = time_remaining - 1;
				
				if (|controls_pulsed && expected_controls == controls_pulsed) begin
					for (integer i = 0; i < 15; i = i + 1) begin
						display_buttons_d[i] = display_buttons[i+1];
					end
					display_buttons_d[15] = 4'b1111;
				end else begin
					display_buttons_d = display_buttons;
				end
			end
			SUCCESS: begin
				if (start_sr == 2'b01) begin
					next_state = WAITING;
					time_remaining_d = initial_time;
					display_buttons_d = '{ 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111 };
				end else begin
					next_state = state;
					time_remaining_d = time_remaining;
					display_buttons_d = display_buttons;
				end
			end
			FAILURE: begin
				if (start_sr == 2'b01) begin
					next_state = WAITING;
					time_remaining_d = initial_time;
					display_buttons_d = '{ 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111, 4'b1111 };
				end else begin
					next_state = state;
					time_remaining_d = 0;
					display_buttons_d = display_buttons;
				end
			end
			default: begin
				next_state = state;
				time_remaining_d = time_remaining;
				display_buttons_d = display_buttons;
			end
		endcase
	end
endmodule