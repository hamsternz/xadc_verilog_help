`timescale 1ns / 1ps

module xadc_test(
    input clk,
    output [15:0] sample,
    output reg new_sample
    );

    wire [7:0] alm;
    wire ot;
    wire [15:0] do;
    wire drdy;
    wire busy;
    wire [4:0]channel;
    wire eoc;
    wire eos;
    wire jtagbusy;
    wire jtaglocked;
    wire jtagmodified;
    wire [4:0] muxaddr;
    wire convst      =  1'b1;
    wire convstclk   =  1'b1;
    wire reset       =  1'b0;
    wire [6:0] daddr =  7'b0000000; // 0x00 is the temperature readings
    wire den;
    wire [15:0] di   = 16'b0;

    // These are implicitly wired to the outside world by
    // the XADC's physical connections
    wire vp;
    wire vn;    
    wire [15:0] vauxp_internal;
    wire [15:0] vauxn_internal;
    
    assign den = eoc;
    assign sample = do;

    XADC #(
      // INIT_40 - INIT_42: XADC configuration registers
      .INIT_40(16'h0400),  // Read Temp (ADC input 0), continious mode, bipolar
                           // If you change the analog input, also change the read address!
                           
      .INIT_41(16'h3000),  // Single channel mode
      .INIT_42(16'h0A00),  // Divide clk by 10
      // INIT_48 - INIT_4F: Sequence Registers
      .INIT_48(16'h0000),
      .INIT_49(16'h0000),
      .INIT_4A(16'h0000),
      .INIT_4B(16'h0000),
      .INIT_4C(16'h0000),
      .INIT_4D(16'h0000),
      .INIT_4F(16'h0000),
      .INIT_4E(16'h0000),                // Sequence register 6
      // INIT_50 - INIT_58, INIT5C: Alarm Limit Registers
      .INIT_50(16'h0000),
      .INIT_51(16'h0000),
      .INIT_52(16'h0000),
      .INIT_53(16'h0000),
      .INIT_54(16'h0000),
      .INIT_55(16'h0000),
      .INIT_56(16'h0000),
      .INIT_57(16'h0000),
      .INIT_58(16'h0000),
      .INIT_5C(16'h0000),
      // Simulation attributes: Set for proper simulation behavior
      .SIM_DEVICE("7SERIES"),            // Select target device (values)
      .SIM_MONITOR_FILE("..\\..\\..\\..\\xadc_test.srcs\\sim_1\\xadc_sim.txt")  // Analog simulation data file name
   )
   XADC_inst (
      // ALARMS: 8-bit (each) output: ALM, OT
      .ALM(alm),                   // 8-bit output: Output alarm for temp, Vccint, Vccaux and Vccbram
      .OT(ot),                     // 1-bit output: Over-Temperature alarm
      .DO(do),                     // 16-bit output: DRP output data bus
      .DRDY(drdy),                 // 1-bit output: DRP data ready
      .BUSY(busy),                 // 1-bit output: ADC busy output
      .CHANNEL(channel),           // 5-bit output: Channel selection outputs
      .EOC(eoc),                   // 1-bit output: End of Conversion
      .EOS(eos),                   // 1-bit output: End of Sequence
      
      // STATUS: 1-bit (each) output: XADC status ports
      .JTAGBUSY(jtagbusy),         // 1-bit output: JTAG DRP transaction in progress output
      .JTAGLOCKED(jtaglocked),     // 1-bit output: JTAG requested DRP port lock
      .JTAGMODIFIED(jtagmodified), // 1-bit output: JTAG Write to the DRP has occurred
      .MUXADDR(muxaddr),           // 5-bit output: External MUX channel decode
      // Auxiliary Analog-Input Pairs: 16-bit (each) input: VAUXP[15:0], VAUXN[15:0]

      // CONTROL and CLOCK: 1-bit (each) input: Reset, conversion start and clock inputs
      .CONVST(convst),             // 1-bit input: Convert start input
      .CONVSTCLK(convstclk),       // 1-bit input: Convert start input
      .RESET(reset),               // 1-bit input: Active-high reset
      // Dedicated Analog Input Pair: 1-bit (each) input: VP/VN
      .VN(vn),                     // 1-bit input: N-side analog input
      .VP(vp),                     // 1-bit input: P-side analog input
      .VAUXN(vauxn_internal),      // 16-bit input: N-side auxiliary analog input
      .VAUXP(vauxp_internal),      // 16-bit input: P-side auxiliary analog input

      // Dynamic Reconfiguration Port (DRP): 7-bit (each) input: Dynamic Reconfiguration Ports
      .DADDR(daddr),               // 7-bit input: DRP address bus
      .DCLK(clk),                 // 1-bit input: DRP clock
      .DEN(eoc),                   // 1-bit input: DRP enable signal
      .DI(di),                     // 16-bit input: DRP input data bus
      .DWE(dwe)                    // 1-bit input: DRP write enable
   );

always @(posedge clk) 
    begin
        new_sample <= eoc;
    end
		   
     
endmodule
