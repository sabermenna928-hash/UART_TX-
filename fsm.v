module fsm(
  input clk ,
  input  rst ,
  input data_valid,
  input ser_done ,
  input parity_en , 
  output reg [2:0] mux_sel ,
  output reg busy ,
  output reg ser_en
);
reg [2:0] current_state ;
reg [2:0] next_state ;

localparam idle = 3'b000,
           start = 3'b001,
           data = 3'b010,
           parity = 3'b011,
           stop = 3'b100 ;


always @(posedge clk or negedge rst) begin
    if (!rst)
    current_state <= idle ;
    else 
    current_state <= next_state ;
end

always @(*) begin
    next_state = current_state;
    mux_sel = 3'b000;
    busy = 1'b0 ;
    ser_en = 1'b0;

    case (current_state)
      idle : begin 
        busy = 1'b0 ;
        mux_sel = 3'b000 ;
        ser_en = 1'b0 ;
          if(data_valid) begin 
            next_state = start ;
          end
      end


      start : begin 
         busy = 1'b1 ;
         mux_sel = 3'b001 ; 
         ser_en = 1'b0 ;
         next_state = data ;
      end

      

      data : begin 
        busy = 1'b1 ;
        mux_sel = 3'b010 ; 
        ser_en = 1'b1 ;
        if (ser_done && parity_en) 
        next_state = parity ;
        else if (ser_done && !parity_en)
        next_state = stop ;
      end 



      parity : begin 
        busy = 1'b1 ;
        mux_sel = 3'b011 ;
        ser_en = 1'b0 ;
        next_state = stop ;
      end

      stop :begin 
        busy = 1'b1 ;
        mux_sel = 3'b100 ;
        ser_en = 1'b0 ;
        next_state = idle ; 
      end 

      default : begin
      next_state = idle ;
      mux_sel = 3'b000;
      busy = 1'b0;
      ser_en = 1'b0;
      end 
    endcase
    
end

endmodule 