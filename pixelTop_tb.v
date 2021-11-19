

module pixelTop_tb;

    //------------------------------------------------------------
   // Testbench clock
   //------------------------------------------------------------
    logic clk =0;
    logic reset =0;
    parameter integer clk_period = 500;
    parameter integer sim_end = clk_period*2400;
    always #clk_period clk=~clk;

    tri[7:0]         pixData1; //  We need this to be a wire, because we're tristating it
    tri[7:0]         pixData2;
    tri[7:0]         pixData3;
    tri[7:0]         pixData4;

    pixelTop pt(.clk(clk), .reset(reset), .pixData1(pixData1), .pixData2(pixData2), .pixData3(pixData3), .pixData4(pixData4));


    //------------------------------------------------------------
   // Testbench stuff
   //------------------------------------------------------------
    initial
    begin
       reset = 1;

       #clk_period  reset=0;

       $dumpfile("pixelTop_tb.vcd");
       $dumpvars(0,pixelTop_tb);

       // reset spike 700us
       #650000; reset = 1; #clk_period;
       reset = 0;

       #sim_end
         $stop;

    end

endmodule