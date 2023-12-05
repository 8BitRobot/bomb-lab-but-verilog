module testbench(
    output out
);

    reg clk = 0;
	 reg gen_button_clk = 0;
    reg rst = 0;
    reg start = 0;
	 reg [0:11] controller_inputs = 0;
	 reg [10:0] initial_time = 'd1500;
	 reg [5:0] button_count = 'd5;
    reg [3:0] count = 5;
	 
	 wire [1:0] state;
	 wire [3:0] display_buttons [0:15];
	 wire [10:0] time_remaining;

    game_controller bg(
        clk,
		  gen_button_clk,
		  rst,
		  start,
		  controller_inputs,
		  initial_time,
		  button_count,
		  state,
		  display_buttons [0:15],
		  time_remaining
    );

    always begin
        #50 clk = ~clk;
    end
	 
	 always begin
		  #5 gen_button_clk = ~gen_button_clk;
	 end

endmodule