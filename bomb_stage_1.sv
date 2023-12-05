module bomb_stage_1(
    input [6:0] x,
    input [6:0] y,
    output [7:0] color
);

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
        ) begin
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
				((y >= 23 && y <= 28) && (x == 18 || x == 19))
		  ) begin 
				red = 0;
				green = 0;
				blue = 0;
		  end else if (
				((y == 33 || y == 34 || y == 47 || y == 48) && (x >= 33 && x <= 38)) ||
				((y == 34 || y == 35 || y == 46 || y == 47) && ((x >= 38 && x <= 40) || (x >= 31 && x <= 33))) ||
				((y == 35 || y == 46) && (x == 30 || x == 41)) ||
				((y == 36 || y == 45) && (x == 31 || x == 40)) ||
				((y >= 36 && y <= 38) && (x == 29 || x == 30 || x == 41 || x == 42)) ||
				((y >= 38 && y <= 40) && (x == 28 || x == 29 || x == 42 || x == 43))
		  ) begin
			   red = 0;
				green = 0;
				blue = 0;		  
		  end else if (x >= 13 && x <= 24 && y >= 22 && y <= 33) begin
				red = 7;
				green = 7;
				blue = 3;
		  end else if (x >= 8 && x <= 71 && y >= 8 && y <= 51) begin 
            red = 5;
            green = 5;
            blue = 2;
        end else begin
            red = 2;
            green = 2;
            blue = 1;
        end
    end

endmodule