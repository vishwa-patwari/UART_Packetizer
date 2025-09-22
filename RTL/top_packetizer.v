module top_packetizer (
    input clk, rst,
    input [7:0] data_in,
    input data_valid,
    output serial_out,
    output tx_busy
    
);

    wire [7:0] fifo_data, tx_data;
    wire fifo_empty, fifo_full, data_out_valid;
    wire rd_en, start_tx;

    fifo u_fifo (
        .clk(clk), .rst(rst),
        .wr_en(data_valid), .rd_en(rd_en),
        .din(data_in), .dout(fifo_data),
        .full(fifo_full), .empty(fifo_empty),
        .data_out_valid(data_out_valid)
    );

    packetizer_fsm u_fsm (
        .clk(clk), .rst(rst),
        .fifo_empty(fifo_empty), .tx_busy(tx_busy),
        .data_out_valid(data_out_valid),
        .fifo_data(fifo_data),
        .rd_en(rd_en), .start_tx(start_tx), .tx_data(tx_data)
    );

    uart_tx u_uart (
        .clk(clk), .rst(rst),
        .start(start_tx), .data_in(tx_data),
        .serial_out(serial_out), .tx_busy(tx_busy)
    );

endmodule

