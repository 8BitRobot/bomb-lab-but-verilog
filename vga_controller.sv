// module vga_controller(
//     input clk,
//     input gameclk,
//     input rst, 
//     input [7:0] controls [0:1],
//     output hsync, 
//     output vsync,
//     output [3:0] red,
//     output [3:0] green,
//     output [3:0] blue
// );
    
//     wire [9:0] hc, vc;
//     wire [6:0] x, y;
//     assign x = hc / 8; // hc is 0 to 799; x is 0 to 99 (coordinates 0 to 79)
//     assign y = vc / 8; // vc is 0 to 524; y is 0 to 65 (coordinates 0 to 59)
//     wire [7:0] dataOut;

//     wire [9:0] addrWrite;
//     wire [7:0] dataIn;

//     graphicscontroller gfx(gameclk, rsts[0], x, y, dataIn, controls, addrWrite);
//     memory_controller mem(clk, addrWrite, dataIn, hc, vc, dataOut);
    
//     wire [2:0] input_red, input_green;
//     wire [1:0] input_blue;

//     assign input_red = dataOut[7:5];
//     assign input_green = dataOut[4:2];
//     assign input_blue = dataOut[1:0];

//     vga disp(clk, input_red, input_green, input_blue, rsts[1], hc, vc, hsync, vsync, red, green, blue);
// endmodule

module vga_controller(
    input vga_clk,
    input rst,
	 input [3:0] buttons [0:7],
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

    graphics_controller s1(x, y, buttons, input_color);

    vga disp(vga_clk, input_red, input_green, input_blue, rst, hc, vc, hsync, vsync, red, green, blue);
endmodule