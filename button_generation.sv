module button_generation(
    input clk,
    input rst,
    input start,
    input [5:0] count,
    output reg [3:0] buttons [0:15],
    output valid
);

    localparam IDLE = 0;
    localparam GEN  = 1;
    reg state = IDLE;
    reg nextState;

    reg [1:0] rst_sr = 2'b00;
	 reg [1:0] start_sr = 2'b00;

    reg [3:0] buttons_d [0:15];
    reg [3:0] currentCount = 0;
    reg [3:0] currentCount_d = 0;

    assign valid = currentCount == count;

    wire [3:0] randomOutput;
	 lfsr random (.clk(clk), .rst(rst), .randOut(randomOutput));
	 
	 initial begin
		for (integer i = 0; i < 15; i = i + 1) begin
			buttons[i] = 4'b1111;
		end
	 end

    always @(posedge clk) begin
        rst_sr <= { rst_sr[0], rst };
		  start_sr <= { start_sr[0], start };
		  
        state <= nextState;
        currentCount <= currentCount_d;

        for (integer i = 0; i < 16; i = i + 1) begin
            buttons[i] <= buttons_d[i];
        end
    end

    always_comb begin
        if (state == IDLE) begin
            if (rst == 2'b01 || !(start_sr == 2'b01)) begin
                nextState = IDLE;
            end else begin // start is 1
                nextState = GEN;
            end

            for (integer i = 0; i < 16; i = i + 1) begin
                buttons_d[i] = 4'b1111;
            end

            currentCount_d = 0;
        end else begin // state is GEN
            if (rst == 2'b01 || currentCount == count) begin
                nextState = IDLE;
                for (integer i = 0; i < 16; i = i + 1) begin
                    buttons_d[i] = 4'b1111;
                end
                currentCount_d = 0;
            end else begin // generating
                nextState = GEN;
                for (integer i = 0; i < 16; i = i + 1) begin
                    if (i == currentCount) begin
                        buttons_d[i] = randomOutput;
                    end else begin
                        buttons_d[i] = buttons[i];
                    end
                end
                currentCount_d = currentCount + 1;
            end
        end
    end

endmodule