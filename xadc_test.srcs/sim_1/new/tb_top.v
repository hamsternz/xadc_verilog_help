`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.12.2023 21:04:08
// Design Name: 
// Module Name: tb_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_top(
    );
    reg clk;
    wire [15:0] leds;
    
initial begin
   clk = 1'b0;
   forever begin
     #5 clk = ~clk;
   end
 end

 top uut(
    .clk(clk),
    .leds(leds)
 );

endmodule
