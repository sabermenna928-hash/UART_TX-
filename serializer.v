module serializer (
    input [7:0] p_data ,
    input ser_en,
    input clk ,
    input rst ,
    input data_valid ,
    output reg ser_done,
    output reg ser_data 
);                                                                         
reg [7:0] data_register ; // n5zn feh el input 
reg [2:0] bit_count ;   // 3 bits 3shan 8 arqam counts 1 ---> 8

always @(posedge clk or negedge rst) begin
     ser_done <= 1'b0;
     if (!rst) begin 
     ser_data <= 1'b0;
     ser_done <= 1'b0;
     data_register <= 8'b0;
     bit_count <= 3'b0;
     end
     else if (data_valid) begin 
        data_register <= p_data ;
        bit_count <= 3'b0 ;
        ser_done <= 1'b0 ;
     end
     else  if (ser_en)begin 
        ser_data <= data_register[bit_count] ;
         if (bit_count == 3'b111)begin 
            ser_done <= 1'b1 ;
            bit_count <= 3'b0;
         end 
         else begin 
            bit_count <= bit_count + 1 ; 
            ser_done <= 1'b0 ;
        
         end
     end 
     end 
endmodule

