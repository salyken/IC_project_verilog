module pixelArray(
    input logic      VBN1,
    input logic      RAMP,
    input logic      RESET,
    input logic      ERASE,
    input logic      EXPOSE,

    input logic     READ1,
    input logic     READ2,

    inout [7:0]     DATA1,
    inout [7:0]     DATA2,
    inout [7:0]     DATA3,
    inout [7:0]     DATA4
);
    PIXEL_SENSOR #(.dv_pixel(0.47)) ps1(VBN1, RAMP, RESET, ERASE, EXPOSE, READ1, DATA1);
    PIXEL_SENSOR #(.dv_pixel(0.45)) ps2(VBN1, RAMP, RESET, ERASE, EXPOSE, READ1, DATA2);
    PIXEL_SENSOR #(.dv_pixel(0.52)) ps3(VBN1, RAMP, RESET, ERASE, EXPOSE, READ2, DATA3);
    PIXEL_SENSOR #(.dv_pixel(0.50)) ps4(VBN1, RAMP, RESET, ERASE, EXPOSE, READ2, DATA4);

endmodule