module uart_top(
    input  wire [7:0] p_data,
    input  wire data_valid , 
    input  wire parity_type , 
    input  wire parity_en , 
    output wire tx_out ,
    output wire busy , 
    input wire rst ,
    input wire clk 
);

wire ser_done ;
wire ser_en ;
wire parity_bit ;
wire [2:0] mux_sel ;
wire ser_data ;
wire start_bit ;
wire stop_bit ;

assign start_bit = 1'b0;
assign stop_bit  = 1'b1;



parity_calc parity_calc_instance (
    .p_data(p_data) ,
    .data_valid(data_valid) ,
    .parity_type(parity_type) , 
    .clk(clk) , 
    .rst(rst) ,
    .parity_bit(parity_bit) 
);


serializer serializer_instance (
    .p_data(p_data),
    .ser_en(ser_en),
    .clk(clk),
    .rst(rst),
    .data_valid(data_valid),
    .ser_done(ser_done),
    .ser_data(ser_data)
);


mux mux_instance (
    .mux_sel(mux_sel),
    .start_bit(start_bit),
    .stop_bit(stop_bit),
    .ser_data(ser_data),
    .parity_bit(parity_bit),
    .tx_out(tx_out)
);



fsm fsm_instance (
    .clk(clk),
    .rst(rst),
    .data_valid(data_valid),
    .ser_done(ser_done),
    .parity_en(parity_en),
    .mux_sel(mux_sel),
    .busy(busy),
    .ser_en(ser_en)
);



endmodule 