module fifo #(
    parameter DEPTH = 16,
    parameter WIDTH = 8,
    parameter PTR_WIDTH = 4
)(
    input clk, rst,
    input wr_en, rd_en,
    input [WIDTH-1:0] din,
    output reg [WIDTH-1:0] dout,
    output full, empty,
    output reg data_out_valid
);

    reg [WIDTH-1:0] mem [0:DEPTH-1];
    reg [PTR_WIDTH:0] wr_ptr, rd_ptr;

    assign full  = (wr_ptr - rd_ptr) == DEPTH;
    assign empty = (wr_ptr == rd_ptr);

    always @(posedge clk) begin
        if (rst) begin
            wr_ptr <= 0;
        end else if (wr_en && !full) begin
            mem[wr_ptr[PTR_WIDTH-1:0]] <= din;
            wr_ptr <= wr_ptr + 1;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            rd_ptr <= 0;
            data_out_valid <= 0;
        end else if (rd_en && !empty) begin
            dout <= mem[rd_ptr[PTR_WIDTH-1:0]];
            rd_ptr <= rd_ptr + 1;
            data_out_valid <= 1;
        end else begin
            data_out_valid <= 0;
        end
    end

endmodule
