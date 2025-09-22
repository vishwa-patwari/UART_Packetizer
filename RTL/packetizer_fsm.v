module packetizer_fsm(
    input clk, rst,
    input fifo_empty, tx_busy, data_out_valid,
    input [7:0] fifo_data,
    output reg rd_en, start_tx,
    output reg [7:0] tx_data
);

    reg [1:0] state;
    parameter IDLE = 0, READ = 1, WAIT = 2, START = 3;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            rd_en <= 0;
            start_tx <= 0;
            tx_data <= 8'h00;
        end else begin
            rd_en <= 0;
            start_tx <= 0;
            case (state)
                IDLE:
                    if (!fifo_empty && !tx_busy) state <= READ;

                READ: begin
                    rd_en <= 1;
                    state <= WAIT;
                end

                WAIT:
                    if (data_out_valid) begin
                        tx_data <= fifo_data;
                        state <= START;
                    end

                START: begin
                    start_tx <= 1;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
