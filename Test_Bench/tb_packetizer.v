module tb_packetizer;

    reg clk, rst;
    reg [7:0] data_in;
    reg data_valid;
    wire serial_out, tx_busy;

    
    top_packetizer uut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .data_valid(data_valid),
        .serial_out(serial_out),
        .tx_busy(tx_busy)
    );

    
    always #10 clk = ~clk;

    
    initial begin
        $display("Time\tState\tTX_Data\tStart_TX\tFIFO_Empty\tFIFO_Full\tWr_En\tRd_En\tDataOutValid\tSerial_Out\tTX_Busy");
        $monitor("%0t\t%b\t%h\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b",
                 $time,
                 uut.u_fsm.state,
                 uut.u_fsm.tx_data,
                 uut.u_fsm.start_tx,
                 uut.u_fifo.empty,
                 uut.u_fifo.full,
                 uut.u_fifo.wr_en,
                 uut.u_fifo.rd_en,
                 uut.u_fifo.data_out_valid,
                 serial_out,
                 tx_busy);
    end

    
    initial begin
        clk = 0;
        rst = 1;
        data_in = 8'h00;
        data_valid = 0;

        // Apply reset
        #50 rst = 0;

        // Send 0x55
        #20 data_in = 8'h55; data_valid = 1;
        #20 data_valid = 0;

        // Send 0xAA
        #100 data_in = 8'hAA; data_valid = 1;
        #20 data_valid = 0;

        
        #2000 $finish;
    end

endmodule
