module bomb_stage_1(
    input [6:0] x,
    input [6:0] y,
	 input [1:0] state,
    output [7:0] color
);

	localparam WAITING = 2'd0;
	localparam COUNTDOWN = 2'd1;
	localparam SUCCESS = 2'd2;
	localparam FAILURE = 2'd3;

	reg [2:0] red;
	reg [2:0] green;
	reg [1:0] blue;
	
	assign color = { red, green, blue };

    always_comb begin
        if (
            (x >= 4 && x <= 75 && y >= 4 && y <= 7) ||
            (x >= 4 && x <= 75 && y >= 52 && y <= 55) ||
            (y >= 4 && y <= 55 && x >= 4 && x <= 7) ||
            (y >= 4 && y <= 55 && x >= 72 && x <= 75)
        ) begin // bomb border
            red = 0;
            green = 0;
            blue = 0;
        end else if (x >= 9 && x <= 70 && y >= 9 && y <= 18) begin // button display
            red = 0;
            green = 3;
            blue = 0;
        end else if (
				(y == 20 && x >= 40 && x <= 66) ||
				(y == 21 && (x >= 40 && x <= 66)) ||
				(y == 22 && (x >= 40 && x <= 66)) ||
				(y == 23 && (x >= 41 && x <= 65)) ||
				((y == 20 || y == 35) && (x >= 16 && x <= 21)) ||
				((y == 21 || y == 34) && (x >= 14 && x <= 23)) ||
				((y == 22 || y == 33) && (x >= 13 && x <= 16 || x >= 21 && x <= 24)) ||
				((y == 23 || y == 32) && (x >= 12 && x <= 14 || x >= 23 && x <= 25)) ||
				((y == 24 || y == 31) && (x >= 12 && x <= 13 || x >= 24 && x <= 25)) ||
				((y == 25 || y == 30) && (x == 13 || x == 24)) ||
				((y >= 25 && y <= 30) && (x == 11 || x == 12 || x == 25 || x == 26)) ||
				((y >= 23 && y <= 28) && (x == 18 || x == 19)) ||
				(y == 49 && (x >= 41 && x <= 65)) ||
				((y == 50 || y == 51) && (x >= 40 && x <= 66))
		  ) begin // circle 1 and wire bars
				red = 0;
				green = 0;
				blue = 0;
		  end else if (
				((y == 33 || y == 34 || y == 47 || y == 48) && (x >= 33 && x <= 38)) ||
				((y == 34 || y == 35 || y == 46 || y == 47) && ((x >= 38 && x <= 40) || (x >= 31 && x <= 33))) ||
				((y == 35 || y == 46) && (x == 30 || x == 41)) ||
				((y == 36 || y == 45) && (x == 31 || x == 40)) ||
				(((y >= 36 && y <= 38) || (y >= 43 && y <= 45)) && (x == 29 || x == 30 || x == 41 || x == 42)) ||
				((y >= 38 && y <= 43) && (x == 28 || x == 29 || x == 42 || x == 43)) ||
				((y >= 36 && y <= 41) && (x == 35 || x == 36))
		  ) begin // circle 2
			   red = 0;
				green = 0;
				blue = 0;		  
		  end else if ((x >= 13 && x <= 24 && y >= 22 && y <= 33) || (x >= 30 && x <= 41 && y >= 35 && y <= 46)) begin // dial fill-ins
				red = 7;
				green = 7;
				blue = 3;
		  end else if (
				(x == 43 && y == 24) ||
				(x == 44 && y >= 24 && y <= 27) ||
				(x == 45 && y >= 24 && y <= 29) ||
				(x == 46 && y >= 26 && y <= 30) ||
				(x == 47 && y >= 28 && y <= 32) ||
				(x == 48 && ((y >= 29 && y <= 34) || y == 48)) ||
				(x == 49 && ((y >= 31 && y <= 39) || (y >= 41 && y <= 44) || y == 48)) ||
				(x == 50 && (y >= 34 && y <= 44)) ||
				(x == 51 && (y >= 38 && y <= 42))
		  ) begin
				red = 7;
				green = 0;
				blue = 0;
        end else if (
		      (x == 52 && (y >= 30 && y <= 39)) ||
				(x == 53 && (y >= 24 && y <= 41)) ||
				(x == 54 && ((y >= 24 && y <= 31) || (y >= 39 && y <= 47))) ||
				(x == 55 && (y >= 39 && y <= 48)) ||
				(x == 56 && ((y >= 38 && y <= 43) || y >= 46 && y <= 48)) ||
				(x == 57 && (y >= 37 && y <= 39)) ||
				((x == 58 || x == 59) && (y >= 36 && y <= 38)) ||
				((x == 60 || x == 61) && (y >= 37 && y <= 42)) ||
				(x == 62 && (y >= 38 && y <= 41)) ||
				(x == 59 && y == 41) ||
				((x >= 57 && x <= 60) && (y == 42 || y == 43))
		  ) begin
				red = 4;
				green = 4;
				blue = 0;
		  end else if (
				(x == 53 && y == 48) ||
				(x == 54 && (y == 47 || y == 48)) ||
				(x == 55 && (y >= 27 && y <= 36)) ||
				(x == 56 && (y >= 24 && y <= 44)) ||
				(x == 57 && ((y >= 24 && y <= 27) || (y >= 36 && y <= 41))) ||
				(x == 58 && y == 24)
		  ) begin
				red = 1;
				green = 2;
				blue = 3;
		  end else if (
				(y == 48 && (x >= 42 && x <= 45)) ||
				(y == 47 && (x >= 43 && x <= 50)) ||
				(y == 46 && (x >= 45 && x <= 60)) ||
				(y == 45 && (x >= 49 && x <= 64)) ||
				(y == 44 && (x >= 60 && x <= 65)) ||
				(x == 60 && (y >= 26 && y <= 31)) ||
				(x == 61 && (y >= 24 && y <= 33)) ||
				(x == 62 && ((y >= 24 && y <= 27) || (y >= 31 && y <= 33))) ||
				(x == 63 && ((y >= 32 && y <= 34) || y == 43)) ||
				(x == 64 && ((y >= 32 && y <= 35) || y == 42 || y == 43)) ||
				(x == 65 && ((y >= 33 && y <= 37) || (y >= 40 && y <= 43))) ||
				(x == 66 && (y >= 34 && y <= 43)) ||
				(x == 67 && (y >= 37 && y <= 41))
		  ) begin
				red = 1;
				green = 5;
				blue = 1;
		  end else if (x >= 8 && x <= 71 && y >= 8 && y <= 51) begin // bomb light background
            red = 5;
            green = 5;
            blue = 2;
		  end else begin // outside border
				if (state == WAITING || state == COUNTDOWN) begin
					red = 2;
					green = 2;
					blue = 1;
				end else if (state == SUCCESS) begin
					red = 0;
					green = 5;
					blue = 1;
				end else begin
					red = 5;
					green = 1;
					blue = 0;
				end
        end
    end

endmodule