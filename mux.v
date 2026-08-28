module mux (
  input [2:0] mux_sel ,
  input start_bit ,
  input stop_bit,
  input ser_data,
  input parity_bit,
  output reg tx_out
);                                                                  
always @(*) begin
tx_out = 1'b1; 
 case (mux_sel) 

        3'b000: tx_out = 1'b1; // IDLE

        3'b001: tx_out = 1'b0; // START

        3'b010: tx_out = ser_data;  // DATA

        3'b011: tx_out = parity_bit; // PARITY

        3'b100: tx_out = 1'b1; // STOP

 endcase    
end

endmodule