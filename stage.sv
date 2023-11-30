module stage(clk, rst, count, result)
  	input clk, rst;
  	input [3:0] count;
  	output result;

	localparam FAILURE = 0;
	localparam SUCCESS = 1;
	localparam WAIT = 2;
	integer i;
  	reg [3:0] buttons[7:0]; // array of 8 4-bit buttons

  	initial begin
		// select 8 random buttons
    	for (i = 0; i < 8; i = i + 1) begin
			lfsr random()
        	buttons[i] = 
      	end
  	end

	always @ (posedge clk) begin
		if (rst) begin

		end
	end
endmodule