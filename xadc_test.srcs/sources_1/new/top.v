`timescale 1ns / 1ps

module top(
    input clk,
    output reg [15:0] leds
    );

    wire new_sample;
    wire sample;

    reg [19:0] count = 0;

    // Update the display every 1,000,000 samples
always @(posedge clk)
    begin
        if(new_sample) 
        begin
            if(!count)
                leds = sample;
                count = 20'd999999;
            else
                count = count - 1;
        end
    end
        
xadc_test tester (
    .clk(clk),
    .sample(sample),
    .new_sample(new_sample)
  );    
endmodule
