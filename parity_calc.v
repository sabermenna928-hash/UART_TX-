module parity_calc (
 input [7:0] p_data ,
 input data_valid ,
 input parity_type ,
 input clk ,
 input rst , 
 output reg parity_bit
);

 always @(posedge clk or negedge rst ) begin
    if (!rst)
    parity_bit <= 1'b0;
                                                    
    else if (data_valid)begin
      if(parity_type) //odd
      parity_bit <= ~^p_data ;
      else  //even
      parity_bit <= ^p_data ;
    end
 end

endmodule  



