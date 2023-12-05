module nes_controller(input nes_clock, input nes_data, output logic nes_latch, output logic [7:0] controls);
	logic polling_clock;
	logic clock_not_started = 1;
	
	clockDivider #(1000000) PollingClock(nes_clock, 80000, 0, polling_clock); // 750 Hz
	
	reg [1:0] polling_clock_sr = 2'b0;
	
	reg reading = 0;
	reg [2:0] read_count = 0;
	
	logic [7:0] controls_read;
	initial begin
		controls_read = 8'b0;
	end
	
	always @(posedge nes_clock) begin
		polling_clock_sr <= { polling_clock_sr[0], polling_clock };
		
		if (polling_clock_sr == 2'b01) begin
			nes_latch <= 1;
		end else begin
			if (nes_latch == 1) begin
				reading <= 1;
			end
			nes_latch <= 0;
		end
		
		if (reading) begin
			read_count <= read_count + 1;
			controls_read[read_count] <= nes_data;
			
			if (read_count == 7) begin
				reading <= 0;
			end
		end
	end
	
	always_comb begin
		controls[0] = controls_read == 8'b11111110;
		controls[1] = controls_read == 8'b11111100;
		controls[2] = controls_read == 8'b11111001;
		controls[3] = controls_read == 8'b11110011;
		controls[4] = controls_read == 8'b11100111;
		controls[5] = controls_read == 8'b11001111;
		controls[6] = controls_read == 8'b10011111;
		controls[7] = controls_read == 8'b00111111;
	end
endmodule