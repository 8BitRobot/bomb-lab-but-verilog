module sevenSegDisp(value, onSwitch, dig5, dig4, dig3, dig2, dig1, dig0 );
	input onSwitch;
	input [23:0] value;
	output [7:0] dig5, dig4, dig3, dig2, dig1, dig0; //5 to 0 are the 6 displays on the board from left to right
	reg [3:0] input5, input4, input3, input2, input1, input0; //You will need more of these

	sevenSegDigit digit5(input5, onSwitch, 8'b00000000, dig5); //Instantiation of the leftmost seven-seg display
	sevenSegDigit digit4(input4, onSwitch, 8'b00000000, dig4);
	sevenSegDigit digit3(input3, onSwitch, 8'b00000000, dig3);
	sevenSegDigit digit2(input2, onSwitch, 8'b00000000, dig2);
	sevenSegDigit digit1(input1, onSwitch, 8'b00000000, dig1);
	sevenSegDigit digit0(input0, onSwitch, 8'b00000000, dig0);

	always_comb begin
		input0 = value % 10;
		input1 = (value / 10) % 10;
		input2 = (value / 100) % 10;
		input3 = (value / 1000) % 6;
		input4 = (value / 6000) % 10;
		input5 = (value / 60000) % 6;
	end
endmodule