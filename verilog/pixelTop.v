
module pixelTop(

   input logic reset,
   input logic clk,
   inout logic[7:0] pixData1,
   inout logic[7:0] pixData2,
   inout logic[7:0] pixData3,
   inout logic[7:0] pixData4
);

    logic              anaBias1;
    logic              anaRamp;
    logic              anaReset;

    logic            erase;
    logic            expose;
    logic            read1;
    logic            read2;

    logic            convert;

    //wire = _net; unødvendig
    
    pixelArray pa1(anaBias1, anaRamp, anaReset, erase,expose, read1, read2, pixData1, pixData2, pixData3, pixData4);

    pixelState fms1(.clk(clk),.reset(reset),.erase(erase),.expose(expose),.read1(read1),.read2(read2),.convert(convert));

   //------------------------------------------------------------
   // DAC and ADC model
   //------------------------------------------------------------
    logic[7:0] data1; //databus
    logic[7:0] data2;
 
    // If we are to convert, then provide a clock via anaRamp
    // This does not model the real world behavior, as anaRamp would be a voltage from the ADC
    // however, we cheat
    assign anaRamp = convert ? clk : 0; // if convert = 1 then anaramp =  clk, if convert = 0 then anaramp = 0
 
    // During expoure, provide a clock via anaBias1.
    // Again, no resemblence to real world, but we cheat.
    assign anaBias1 = expose ? clk : 0;
 
    // If we're not reading the pixData, then we should drive the bus
    assign pixData1 = read1 ? 8'bZ: data1;
    assign pixData2 = read1 ? 8'bZ: data2;
    assign pixData3 = read2 ? 8'bZ: data1;
    assign pixData4 = read2 ? 8'bZ: data2;
 
    // When convert, then run a analog ramp (via anaRamp clock) and digtal ramp via
    // data bus.
    always_ff @(posedge clk or posedge reset) begin
       if(reset) begin
          data1 =0;
          data2 =0;
       end
       if(convert) begin
          data1 +=  1;
          data2 +=  1;
       end
       else begin
          data1 = 0;
          data2 = 0;
       end
    end // always @ (posedge clk or reset)
 
 
    //------------------------------------------------------------
    // Readout from databus
    //------------------------------------------------------------
    logic [31:0] pixelDataOut;
    always_ff @(posedge clk or posedge reset) begin
       if(reset) begin
          pixelDataOut = 0;
       end
       else begin
          if(read1) begin 
            pixelDataOut[7:0] <= pixData1;
            pixelDataOut[15:8] <= pixData2;
          end
          if(read2) begin
            pixelDataOut[23:16] <= pixData3;
            pixelDataOut[31:24] <= pixData4;
          end 
       end
    end
   
endmodule