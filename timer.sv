module timer(clk, rst, count);
    input clk, rst;
    output reg [0:3] count;

    // on posedge clk, decrement count
    // when count = 0, do nothing
    // on rst, timer is 0
    always @ (posedge clk) begin
        if (rst) begin
            count <= 0;
        end 
        else if (count >= 0) begin
            count <= count - 1;
        end
    end
    
endmodule