module timer(
    input clk,
    input rst,
    input [3:0] max,
    output reg [3:0] count
);
    initial begin
        count = 0;
    end
    // on posedge clk, decrement count
    // when count = 0, do nothing
    // on rst, timer is 0
    always @ (posedge clk) begin
        if (count > 0) begin
            count <= count - 1;
        end else begin
            count <= max;
        end
    end
    
endmodule