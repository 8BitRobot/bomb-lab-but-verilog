module vga_controller(
    input vga_clk,
    input rst,
	 input [3:0] buttons [0:7],
	 input [1:0] state,
    output hsync,
    output vsync,
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue
);

	localparam LEFT  = 3'd0;
	localparam RIGHT = 3'd1;
	localparam UP    = 3'd2;
	localparam DOWN  = 3'd3;
	localparam A     = 3'd4;
	localparam B     = 3'd5;
	
    wire [9:0] hc, vc;
    wire [6:0] x = hc / 8;
    wire [6:0] y = vc / 8;
	 
	 wire [7:0] input_color;
    
    wire [2:0] input_red = input_color[7:5];
    wire [2:0] input_green = input_color[4:2];
    wire [1:0] input_blue = input_color[1:0];

    graphics_controller s1(x, y, state, buttons, input_color);

    vga disp(vga_clk, input_red, input_green, input_blue, rst, hc, vc, hsync, vsync, red, green, blue);
endmodule