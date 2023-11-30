module bomb_stage_1(
    input [6:0] x,
    input [6:0] y,
    output reg [2:0] red,
    output reg [2:0] green,
    output reg [1:0] blue
);

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
        end else if (x >= 9 && x <= 70 && y >= 9 && y <= 18) begin
            red = 5;
            green = 7;
            blue = 1;
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