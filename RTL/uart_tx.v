module uart_tx #(
    parameter BAUD_DIV = 16
)(
    input clk,
    input rst,
    input start,
    input [7:0] data_in,
    output reg serial_out,
    output reg tx_busy
);

    reg [3:0] bit_cnt;
    reg [12:0] baud_cnt;
    reg [9:0] tx_shift; // 1 start, 8 data, 1 stop

    always @(posedge clk or posedge rst) begin
    if (rst) begin
        serial_out <= 1;
        tx_busy    <= 0;
        bit_cnt    <= 0;
        baud_cnt   <= 0;
        tx_shift   <= 10'b1111111111;
    end else begin
        if (start && !tx_busy) begin
            tx_shift   <= {1'b1, data_in, 1'b0}; // stop, data, start
            serial_out <= 0; 
            tx_busy    <= 1;
            bit_cnt    <= 0;
            baud_cnt   <= 1; 
        end else if (tx_busy) begin
            if (baud_cnt == BAUD_DIV - 1) begin
                tx_shift   <= tx_shift >> 1;
                serial_out <= tx_shift[1];
                baud_cnt   <= 0;
                bit_cnt    <= bit_cnt + 1;
                if (bit_cnt == 9)
                    tx_busy <= 0;
            end else begin
                baud_cnt <= baud_cnt + 1;
            end
        end
    end
end


endmodule
