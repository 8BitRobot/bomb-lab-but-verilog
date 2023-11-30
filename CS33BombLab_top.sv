module CS33BombLab_top(
    input clk, rst,
	// input right1, left1, up1, down1, a1, b1,
	// input right2, left2, up2, down2, a2, b2,
	// output reg [7:0] sevenSegDisplay,
    output hsync,
    output vsync,
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue
);
    wire vga_clk;
    plls vgaclock(clk, vga_clk);
    vga_controller screen(vga_clk, rst, hsync, vsync, red, green, blue);

	// wire secondsClk;
	// clockDivider cd(.inClock(clk), .speed(1), .rst(rst), .outClock(secondsClk));

	// todo: set count here

	// wire [3:0] count;
	// timer t(.clk(secondsClk), .rst(rst), .count(count));
	// sevenSegDigit ssd(.decimalNum(count), .dispBits(sevenSegDisplay));

endmodule