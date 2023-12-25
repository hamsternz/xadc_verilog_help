`timescale 1ns / 1ps

module top(
    input clk,
    output reg [15:0] leds
    );

    wire new_sample;
    wire [15:0] sample;

    reg [19:0] count = 0;

    // Update the display every 1,000,000 samples
always @(posedge clk)
    begin
        if(new_sample) 
        begin
            if(!count) 
            begin
                leds = sample;
                count = 20'd999999;
            end else begin
                count = count - 1;
            end
        end
    end
        
xadc_test tester (
    .clk(clk),
    .sample(sample),
    .new_sample(new_sample)
  );    
endmodule
