module debounce (
    clock,
    signal,
    signal_db,
);
    input clock, signal;
    output reg signal_db = 0;
    
    reg [7:0] signal_sr;
    
    always @(posedge clock) begin
        signal_sr <= { signal_sr[6:0], signal };
        
        if (signal_sr == 8'b0) begin
            signal_db <= 0;
        end else if (signal_sr == 8'b11111111) begin
            signal_db <= 1;
        end
    end
 endmodule