`timescale 1ns/1ps

module uart_top_tb;

reg [7:0] p_data_tb;
reg data_valid_tb;
reg parity_type_tb;
reg parity_en_tb;
reg rst_tb;
reg clk_tb;

wire tx_out_tb;
wire busy_tb;

uart_top DUT (
    .p_data(p_data_tb),
    .data_valid(data_valid_tb),
    .parity_type(parity_type_tb),
    .parity_en(parity_en_tb),
    .tx_out(tx_out_tb),
    .busy(busy_tb),
    .rst(rst_tb),
    .clk(clk_tb)
);

always #2.5 clk_tb = ~clk_tb;


initial begin

    clk_tb = 0;
    rst_tb = 0;
    p_data_tb = 0;
    data_valid_tb = 0;
    parity_type_tb = 0;
    parity_en_tb = 0;

    #10;
    rst_tb = 1;

    #10;

    // Test 1: Even parity
    p_data_tb = 8'b1010_0101;
    parity_type_tb = 0;
    parity_en_tb = 1;
    data_valid_tb = 1;

    #5;
    data_valid_tb = 0;

   wait(busy_tb == 1'b1);
wait(busy_tb == 1'b0);

    #10;

    // Test 2: Odd parity
    p_data_tb = 8'b1010_0101;
    parity_type_tb = 1;
    parity_en_tb = 1;
    data_valid_tb = 1;

    #5;
    data_valid_tb = 0;

    @(posedge busy_tb);
    @(negedge busy_tb);

    #10;

    // Test 3: Parity disabled
    p_data_tb = 8'b1100_0011;
    parity_en_tb = 0;
    data_valid_tb = 1;

    #5;
    data_valid_tb = 0;

    @(posedge busy_tb);
    @(negedge busy_tb);

    #10;

    // Test 4: Data valid during busy
    p_data_tb = 8'b1111_0000;
    parity_en_tb = 1;
    parity_type_tb = 0;
    data_valid_tb = 1;

    #5;
    data_valid_tb = 0;

    #15;
    p_data_tb = 8'b0000_1111;
    data_valid_tb = 1;

    #5;
    data_valid_tb = 0;

    @(negedge busy_tb);

    #20;
    $stop;

end

initial begin
    $monitor(
        "Time=%0t p_data=%b valid=%b parity_en=%b parity_type=%b busy=%b tx_out=%b",
        $time, p_data_tb, data_valid_tb, parity_en_tb,
        parity_type_tb, busy_tb, tx_out_tb
    );
end

endmodule